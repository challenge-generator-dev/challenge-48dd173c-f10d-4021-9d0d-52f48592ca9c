import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets/order_card.dart';
import '../widgets/loading_indicator.dart';
import '../../core/constants/app_colors.dart';
import 'order_detail_screen.dart';
import 'create_order_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersViewModel()..loadOrders(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'Mis Pedidos',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.onPrimary),
              onPressed: () {
                context.read<OrdersViewModel>().loadOrders();
              },
            ),
          ],
        ),
        body: BlocBuilder<OrdersViewModel, OrdersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingIndicator();
            }

            if (state.error != null) {
              return _buildErrorView(context, state.error!);
            }

            if (state.orders.isEmpty) {
              return _buildEmptyView(context);
            }

            return _buildOrdersList(context, state.orders);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToCreateOrder(context),
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          icon: const Icon(Icons.add),
          label: const Text('Nuevo Pedido'),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar pedidos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<OrdersViewModel>().loadOrders();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay pedidos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aún no has realizado ningún pedido.\n¡Crea tu primer pedido ahora!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _navigateToCreateOrder(context),
              icon: const Icon(Icons.add),
              label: const Text('Crear Pedido'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrdersViewModel>().loadOrders();
      },
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: OrderCard(
              order: order,
              onTap: () => _navigateToOrderDetail(context, order.id),
            ),
          );
        },
      ),
    );
  }

  void _navigateToOrderDetail(BuildContext context, String orderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(orderId: orderId),
      ),
    ).then((_) {
      context.read<OrdersViewModel>().loadOrders();
    });
  }

  void _navigateToCreateOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateOrderScreen(),
      ),
    ).then((_) {
      context.read<OrdersViewModel>().loadOrders();
    });
  }
}