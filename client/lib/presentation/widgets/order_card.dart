import 'package:flutter/material.dart';
import 'package:pedidos_app/core/constants/app_colors.dart';
import 'package:pedidos_app/domain/entities/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdateStatus;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onDelete,
    this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildStatusBadge(context),
              const SizedBox(height: 12),
              _buildItemsSummary(context),
              const Divider(height: 24),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido #${order.id.substring(0, 8).toUpperCase()}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(order.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurface.withValues(alpha: 0.6),
                    ),
              ),
            ],
          ),
        ),
        if (onDelete != null || onUpdateStatus != null)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.onSurface),
            onSelected: (value) {
              if (value == 'delete' && onDelete != null) {
                onDelete!();
              } else if (value == 'update' && onUpdateStatus != null) {
                onUpdateStatus!();
              }
            },
            itemBuilder: (context) => [
              if (onUpdateStatus != null)
                const PopupMenuItem(
                  value: 'update',
                  child: Row(
                    children: [
                      Icon(Icons.update, size: 20),
                      SizedBox(width: 8),
                      Text('Actualizar estado'),
                    ],
                  ),
                ),
              if (onDelete != null)
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusLabel = _getStatusLabel(order.status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusLabel,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSummary(BuildContext context) {
    final itemCount = order.items.length;
    final totalItems = order.items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Row(
      children: [
        Icon(
          Icons.shopping_bag_outlined,
          size: 20,
          color: AppColors.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 8),
        Text(
          '$itemCount ${itemCount == 1 ? "producto" : "productos"} ($totalItems unidades)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurface.withValues(alpha: 0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (order.shippingAddress != null && order.shippingAddress!.isNotEmpty)
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.onSurface.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.shippingAddress!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurface.withValues(alpha: 0.5),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        Text(
          '\$${order.totalAmount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
      ],
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.teal;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  String _getStatusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.processing:
        return 'Procesando';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}