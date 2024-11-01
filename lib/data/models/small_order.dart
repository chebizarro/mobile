import 'package:mostro_mobile/data/models/mostro_status.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'small_order.g.dart';

enum Kind {
  buy('buy'),
  sell('sell');

  final String value;

  const Kind(this.value);
}

@JsonSerializable()
class SmallOrder {
  final Uuid? id;
  final Kind? kind;
  final Status? status;
  final int amount;
  final String fiatCode;
  final int? minAmount;
  final int? maxAmount;
  final int fiatAmount;
  final String paymentMethod;
  final int premium;
  final String? masterBuyerPubkey;
  final String? masterSellerPubkey;
  final String? buyerInvoice;
  final int? createdAt;
  final int? expiresAt;
  final int? buyerToken;
  final int? sellerToken;

  SmallOrder({
    this.id,
    this.kind,
    this.status,
    required this.amount,
    required this.fiatCode,
    this.minAmount,
    this.maxAmount,
    required this.fiatAmount,
    required this.paymentMethod,
    required this.premium,
    this.masterBuyerPubkey,
    this.masterSellerPubkey,
    this.buyerInvoice,
    this.createdAt,
    this.expiresAt,
    this.buyerToken,
    this.sellerToken,
  });

  factory SmallOrder.fromJson(Map<String, dynamic> json) =>
      _$SmallOrderFromJson(json);

  Map<String, dynamic> toJson() => _$SmallOrderToJson(this);
}
