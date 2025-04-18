import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:mostro_mobile/data/database/database.dart' as db;
import 'package:mostro_mobile/data/models/mostro_message.dart' as model;
import 'package:mostro_mobile/data/models/payload.dart' as model;
import 'package:mostro_mobile/data/models/enums/action.dart' as model;
import 'package:mostro_mobile/data/repositories/base_repository.dart';

class MostroMessageRepository implements BaseRepository<model.MostroMessage<model.Payload>> {
  final db.AppDatabase _db;

  MostroMessageRepository(this._db);

  @override
  Future<void> putItem(String id, model.MostroMessage<model.Payload> item) async {
    await _db.into(_db.mostroMessages).insertOnConflictUpdate(
          db.MostroMessagesCompanion.insert(
            id: id,
            type: item.action.value,
            content: jsonEncode(item.toJson()),
            createdAt: DateTime.now(),
          ),
        );
  }

  @override
  Future<model.MostroMessage<model.Payload>?> getItem(String id) async {
    final result = await (_db.select(_db.mostroMessages)
          ..where((m) => m.id.equals(id)))
        .getSingleOrNull();
    if (result == null) return null;
    final json = jsonDecode(result.content);
    return model.MostroMessage<model.Payload>(
      id: result.id,
      requestId: json['request_id'],
      action: model.Action.fromString(result.type),
      tradeIndex: json['trade_index'],
      payload: json['payload'] != null
          ? model.Payload.fromJson(json['payload'])
          : null,
    );
  }

  @override
  Future<bool> hasItem(String id) async {
    final count = await (_db.selectOnly(_db.mostroMessages)
          ..where(_db.mostroMessages.id.equals(id))
          ..addColumns([_db.mostroMessages.id.count()]))
        .getSingle();
    return (count.read(_db.mostroMessages.id.count()) ?? 0) > 0;
  }

  @override
  Future<List<model.MostroMessage<model.Payload>>> getAllItems() async {
    final results = await _db.select(_db.mostroMessages).get();
    return results
        .map(
          (row) {
            final json = jsonDecode(row.content);
            return model.MostroMessage<model.Payload>(
              id: row.id,
              requestId: json['request_id'],
              action: model.Action.fromString(row.type),
              tradeIndex: json['trade_index'],
              payload: json['payload'] != null
                  ? model.Payload.fromJson(json['payload'])
                  : null,
            );
          },
        )
        .toList();
  }

  @override
  Future<void> deleteItem(String id) async {
    await (_db.delete(_db.mostroMessages)..where((m) => m.id.equals(id))).go();
  }
}
