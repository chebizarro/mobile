import 'package:flutter_test/flutter_test.dart';
import 'package:mostro_mobile/data/database/database.dart';
import 'package:mostro_mobile/data/models/order.dart' as model;
import 'package:mostro_mobile/data/models/enums/order_type.dart';
import 'package:mostro_mobile/data/models/enums/status.dart';
import 'package:mostro_mobile/data/repositories/order_repository.dart';

void main() {
  late AppDatabase database;
  late OrderRepository repository;

  setUp(() {
    database = AppDatabase(':memory:');
    repository = OrderRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('OrderRepository', () {
    test('putItem should store an order', () async {
      final order = model.Order(
        id: '1',
        kind: OrderType.buy,
        status: Status.pending,
        amount: 100000,
        fiatCode: 'USD',
        fiatAmount: 50,
        paymentMethod: 'bank_transfer',
        premium: 5,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      await repository.putItem(order.id, order);
      final retrieved = await repository.getItem(order.id);

      expect(retrieved, isNotNull);
      expect(retrieved!.id, equals(order.id));
      expect(retrieved.pubkey, equals(order.pubkey));
      expect(retrieved.type, equals(order.type));
    });

    test('deleteItem should remove an order', () async {
      final order = model.Order(
        id: '1',
        kind: OrderType.buy,
        status: Status.pending,
        amount: 100000,
        fiatCode: 'USD',
        fiatAmount: 50,
        paymentMethod: 'bank_transfer',
        premium: 5,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      await repository.putItem(order.id, order);
      await repository.deleteItem(order.id);
      final retrieved = await repository.getItem(order.id);

      expect(retrieved, isNull);
    });

    test('getAllItems should return all orders', () async {
      final orders = [
        model.Order(
          id: '1',
          kind: OrderType.buy,
          status: Status.pending,
          amount: 100000,
          fiatCode: 'USD',
          fiatAmount: 50,
          paymentMethod: 'bank_transfer',
          premium: 5,
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        ),
        model.Order(
          id: '2',
          kind: OrderType.sell,
          status: Status.success,
          amount: 200000,
          fiatCode: 'EUR',
          fiatAmount: 100,
          paymentMethod: 'cash',
          premium: 3,
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        ),
      ];

      for (final order in orders) {
        await repository.putItem(order.id, order);
      }

      final retrieved = await repository.getAllItems();
      expect(retrieved.length, equals(2));
      expect(retrieved.map((o) => o.id).toList()..sort(),
          equals(orders.map((o) => o.id).toList()..sort()));
    });
  });
}
