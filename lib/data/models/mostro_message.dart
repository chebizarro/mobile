import 'dart:convert';

import 'package:mostro_mobile/data/models/enums/action.dart';
import 'package:mostro_mobile/data/models/content.dart';
import 'package:mostro_mobile/services/mostro_service.dart';

class MostroMessage<T extends Content> {
  final int version = mostroVersion;
  final String? requestId;
  final Action action;
  T? content;

  MostroMessage({required this.action, required this.requestId, this.content});

  Map<String, dynamic> toJson() {
    return {
      'order': {
        'version': mostroVersion,
        'id': requestId,
        'action': action.value,
        'content': content?.toJson(),
      },
    };
  }

  factory MostroMessage.deserialized(String data) {
    try {
      final decoded = jsonDecode(data);
      final event = decoded as Map<String, dynamic>;
      final order = event['order'] != null
          ? event['order'] as Map<String, dynamic>
          : throw FormatException('Missing order object');

      final action = order['action'] != null
          ? Action.fromString(order['action'])
          : throw FormatException('Missing action field');

      final id = order['id'] != null
          ? order['id'] as String?
          : throw FormatException('Missing id field');

      final content = order['content'] != null ? Content.fromJson(event['order']['content']) as T : null;

      return MostroMessage<T>(
        action: action,
        requestId: id,
        content: content,
      );
    } catch (e) {
      throw FormatException('Failed to deserialize MostroMessage: $e');
    }
  }
}
