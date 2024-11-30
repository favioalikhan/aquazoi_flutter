import '../../domain/entities/order.dart';
import '../../domain/repositories/sales_repository.dart';

class DataSalesRepository implements SalesRepository {
  final List<Order> _orders =
      []; // En una app real, esto sería una base de datos

  @override
  Future<List<Order>> getOrders() async {
    return _orders;
  }

  @override
  Future<void> createOrder(Order order) async {
    _orders.add(order);
  }

  @override
  Future<void> updateOrder(Order order) async {
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      _orders[index] = order;
    }
  }
}
