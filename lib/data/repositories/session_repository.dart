import 'package:drift/drift.dart';
import 'package:mostro_mobile/data/database/database.dart' as db;
import 'package:mostro_mobile/data/models/session.dart' as model;
import 'package:mostro_mobile/data/models/enums/role.dart';
import 'package:mostro_mobile/data/models/peer.dart';
import 'package:mostro_mobile/data/repositories/base_repository.dart';
import 'package:mostro_mobile/features/key_manager/key_manager.dart';

class SessionRepository implements BaseRepository<model.Session> {
  final db.AppDatabase _db;
  final KeyManager keyManager;

  SessionRepository(this._db, {required this.keyManager});

  @override
  Future<void> putItem(String id, model.Session item) async {
    await _db
        .into(_db.sessions)
        .insert(
          db.SessionsCompanion.insert(
            id: id,
            pubkey: item.masterKey.public,
            isActive: true,
            createdAt: item.startTime,
            keyIndex: item.keyIndex,
            fullPrivacy: item.fullPrivacy,
            orderId: Value(item.orderId),
            role: Value(item.role?.toString()),
            peerPublicKey: Value(item.peer?.publicKey),
          ),
        );
  }

  @override
  Future<model.Session?> getItem(String id) async {
    final result = await (_db.select(_db.sessions)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (result == null) return null;
    final masterKey = keyManager.masterKeyPair!;
    final tradeKey = await keyManager.deriveTradeKeyFromIndex(result.keyIndex);
    final peer = result.peerPublicKey != null ? Peer(publicKey: result.peerPublicKey!) : null;
    return model.Session(
      masterKey: masterKey,
      tradeKey: tradeKey,
      keyIndex: result.keyIndex,
      fullPrivacy: result.fullPrivacy,
      startTime: result.createdAt,
      orderId: result.orderId,
      role: result.role != null ? Role.fromString(result.role!) : null,
      peer: peer,
    );
  }

  @override
  Future<bool> hasItem(String id) async {
    final count = await (_db.selectOnly(_db.sessions)
          ..where(_db.sessions.id.equals(id))
          ..addColumns([_db.sessions.id.count()]))
        .getSingle();
    return (count.read(_db.sessions.id.count()) ?? 0) > 0;
  }

  Future<bool> hasItems() async {
    final count = await (_db.selectOnly(_db.sessions)
          ..addColumns([_db.sessions.id.count()]))
        .getSingle();
    return (count.read(_db.sessions.id.count()) ?? 0) > 0;
  }

  @override
  Future<List<model.Session>> getAllItems() async {
    final results = await _db.select(_db.sessions).get();
    final masterKey = keyManager.masterKeyPair!;
    
    return Future.wait(results.map((row) async {
      final tradeKey = await keyManager.deriveTradeKeyFromIndex(row.keyIndex);
      final peer = row.peerPublicKey != null ? Peer(publicKey: row.peerPublicKey!) : null;
      return model.Session(
        masterKey: masterKey,
        tradeKey: tradeKey,
        keyIndex: row.keyIndex,
        fullPrivacy: row.fullPrivacy,
        startTime: row.createdAt,
        orderId: row.orderId,
        role: row.role != null ? Role.fromString(row.role!) : null,
        peer: peer,
      );
    }));
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_db.delete(_db.sessions)..where((s) => s.id.equals(id))).go();
  }
}
