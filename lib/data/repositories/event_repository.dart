import 'dart:convert';
import 'package:dart_nostr/nostr/model/event/event.dart' as nostr;
import 'package:mostro_mobile/data/database/database.dart' as db;
import 'package:mostro_mobile/data/repositories/base_repository.dart';

class EventRepository implements BaseRepository<nostr.NostrEvent> {
  final db.AppDatabase _db;

  EventRepository(this._db);

  @override
  Future<void> putItem(String id, nostr.NostrEvent item) async {
    await _db.into(_db.nostrEvents).insertOnConflictUpdate(
          db.NostrEventsCompanion.insert(
            id: id,
            pubkey: item.pubkey,
            content: item.content ?? '',
            createdAt: item.createdAt ?? DateTime.now(),
            kind: item.kind ?? 0,
            sig: item.sig ?? '',
            tags: jsonEncode(item.tags ?? []),
          ),
        );
  }

  @override
  Future<nostr.NostrEvent?> getItem(String id) async {
    final result = await (_db.select(_db.nostrEvents)..where((e) => e.id.equals(id)))
        .getSingleOrNull();
    if (result == null) return null;
    return nostr.NostrEvent(
      id: result.id,
      pubkey: result.pubkey,
      content: result.content,
      createdAt: result.createdAt,
      kind: result.kind,
      tags: List<List<String>>.from(jsonDecode(result.tags)),
      sig: result.sig,
    );
  }

  @override
  Future<bool> hasItem(String id) async {
    final query = _db.select(_db.nostrEvents)..where((e) => e.id.equals(id));
    final result = await query.get();
    return result.isNotEmpty;
  }

  @override
  Future<List<nostr.NostrEvent>> getAllItems() async {
    final results = await _db.select(_db.nostrEvents).get();
    return results
        .map(
          (e) => nostr.NostrEvent(
                id: e.id,
                pubkey: e.pubkey,
                content: e.content,
                createdAt: e.createdAt,
                kind: e.kind,
                tags: List<List<String>>.from(jsonDecode(e.tags)),
                sig: e.sig,
              ),
        )
        .toList();
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_db.delete(_db.nostrEvents)..where((e) => e.id.equals(id))).go();
  }
}
