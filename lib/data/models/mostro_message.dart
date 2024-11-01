import 'package:mostro_mobile/services/mostro_action.dart';
import 'package:mostro_mobile/services/mostro_service.dart';

class MostroMessage<T> {
  final int version = mostroVersion;
  final int requestId;
  final MostroAction action;
  T? content;

  MostroMessage({required this.action, required this.requestId, this.content});

  Map<String, dynamic> toJson() {
    return {
      'order': {
        'version': mostroVersion,
        'id': requestId,
        'action': action.value,
        'content': null,
      },
    };
  }
}
