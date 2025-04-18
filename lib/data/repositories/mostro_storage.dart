import 'package:logger/logger.dart';
import 'package:mostro_mobile/data/models/payload.dart';
import 'package:mostro_mobile/data/models/mostro_message.dart' as model;
import 'package:mostro_mobile/data/database/database.dart';

class MostroStorage {
  final Logger _logger = Logger();
  final AppDatabase _db;

  MostroStorage({required AppDatabase db}) : _db = db;

  /// Save or update any MostroMessage
  Future<void> addMessage(model.MostroMessage message) async {
    final id = messageKey(message);
    try {
      final messageJson = message.toJson();
      await _db.into(_db.mostroMessages).insertOnConflictUpdate(
        MostroMessagesCompanion.insert(
          id: id,
          type: message.action.toString(),
          content: messageJson['payload']?.toString() ?? '',
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            (messageJson['created_at'] as int? ?? 0) * 1000,
          ),
        ),
      );
      _logger.i(
          'Saved message of type ${message.action} with id $id');
    } catch (e, stack) {
      _logger.e(
        'addMessage failed for $id',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Save or update a list of MostroMessages
  Future<void> addMessages(List<model.MostroMessage> messages) async {
    for (final message in messages) {
      await addMessage(message);
    }
  }

  /// Get messages of type T
  Future<List<model.MostroMessage>> getMessagesOfType<T extends Payload>() async {
    try {
      final messages = await (_db.select(_db.mostroMessages)
        ..where((tbl) => tbl.type.equals(T.toString()))).get();
      final List<model.MostroMessage> result = [];
      for (final message in messages) {
        result.add(fromDbMap(message.id, {
          'type': message.type,
          'content': message.content,
          'createdAt': message.createdAt.millisecondsSinceEpoch ~/ 1000,
        }));
      }
      return result;
    } catch (e, stack) {
      _logger.e(
        'getMessagesOfType failed for type $T',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Get a message by its id
  Future<model.MostroMessage?> getMessageById<T extends Payload>(String id) async {
    try {
      final message = await (_db.select(_db.mostroMessages)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
      if (message == null) {
        return null;
      }
      return fromDbMap(id, {
        'type': message.type,
        'content': message.content,
        'createdAt': message.createdAt.millisecondsSinceEpoch ~/ 1000,
      });
    } catch (e, stack) {
      _logger.e(
        'getMessageById failed for $id',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Get all messages
  Future<List<model.MostroMessage>> getAllMessages() async {
    try {
      final messages = await _db.select(_db.mostroMessages).get();
      final List<model.MostroMessage> result = [];
      for (final message in messages) {
        result.add(fromDbMap(message.id, {
          'type': message.type,
          'content': message.content,
          'createdAt': message.createdAt.millisecondsSinceEpoch ~/ 1000,
        }));
      }
      return result;
    } catch (e, stack) {
      _logger.e(
        'getAllMessages failed',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Delete messages by their ids
  Future<void> deleteMessages(List<String> ids) async {
    try {
      await (_db.delete(_db.mostroMessages)..where((tbl) => tbl.id.isIn(ids))).go();
      _logger.i('Messages ${ids.join(', ')} deleted from DB');
    } catch (e, stack) {
      _logger.e(
        'deleteMessages failed for ${ids.join(', ')}',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Delete a message by ID
  Future<void> deleteMessage<T extends Payload>(String orderId) async {
    final id = '${T.runtimeType}:$orderId';
    try {
      await (_db.delete(_db.mostroMessages)..where((tbl) => tbl.id.equals(id))).go();
      _logger.i('Message $id deleted from DB');
    } catch (e, stack) {
      _logger.e(
        'deleteMessage failed for $id',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Delete all messages
  Future<void> deleteAllMessages() async {
    try {
      await _db.delete(_db.mostroMessages).go();
      _logger.i('All messages deleted from DB');
    } catch (e, stack) {
      _logger.e(
        'deleteAllMessages failed',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Delete all messages by Id regardless of type
  Future<void> deleteAllMessagesById(String orderId) async {
    try {
      final messages = await getMessagesForId(orderId);
      for (var m in messages) {
        final id = messageKey(m);
        try {
          await deleteMessage(id);
          _logger.i('Message $id deleted from DB');
        } catch (e, stack) {
          _logger.e('deleteMessage failed for $id',
              error: e, stackTrace: stack);
          rethrow;
        }
      }
      _logger.i('All messages for order: $orderId deleted');
    } catch (e, stack) {
      _logger.e('deleteAllMessagesForId failed', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Filter messages by tradeKeyPublic
  Future<List<model.MostroMessage>> getMessagesForId(String orderId) async {
    final messages = await getAllMessages();
    return messages.where((m) => m.id == orderId).toList();
  }

  model.MostroMessage fromDbMap(String id, Map<String, dynamic> map) {
    return model.MostroMessage.fromJson(map);
  }

  Map<String, dynamic> toDbMap(model.MostroMessage message) {
    return message.toJson();
  }

  String messageKey(model.MostroMessage message) {
    return (message.requestId ?? message.id ?? '').toString();
  }
}
