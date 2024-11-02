import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:mostro_mobile/data/models/order.dart';

extension NostrEventExtensions on NostrEvent {
  // Getters para acceder fácilmente a los tags específicos
  String? get orderId => _getTagValue('d');
  String? get orderType => _getTagValue('k');
  String? get currency => _getTagValue('f');
  String? get status => _getTagValue('s');
  String? get amount => _getTagValue('amt');
  String? get fiatAmount => _getTagValue('fa');
  List<String> get paymentMethods => _getTagValue('pm')?.split(',') ?? [];
  String? get premium => _getTagValue('premium');
  String? get source => _getTagValue('source');
  String? get rating => _getTagValue('rating');
  String? get network => _getTagValue('network');
  String? get layer => _getTagValue('layer');
  String? get name => _getTagValue('name');
  String? get geohash => _getTagValue('g');
  String? get bond => _getTagValue('bond');
  String? get expiration => _getTagValue('expiration');
  String? get platform => _getTagValue('y');
  Order? get document => Order.fromJson(jsonDecode(_getTagValue('z')!));

  String? _getTagValue(String key) {
    final tag = tags?.firstWhere((t) => t[0] == key, orElse: () => []);
    return tag!.length > 1 ? tag[1] : null;
  }
}
