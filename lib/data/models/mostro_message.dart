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
}
