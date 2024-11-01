import 'dart:convert';
import 'package:dart_nostr/nostr/model/request/filter.dart';
import 'package:mostro_mobile/core/config.dart';
import 'package:mostro_mobile/data/models/mostro_message.dart';
import 'package:mostro_mobile/data/models/order_model.dart';
import 'package:mostro_mobile/data/models/enums/action.dart';
import 'package:mostro_mobile/services/nostr_service.dart';

const int mostroVersion = 1;

class MostroService {
  final NostrService _nostrService;

  MostroService(this._nostrService);

  Future<void> publishOrder(OrderModel order) async {
    final content = jsonEncode({
      'order': {
        'version': mostroVersion,
        'action': Action.newOrder.value,
        'content': {
          'order': order.toJson(),
        },
      },
    });
    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);
  }

  Future<void> cancelOrder(String orderId) async {
    final content = jsonEncode({
      'order': {
        'version': mostroVersion,
        'id': orderId,
        'action': Action.cancel,
        'content': null,
      },
    });
    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);
  }

  Future<void> takeSellOrder(String orderId, {int? amount}) async {
    final content = jsonEncode({
      'order': {
        'version': mostroVersion,
        'id': orderId,
        'action': Action.takeSell.value,
        'content': amount != null ? {'amount': amount} : null,
      },
    });
    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);
  }

  Future<void> takeBuyOrder(String orderId, {int? amount}) async {
    final content = jsonEncode({
      'order': {
        'version': mostroVersion,
        'id': orderId,
        'action': Action.takeBuy.value,
        'content': amount != null ? {'amount': amount} : null,
      },
    });
    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);
  }

  Stream<OrderModel> subscribeToOrders() {
    DateTime filterTime = DateTime.now().subtract(Duration(hours: 24));

    var filter = NostrFilter(
      kinds: const [38383],
      since: filterTime,
    );
    return _nostrService.subscribeToEvents(filter).map((event) {
      // Convertir el evento Nostr a OrderModel
      // Implementar la lógica de conversión aquí
      return OrderModel.fromEventTags(event.tags!);
    });
  }

  Future<void> sendFiatSent(String orderId) async {
    final content = jsonEncode({
      'order': {
        'version': mostroVersion,
        'id': orderId,
        'action': Action.fiatSent.value,
        'content': null,
      },
    });
    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);
  }

  Future<void> releaseOrder(String orderId) async {
    final content = jsonEncode({
      'order': {
        'version': mostroVersion,
        'id': orderId,
        'action': Action.release.value,
        'content': null,
      },
    });
    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);
  }

  Future<void> sendOrder(Action action, String orderId) async {
    final message = MostroMessage(action: action, requestId: orderId);

    final content = jsonEncode(message.toJson());

    final event =
        await _nostrService.createNIP59Event(content, Config.mostroPubKey);
    await _nostrService.publishEvent(event);

  }

}
