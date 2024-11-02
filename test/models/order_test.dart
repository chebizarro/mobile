import 'dart:convert';
import 'dart:io';

import 'package:mostro_mobile/data/models/enums/kind.dart';
import 'package:mostro_mobile/data/models/enums/status.dart';
import 'package:mostro_mobile/data/models/order.dart';
import 'package:test/test.dart';

Future<Map<String, dynamic>> loadJson(String path) async {
  final file = File(path);
  final contents = await file.readAsString();
  return jsonDecode(contents);
}

void main() {
  group('Order Tests', () {
    test('Create new Order with default values', () {
      final order = Order(
        kind: Kind.sell,
        fiatCode: 'VES',
        fiatAmount: 100,
        paymentMethod: 'face to face',
        premium: 1,
      );

      expect(order.status, equals(Status.pending));
      expect(order.amount, equals(0));
      expect(order.fiatAmount, equals(100));
    });
  });

  group('Order Tests with JSON', () {
    test('Parse new sell order from JSON file', () async {
      // Load JSON data
      final jsonData = await loadJson('test/examples/new_sell_order.json');

      // Parse JSON to model
      final orderData = jsonData['order']['order']['content']['order'];
      final order = Order.fromJson(orderData);

      // Validate model properties
      expect(order.kind, equals(Kind.sell));
      expect(order.status, equals(Status.pending));
      expect(order.amount, equals(0));
      expect(order.fiatCode, equals('VES'));
      expect(order.fiatAmount, equals(100));
      expect(order.paymentMethod, equals('face to face'));
      expect(order.premium, equals(1));
    });
  });


}
