import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:mostro_mobile/data/models/session.dart';

class SecureStorageManager {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  Timer? _cleanupTimer;
  final int sessionExpirationHours = 48;

  SecureStorageManager() {
    _initializeCleanup();
  }

  Future<void> saveSession(Session session) async {
    String sessionJson = jsonEncode(session.toJson());
    await _secureStorage.write(key: session.sessionId, value: sessionJson);
  }

  Future<Session?> loadSession(String sessionId) async {
    String? sessionJson = await _secureStorage.read(key: sessionId);
    if (sessionJson != null) {
      return Session.fromJson(jsonDecode(sessionJson));
    }
    return null;
  }

  Future<void> deleteSession(String sessionId) async {
    await _secureStorage.delete(key: sessionId);
  }

  Future<void> clearExpiredSessions() async {
    final allSessions = await _secureStorage.readAll();
    final now = DateTime.now();
    for (var entry in allSessions.entries) {
      final session = Session.fromJson(jsonDecode(entry.value));
      if (now.difference(session.startTime).inHours >= sessionExpirationHours) {
        await _secureStorage.delete(key: entry.key);
      }
    }
  }

  void _initializeCleanup() {
    clearExpiredSessions();
    _cleanupTimer = Timer.periodic(Duration(minutes: 30), (timer) {
      clearExpiredSessions();
    });
  }

  void dispose() {
    _cleanupTimer?.cancel();
  }
}
