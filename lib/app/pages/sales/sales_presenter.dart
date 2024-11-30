import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_sales_repository.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/create_order.dart';
import '../../../domain/usecases/get_orders.dart';

class SalesPresenter extends Presenter {
  late Function(List<Order>) getOrdersOnNext;
  late Function() getOrdersOnComplete;
  late Function(dynamic) getOrdersOnError;

  final GetOrdersUseCase getOrdersUseCase;
  final CreateOrderUseCase createOrderUseCase;

  SalesPresenter()
      : getOrdersUseCase = GetOrdersUseCase(DataSalesRepository()),
        createOrderUseCase = CreateOrderUseCase(DataSalesRepository());

  void getOrders() {
    getOrdersUseCase.execute(_GetOrdersObserver(this));
  }

  void createOrder(Order order) {
    createOrderUseCase.execute(_CreateOrderObserver(this), order);
  }

  @override
  void dispose() {
    // Limpiamos los casos de uso para evitar pérdidas de memoria
    getOrdersUseCase.dispose();
    createOrderUseCase.dispose();
  }
}

class _GetOrdersObserver implements Observer<List<Order>> {
  final SalesPresenter presenter;
  _GetOrdersObserver(this.presenter);

  @override
  void onComplete() => presenter.getOrdersOnComplete();

  @override
  void onError(e) => presenter.getOrdersOnError(e);

  @override
  void onNext(List<Order>? response) {
    if (response != null) presenter.getOrdersOnNext(response);
  }
}

class _CreateOrderObserver implements Observer<void> {
  final SalesPresenter presenter;
  _CreateOrderObserver(this.presenter);

  @override
  void onComplete() {
    // Handle completion
  }

  @override
  void onError(e) {
    // Handle error
  }

  @override
  void onNext(_) {
    // Handle success
  }
}
