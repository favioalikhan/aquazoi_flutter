import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_sales_repository.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/create_order.dart';
import '../../../domain/usecases/get_orders.dart';
import 'sales_presenter.dart';

class SalesController extends Controller {
  final GetOrdersUseCase getOrdersUseCase;
  final CreateOrderUseCase createOrderUseCase;
  final SalesPresenter presenter;

  List<Order> orders = [
    Order(
        id: 1,
        clientName: 'Tienda ABC',
        phone: '123-456-7890',
        product: 'Agua 500ml x 24',
        quantity: 10,
        status: 'En proceso',
        deliveryDate: DateTime.now().add(const Duration(days: 2))),
    Order(
        id: 2,
        clientName: 'Restaurante XYZ',
        phone: '098-765-4321',
        product: 'Jugo Naranja 1L x 12',
        quantity: 5,
        status: 'Enviado',
        deliveryDate: DateTime.now().add(const Duration(days: 1))),
    Order(
        id: 3,
        clientName: 'Hotel 123',
        phone: '555-123-4567',
        product: 'Agua con gas 750ml x 15',
        quantity: 8,
        status: 'Entregado',
        deliveryDate: DateTime.now()),
  ];

  SalesController()
      : presenter = SalesPresenter(),
        getOrdersUseCase = GetOrdersUseCase(DataSalesRepository()),
        createOrderUseCase = CreateOrderUseCase(DataSalesRepository());

  @override
  void initListeners() {
    presenter.getOrdersOnNext = (List<Order> response) {
      orders = response;
      refreshUI();
    };
    presenter.getOrdersOnComplete = () {
      // Handle completion
    };
    presenter.getOrdersOnError = (e) {
      // Handle error
    };
  }

  void addOrder(Order order) {
    orders.add(order);
  }

  void removeOrder(Order order) {
    orders.remove(order);
  }

  void updateOrder(Order order) {
    final index = orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      orders[index] = order;
    }
  }
}
