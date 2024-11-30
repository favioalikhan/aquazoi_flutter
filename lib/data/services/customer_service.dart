import '../datasources/database.dart';
import '../models/customer.dart';

class CustomerService {
  final AppDatabase db;

  CustomerService(this.db);

  Future<List<Customer>> searchCustomers(String query) async {
    if (query.isEmpty) return [];

    final matches = await (db.select(db.customers)
          ..where((c) => c.name.like('%$query%'))
          ..limit(5))
        .get();

    return matches
        .map((c) => Customer(
              name: c.name,
              phone: c.phone,
              address: c.address,
              cluster: c.cluster,
            ))
        .toList();
  }

  Future<Customer> createCustomer(Customer customer) async {
    final customerId = await db.into(db.customers).insert(
          CustomersCompanion.insert(
            name: customer.name,
            phone: customer.phone,
            address: customer.address,
            cluster: customer.cluster,
          ),
        );

    return customer;
  }
}
