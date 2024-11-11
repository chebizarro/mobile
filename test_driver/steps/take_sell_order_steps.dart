import 'package:dart_nostr/nostr/model/event/event.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mostro_mobile/data/models/order.dart';

class TakeSellOrderSteps {
  static Iterable<StepDefinitionGeneric> steps = [
    _initializeOrderAmount(),
    _buyerSendsTakeSellMessage(),
    _mostroReceivesTakeSellEvent(),
    _mostroRequestsLNInvoice(),
    _buyerSendsLNInvoice(),
    _mostroConfirmsPaymentAwaited(),
  ];

  static StepDefinitionGeneric _initializeOrderAmount() {
    return given1<String, FlutterWorld>(
      'the order amount is {string}',
      (orderAmount, context) async {
        final order = Order(amount: int.parse(orderAmount));
        expect(order.amount, equals(int.parse(orderAmount)), reason: 'Order amount should match the provided value');
      },
    );
  }

  static StepDefinitionGeneric _buyerSendsTakeSellMessage() {
    return when1<Order, FlutterWorld>(
      'the buyer sends a "take-sell" message in a Gift wrap Nostr event to Mostro',
      (order, context) async {
        final repository = context.world.appProviderContainer.read(mostroRepositoryProvider);
        
        final nostrEvent = NostrEvent(
          id: 'cade205b849a872d74ba4d2a978135dbc05b4e5f483bb4403c42627dfd24f67d',
          kind: 1059,
          pubkey: '9a42ac72d6466a6dbe5b4b07a8717ee13e55abb6bdd810ea9c321c9a32ee837b',
          content: 'sealed-rumor-content',
          tags: [
            ['p', 'dbe0b1be7aafd3cfba92d7463edbd4e33b2969f61bd554d37ac56f032e13355a']
          ],
        );
        
        final response = await repository.sendNostrEvent(nostrEvent);
        
        expect(response, equals('sent'), reason: 'Nostr event should be sent to Mostro');
      },
    );
  }

  static StepDefinitionGeneric _mostroReceivesTakeSellEvent() {
    return then1<Order, FlutterWorld>(
      'Mostro should respond with a status "waiting-buyer-invoice"',
      (order, context) async {
        final repository = context.world.appProviderContainer.read(mostroRepositoryProvider);
        final responseOrder = await repository.getOrderStatus(order.id);
        
        expect(responseOrder.status, equals('waiting-buyer-invoice'), reason: 'Order status should be "waiting-buyer-invoice"');
      },
    );
  }

  static StepDefinitionGeneric _mostroRequestsLNInvoice() {
    return when1<Order, FlutterWorld>(
      'Mostro requests a lightning network invoice from the buyer',
      (order, context) async {
        final repository = context.world.appProviderContainer.read(mostroRepositoryProvider);
        final responseOrder = await repository.requestLNInvoice(order);
        
        expect(responseOrder.action, equals('add-invoice'), reason: 'Expected Mostro to request an LN invoice with action "add-invoice"');
      },
    );
  }

  static StepDefinitionGeneric _buyerSendsLNInvoice() {
    return when1<String, FlutterWorld>(
      'the buyer sends an LN invoice with the payment request "{string}"',
      (paymentRequest, context) async {
        final repository = context.world.appProviderContainer.read(mostroRepositoryProvider);
        
        final response = await repository.sendLNInvoice(paymentRequest);
        
        expect(response, equals('invoice-sent'), reason: 'LN invoice should be successfully sent');
      },
    );
  }

  static StepDefinitionGeneric _mostroConfirmsPaymentAwaited() {
    return then1<Order, FlutterWorld>(
      'Mostro confirms payment is awaited by changing the status to "waiting-payment"',
      (order, context) async {
        final repository = context.world.appProviderContainer.read(mostroRepositoryProvider);
        
        final responseOrder = await repository.getOrderStatus(order.id);
        
        expect(responseOrder.status, equals('waiting-payment'), reason: 'Order status should be updated to "waiting-payment"');
      },
    );
  }
}
