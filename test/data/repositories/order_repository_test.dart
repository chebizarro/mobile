import 'package:flutter_test/flutter_test.dart';
import 'package:mostro_mobile/data/database/database.dart';
import 'package:mostro_mobile/data/models/enums/order_type.dart';
import 'package:mostro_mobile/data/models/enums/status.dart';
import 'package:mostro_mobile/data/models/order.dart' as model;
import 'package:mostro_mobile/data/repositories/order_repository.dart';

void main() {
  late AppDatabase db;
  late OrderRepository repository;

  setUp(() {
    db = AppDatabase(':memory:');
    repository = OrderRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('putItem should insert a new order', () async {
    final order = model.Order(
      id: '1',
      kind: OrderType.buy,
      status: Status.pending,
      amount: 100,
      fiatCode: 'USD',
      minAmount: 50,
      maxAmount: 150,
      fiatAmount: 1000,
      paymentMethod: 'bank',
      premium: 5,
      masterBuyerPubkey: 'buyer123',
      masterSellerPubkey: 'seller123',
      buyerTradePubkey: 'trade123',
      sellerTradePubkey: 'trade456',
      buyerInvoice: 'invoice123',
      createdAt: 1234567890,
      expiresAt: 1234567899,
      buyerToken: 123,
      sellerToken: 456,
    );

    await repository.putItem(order.id!, order);
    final result = await repository.getItem(order.id!);

    expect(result, isNotNull);
    expect(result!.id, equals(order.id));
    expect(result.kind, equals(order.kind));
    expect(result.status, equals(order.status));
    expect(result.amount, equals(order.amount));
    expect(result.fiatCode, equals(order.fiatCode));
    expect(result.minAmount, equals(order.minAmount));
    expect(result.maxAmount, equals(order.maxAmount));
    expect(result.fiatAmount, equals(order.fiatAmount));
    expect(result.paymentMethod, equals(order.paymentMethod));
    expect(result.premium, equals(order.premium));
    expect(result.masterBuyerPubkey, equals(order.masterBuyerPubkey));
    expect(result.masterSellerPubkey, equals(order.masterSellerPubkey));
    expect(result.buyerTradePubkey, equals(order.buyerTradePubkey));
    expect(result.sellerTradePubkey, equals(order.sellerTradePubkey));
    expect(result.buyerInvoice, equals(order.buyerInvoice));
    expect(result.createdAt, equals(order.createdAt));
    expect(result.expiresAt, equals(order.expiresAt));
    expect(result.buyerToken, equals(order.buyerToken));
    expect(result.sellerToken, equals(order.sellerToken));
  });

  test('getAllItems should return all orders', () async {
    final orders = [
      model.Order(
        id: '1',
        kind: OrderType.buy,
        status: Status.pending,
        amount: 100,
        fiatCode: 'USD',
        fiatAmount: 1000,
        paymentMethod: 'bank',
        premium: 5,
      ),
      model.Order(
        id: '2',
        kind: OrderType.sell,
        status: Status.active,
        amount: 200,
        fiatCode: 'EUR',
        fiatAmount: 2000,
        paymentMethod: 'card',
        premium: 3,
      ),
    ];

    for (final order in orders) {
      await repository.putItem(order.id!, order);
    }

    final results = await repository.getAllItems();
    expect(results.length, equals(orders.length));

    for (var i = 0; i < orders.length; i++) {
      expect(results[i].id, equals(orders[i].id));
      expect(results[i].kind, equals(orders[i].kind));
      expect(results[i].status, equals(orders[i].status));
      expect(results[i].amount, equals(orders[i].amount));
      expect(results[i].fiatCode, equals(orders[i].fiatCode));
      expect(results[i].fiatAmount, equals(orders[i].fiatAmount));
      expect(results[i].paymentMethod, equals(orders[i].paymentMethod));
      expect(results[i].premium, equals(orders[i].premium));
    }
  });
}
