import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

enum OrdersViewState { initial, loading, loaded, error }

class OrdersState extends Equatable {
  final OrdersViewState viewState;
  final List<Order> orders;
  final String? errorMessage;
  final Order? selectedOrder;
  final bool isCreatingOrder;
  final bool isUpdatingOrder;
  final bool isDeletingOrder;

  const OrdersState({
    this.viewState = OrdersViewState.initial,
    this.orders = const [],
    this.errorMessage,
    this.selectedOrder,
    this.isCreatingOrder = false,
    this.isUpdatingOrder = false,
    this.isDeletingOrder = false,
  });

  OrdersState copyWith({
    OrdersViewState? viewState,
    List<Order>? orders,
    String? errorMessage,
    Order? selectedOrder,
    bool? isCreatingOrder,
    bool? isUpdatingOrder,
    bool? isDeletingOrder,
  }) {
    return OrdersState(
      viewState: viewState ?? this.viewState,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      isUpdatingOrder: isUpdatingOrder ?? this.isUpdatingOrder,
      isDeletingOrder: isDeletingOrder ?? this.isDeletingOrder,
    );
  }

  @override
  List<Object?> get props => [
        viewState,
        orders,
        errorMessage,
        selectedOrder,
        isCreatingOrder,
        isUpdatingOrder,
        isDeletingOrder,
      ];
}

class OrdersViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;

  OrdersState _state = const OrdersState();
  OrdersState get state => _state;

  OrdersViewModel(this._orderRepository);

  Future<void> loadOrders() async {
    _state = _state.copyWith(viewState: OrdersViewState.loading);
    notifyListeners();

    try {
      final orders = await _orderRepository.getOrders();
      _state = _state.copyWith(
        viewState: OrdersViewState.loaded,
        orders: orders,
        errorMessage: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        viewState: OrdersViewState.error,
        errorMessage: _extractErrorMessage(e),
      );
    }
    notifyListeners();
  }

  Future<void> loadOrderById(String orderId) async {
    _state = _state.copyWith(viewState: OrdersViewState.loading);
    notifyListeners();

    try {
      final order = await _orderRepository.getOrderById(orderId);
      _state = _state.copyWith(
        viewState: OrdersViewState.loaded,
        selectedOrder: order,
        errorMessage: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        viewState: OrdersViewState.error,
        errorMessage: _extractErrorMessage(e),
      );
    }
    notifyListeners();
  }

  Future<bool> createOrder(Order order) async {
    _state = _state.copyWith(isCreatingOrder: true);
    notifyListeners();

    try {
      final createdOrder = await _orderRepository.createOrder(order);
      final updatedOrders = [..._state.orders, createdOrder];
      _state = _state.copyWith(
        orders: updatedOrders,
        isCreatingOrder: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isCreatingOrder: false,
        errorMessage: _extractErrorMessage(e),
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateOrder(Order order) async {
    _state = _state.copyWith(isUpdatingOrder: true);
    notifyListeners();

    try {
      final updatedOrder = await _orderRepository.updateOrder(order);
      final updatedOrders = _state.orders.map((o) {
        return o.id == updatedOrder.id ? updatedOrder : o;
      }).toList();
      _state = _state.copyWith(
        orders: updatedOrders,
        selectedOrder: updatedOrder,
        isUpdatingOrder: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isUpdatingOrder: false,
        errorMessage: _extractErrorMessage(e),
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    _state = _state.copyWith(isDeletingOrder: true);
    notifyListeners();

    try {
      await _orderRepository.deleteOrder(orderId);
      final updatedOrders =
          _state.orders.where((o) => o.id != orderId).toList();
      _state = _state.copyWith(
        orders: updatedOrders,
        isDeletingOrder: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isDeletingOrder: false,
        errorMessage: _extractErrorMessage(e),
      );
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _state = _state.copyWith(errorMessage: null);
    notifyListeners();
  }

  void clearSelectedOrder() {
    _state = _state.copyWith(selectedOrder: null);
    notifyListeners();
  }

  String _extractErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'Error de conexión. Verifica tu conexión a internet.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'La solicitud tardó demasiado. Intenta de nuevo.';
    } else if (error.toString().contains('UnauthorizedException')) {
      return 'Sesión expirada. Inicia sesión nuevamente.';
    } else if (error.toString().contains('ForbiddenException')) {
      return 'No tienes permiso para realizar esta acción.';
    } else if (error.toString().contains('NotFoundException')) {
      return 'Recurso no encontrado.';
    } else if (error.toString().contains('ApiException')) {
      final messageMatch =
          RegExp(r'message:\s*"?([^"]+)"?').firstMatch(error.toString());
      return messageMatch?.group(1) ?? 'Error en la operación. Intenta de nuevo.';
    }
    return 'Ocurrió un error inesperado. Intenta de nuevo.';
  }

  List<Order> get filteredOrders {
    return _state.orders;
  }

  double get totalOrdersAmount {
    return _state.orders.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  int get pendingOrdersCount {
    return _state.orders.where((o) => o.status == 'pendiente').length;
  }

  int get completedOrdersCount {
    return _state.orders.where((o) => o.status == 'completado').length;
  }
}