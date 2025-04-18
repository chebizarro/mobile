import 'package:drift/drift.dart';
import 'package:mostro_mobile/data/database/database.dart' as db;
import 'package:mostro_mobile/data/models/order.dart';
import 'package:mostro_mobile/data/repositories/base_repository.dart';

class OrderRepository implements BaseRepository<Order> {
  final db.AppDatabase _db;

  OrderRepository(this._db);

  @override
  Future<void> putItem(String id, Order item) async {
    await _db.into(_db.orders).insertOnConflictUpdate(
          db.OrdersCompanion.insert(
            id: id,
            kind: item.kind,
            status: item.status,
            amount: item.amount,
            fiatCode: item.fiatCode,
            minAmount: Value(item.minAmount),
            maxAmount: Value(item.maxAmount),
            fiatAmount: item.fiatAmount,
            paymentMethod: item.paymentMethod,
            premium: item.premium,
            masterBuyerPubkey: Value(item.masterBuyerPubkey),
            masterSellerPubkey: Value(item.masterSellerPubkey),
            buyerTradePubkey: Value(item.buyerTradePubkey),
            sellerTradePubkey: Value(item.sellerTradePubkey),
            buyerInvoice: Value(item.buyerInvoice),
            createdAt: Value(item.createdAt),
            expiresAt: Value(item.expiresAt),
            buyerToken: Value(item.buyerToken),
            sellerToken: Value(item.sellerToken),
          ),
        );
  }

  @override
  Future<Order?> getItem(String id) async {
    final result = await (_db.select(_db.orders)..where((o) => o.id.equals(id)))
        .getSingleOrNull();
    if (result == null) return null;
    return Order(
      id: result.id,
      kind: result.kind,
      status: result.status,
      amount: result.amount,
      fiatCode: result.fiatCode,
      minAmount: result.minAmount,
      maxAmount: result.maxAmount,
      fiatAmount: result.fiatAmount,
      paymentMethod: result.paymentMethod,
      premium: result.premium,
      masterBuyerPubkey: result.masterBuyerPubkey,
      masterSellerPubkey: result.masterSellerPubkey,
      buyerTradePubkey: result.buyerTradePubkey,
      sellerTradePubkey: result.sellerTradePubkey,
      buyerInvoice: result.buyerInvoice,
      createdAt: result.createdAt,
      expiresAt: result.expiresAt,
      buyerToken: result.buyerToken,
      sellerToken: result.sellerToken,
    );
  }

  @override
  Future<bool> hasItem(String id) async {
    final result = await (_db.selectOnly(_db.orders)
          ..where(_db.orders.id.equals(id)))
        .getSingleOrNull();
    return result != null;
  }

  @override
  Future<List<Order>> getAllItems() async {
    final results = await _db.select(_db.orders).get();
    return results
        .map(
          (row) => Order(
            id: row.id,
            kind: row.kind,
            status: row.status,
            amount: row.amount,
            fiatCode: row.fiatCode,
            minAmount: row.minAmount,
            maxAmount: row.maxAmount,
            fiatAmount: row.fiatAmount,
            paymentMethod: row.paymentMethod,
            premium: row.premium,
            masterBuyerPubkey: row.masterBuyerPubkey,
            masterSellerPubkey: row.masterSellerPubkey,
            buyerTradePubkey: row.buyerTradePubkey,
            sellerTradePubkey: row.sellerTradePubkey,
            buyerInvoice: row.buyerInvoice,
            createdAt: row.createdAt,
            expiresAt: row.expiresAt,
            buyerToken: row.buyerToken,
            sellerToken: row.sellerToken,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_db.delete(_db.orders)..where((o) => o.id.equals(id))).go();
  }
}
