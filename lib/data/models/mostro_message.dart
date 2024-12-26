import 'dart:convert';
import 'package:mostro_mobile/app/config.dart';
import 'package:mostro_mobile/data/models/enums/action.dart';
import 'package:mostro_mobile/data/models/payload.dart';

class MostroMessage<T extends Payload> {
  String? requestId;
  final Action action;
  int? tradeIndex;
  T? _payload;

  MostroMessage(
      {required this.action, this.requestId, T? payload, this.tradeIndex})
      : _payload = payload;

  Map<String, dynamic> toJson() {
    final jMap = {
      'order': {
        'version': Config.mostroVersion,
        'id': requestId,
        'action': action.value,
        'payload': _payload?.toJson(),
      },
    };
    if (tradeIndex != null) {
      jMap['order']?['trade_index'] = tradeIndex;
    }
    return jMap;
  }

  factory MostroMessage.deserialized(String data) {
    try {
      final decoded = jsonDecode(data);
      final event = decoded as Map<String, dynamic>;
      final order = event['order'] != null
          ? event['order'] as Map<String, dynamic>
          : event['cant-do'] != null
              ? event['cant-do'] as Map<String, dynamic>
              : throw FormatException('Missing order object');

      final action = order['action'] != null
          ? Action.fromString(order['action'])
          : throw FormatException('Missing action field');

      final payload = order['payload'] != null
          ? Payload.fromJson(event['order']['payload']) as T
          : null;

      final tradeIndex =
          order['trade_index'] != null ? int.parse(order['trade_index']) : null;

      return MostroMessage<T>(
        action: action,
        requestId: order['id'],
        payload: payload,
        tradeIndex: tradeIndex,
      );
    } catch (e) {
      throw FormatException('Failed to deserialize MostroMessage: $e');
    }
  }

  T? get payload => _payload;

  R? getPayload<R>() {
    if (payload is R) {
      return payload as R;
    }
    return null;
  }
}
