import 'package:drift/drift.dart';
import 'package:mostro_mobile/data/database/database.dart';
import 'package:mostro_mobile/data/models/session.dart' as model;
import 'package:mostro_mobile/features/key_manager/key_manager.dart';

class SessionStorage {
  final KeyManager _keyManager;
  final AppDatabase _db;

  SessionStorage(this._keyManager, {required AppDatabase db}) : _db = db;

  Future<int> putSession(model.Session session) async {
    return await _db.into(_db.sessions).insert(
      SessionsCompanion.insert(
        id: session.masterKey.public,
        pubkey: session.masterKey.public,
        isActive: true,
        keyIndex: session.keyIndex,
        fullPrivacy: session.fullPrivacy,
        createdAt: session.startTime,
      ),
    );
  }

  Future<model.Session?> getSession(String sessionId) async {
    final result = await (_db.select(_db.sessions)..where((s) => s.id.equals(sessionId))).getSingleOrNull();
    if (result == null) return null;
    
    final masterKey = _keyManager.masterKeyPair!;
    final tradeKey = await _keyManager.deriveTradeKeyFromIndex(result.keyIndex);

    // Validate that the derived trade key matches what was stored
    if (result.pubkey != tradeKey.public) {
      throw Exception('Derived trade key does not match stored session record');
    }

    return model.Session(
      masterKey: masterKey,
      tradeKey: tradeKey,
      keyIndex: result.keyIndex,
      fullPrivacy: result.fullPrivacy,
      startTime: result.createdAt,
    );
  }

  Future<List<model.Session>> getAllSessions() async {
    final results = await _db.select(_db.sessions).get();
    final masterKey = _keyManager.masterKeyPair!;
    
    return Future.wait(results.map((r) async {
      final tradeKey = await _keyManager.deriveTradeKeyFromIndex(r.keyIndex);
      
      // Validate that the derived trade key matches what was stored
      if (r.pubkey != tradeKey.public) {
        throw Exception('Derived trade key does not match stored session record');
      }
      
      return model.Session(
        masterKey: masterKey,
        tradeKey: tradeKey,
        keyIndex: r.keyIndex,
        fullPrivacy: r.fullPrivacy,
        startTime: r.createdAt,
      );
    }));
  }

  Future<int> deleteSession(String sessionId) async {
    return await (_db.delete(_db.sessions)..where((s) => s.id.equals(sessionId))).go();
  }

  Future<int> deleteAllItems() async {
    return await (_db.delete(_db.sessions)).go();
  }

  Future<int> deleteExpiredSessions(int sessionExpirationHours) async {
    final expirationTime = DateTime.now().subtract(Duration(hours: sessionExpirationHours));
    return await (_db.delete(_db.sessions)..where((s) => s.createdAt.isSmallerThan(Variable(expirationTime)))).go();
  }

}
