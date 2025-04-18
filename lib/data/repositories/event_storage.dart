import 'dart:async';
import 'dart:convert';
import 'package:dart_nostr/nostr/model/event/event.dart' as nostr;
import 'package:mostro_mobile/data/database/database.dart';
import 'package:rxdart/rxdart.dart';

class EventStorage {
  final AppDatabase _db;
  final _updateController = BehaviorSubject<void>.seeded(null);

  EventStorage({required AppDatabase db}) : _db = db;

  // Call this when an event is stored in the background
  void notifyBackgroundUpdate() {
    _updateController.add(null);
  }

  Future<void> putItem(String id, nostr.NostrEvent event) async {
    await _db.into(_db.nostrEvents).insertOnConflictUpdate(
      NostrEventsCompanion.insert(
        id: id,
        pubkey: event.pubkey,
        content: event.content ?? '',
        createdAt: event.createdAt ?? DateTime.now(),
        kind: event.kind ?? 0,
        sig: event.sig ?? '',
        tags: jsonEncode(event.tags ?? []),
      ),
    );
  }

  Future<nostr.NostrEvent?> getItem(String id) async {
    final result = await (_db.select(_db.nostrEvents)..where((e) => e.id.equals(id))).getSingleOrNull();
    if (result == null) return null;
    
    return nostr.NostrEvent(
      id: result.id,
      pubkey: result.pubkey,
      content: result.content,
      createdAt: result.createdAt,
      kind: result.kind,
      sig: result.sig,
      tags: List<List<String>>.from(jsonDecode(result.tags)),
    );
  }

  Stream<List<nostr.NostrEvent>> watch() {
    // Merge the database watch stream with the background update notifications
    return _updateController.stream
        .startWith(null)
        .switchMap((_) => _db.select(_db.nostrEvents).watch())
        .map((events) => events.map(
      (e) => nostr.NostrEvent(
        id: e.id,
        pubkey: e.pubkey,
        content: e.content,
        createdAt: e.createdAt,
        kind: e.kind,
        sig: e.sig,
        tags: List<List<String>>.from(jsonDecode(e.tags)),
      ),
    ).toList());
  }
}
