// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumnWithTypeConverter<OrderType, String> kind =
      GeneratedColumn<String>('kind', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<OrderType>($OrdersTable.$converterkind);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<Status, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Status>($OrdersTable.$converterstatus);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fiatCodeMeta =
      const VerificationMeta('fiatCode');
  @override
  late final GeneratedColumn<String> fiatCode = GeneratedColumn<String>(
      'fiat_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _minAmountMeta =
      const VerificationMeta('minAmount');
  @override
  late final GeneratedColumn<int> minAmount = GeneratedColumn<int>(
      'min_amount', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _maxAmountMeta =
      const VerificationMeta('maxAmount');
  @override
  late final GeneratedColumn<int> maxAmount = GeneratedColumn<int>(
      'max_amount', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fiatAmountMeta =
      const VerificationMeta('fiatAmount');
  @override
  late final GeneratedColumn<int> fiatAmount = GeneratedColumn<int>(
      'fiat_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _premiumMeta =
      const VerificationMeta('premium');
  @override
  late final GeneratedColumn<int> premium = GeneratedColumn<int>(
      'premium', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _masterBuyerPubkeyMeta =
      const VerificationMeta('masterBuyerPubkey');
  @override
  late final GeneratedColumn<String> masterBuyerPubkey =
      GeneratedColumn<String>('master_buyer_pubkey', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _masterSellerPubkeyMeta =
      const VerificationMeta('masterSellerPubkey');
  @override
  late final GeneratedColumn<String> masterSellerPubkey =
      GeneratedColumn<String>('master_seller_pubkey', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _buyerTradePubkeyMeta =
      const VerificationMeta('buyerTradePubkey');
  @override
  late final GeneratedColumn<String> buyerTradePubkey = GeneratedColumn<String>(
      'buyer_trade_pubkey', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sellerTradePubkeyMeta =
      const VerificationMeta('sellerTradePubkey');
  @override
  late final GeneratedColumn<String> sellerTradePubkey =
      GeneratedColumn<String>('seller_trade_pubkey', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _buyerInvoiceMeta =
      const VerificationMeta('buyerInvoice');
  @override
  late final GeneratedColumn<String> buyerInvoice = GeneratedColumn<String>(
      'buyer_invoice', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
      'expires_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _buyerTokenMeta =
      const VerificationMeta('buyerToken');
  @override
  late final GeneratedColumn<int> buyerToken = GeneratedColumn<int>(
      'buyer_token', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sellerTokenMeta =
      const VerificationMeta('sellerToken');
  @override
  late final GeneratedColumn<int> sellerToken = GeneratedColumn<int>(
      'seller_token', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        kind,
        status,
        amount,
        fiatCode,
        minAmount,
        maxAmount,
        fiatAmount,
        paymentMethod,
        premium,
        masterBuyerPubkey,
        masterSellerPubkey,
        buyerTradePubkey,
        sellerTradePubkey,
        buyerInvoice,
        createdAt,
        expiresAt,
        buyerToken,
        sellerToken
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_kindMeta, const VerificationResult.success());
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('fiat_code')) {
      context.handle(_fiatCodeMeta,
          fiatCode.isAcceptableOrUnknown(data['fiat_code']!, _fiatCodeMeta));
    } else if (isInserting) {
      context.missing(_fiatCodeMeta);
    }
    if (data.containsKey('min_amount')) {
      context.handle(_minAmountMeta,
          minAmount.isAcceptableOrUnknown(data['min_amount']!, _minAmountMeta));
    }
    if (data.containsKey('max_amount')) {
      context.handle(_maxAmountMeta,
          maxAmount.isAcceptableOrUnknown(data['max_amount']!, _maxAmountMeta));
    }
    if (data.containsKey('fiat_amount')) {
      context.handle(
          _fiatAmountMeta,
          fiatAmount.isAcceptableOrUnknown(
              data['fiat_amount']!, _fiatAmountMeta));
    } else if (isInserting) {
      context.missing(_fiatAmountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('premium')) {
      context.handle(_premiumMeta,
          premium.isAcceptableOrUnknown(data['premium']!, _premiumMeta));
    } else if (isInserting) {
      context.missing(_premiumMeta);
    }
    if (data.containsKey('master_buyer_pubkey')) {
      context.handle(
          _masterBuyerPubkeyMeta,
          masterBuyerPubkey.isAcceptableOrUnknown(
              data['master_buyer_pubkey']!, _masterBuyerPubkeyMeta));
    }
    if (data.containsKey('master_seller_pubkey')) {
      context.handle(
          _masterSellerPubkeyMeta,
          masterSellerPubkey.isAcceptableOrUnknown(
              data['master_seller_pubkey']!, _masterSellerPubkeyMeta));
    }
    if (data.containsKey('buyer_trade_pubkey')) {
      context.handle(
          _buyerTradePubkeyMeta,
          buyerTradePubkey.isAcceptableOrUnknown(
              data['buyer_trade_pubkey']!, _buyerTradePubkeyMeta));
    }
    if (data.containsKey('seller_trade_pubkey')) {
      context.handle(
          _sellerTradePubkeyMeta,
          sellerTradePubkey.isAcceptableOrUnknown(
              data['seller_trade_pubkey']!, _sellerTradePubkeyMeta));
    }
    if (data.containsKey('buyer_invoice')) {
      context.handle(
          _buyerInvoiceMeta,
          buyerInvoice.isAcceptableOrUnknown(
              data['buyer_invoice']!, _buyerInvoiceMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    }
    if (data.containsKey('buyer_token')) {
      context.handle(
          _buyerTokenMeta,
          buyerToken.isAcceptableOrUnknown(
              data['buyer_token']!, _buyerTokenMeta));
    }
    if (data.containsKey('seller_token')) {
      context.handle(
          _sellerTokenMeta,
          sellerToken.isAcceptableOrUnknown(
              data['seller_token']!, _sellerTokenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      kind: $OrdersTable.$converterkind.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!),
      status: $OrdersTable.$converterstatus.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      fiatCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fiat_code'])!,
      minAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_amount']),
      maxAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_amount']),
      fiatAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fiat_amount'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      premium: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}premium'])!,
      masterBuyerPubkey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}master_buyer_pubkey']),
      masterSellerPubkey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}master_seller_pubkey']),
      buyerTradePubkey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}buyer_trade_pubkey']),
      sellerTradePubkey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}seller_trade_pubkey']),
      buyerInvoice: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buyer_invoice']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at']),
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}expires_at']),
      buyerToken: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}buyer_token']),
      sellerToken: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}seller_token']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OrderType, String, String> $converterkind =
      const EnumNameConverter<OrderType>(OrderType.values);
  static JsonTypeConverter2<Status, String, String> $converterstatus =
      const EnumNameConverter<Status>(Status.values);
}

class Order extends DataClass implements Insertable<Order> {
  final String id;
  final OrderType kind;
  final Status status;
  final int amount;
  final String fiatCode;
  final int? minAmount;
  final int? maxAmount;
  final int fiatAmount;
  final String paymentMethod;
  final int premium;
  final String? masterBuyerPubkey;
  final String? masterSellerPubkey;
  final String? buyerTradePubkey;
  final String? sellerTradePubkey;
  final String? buyerInvoice;
  final int? createdAt;
  final int? expiresAt;
  final int? buyerToken;
  final int? sellerToken;
  const Order(
      {required this.id,
      required this.kind,
      required this.status,
      required this.amount,
      required this.fiatCode,
      this.minAmount,
      this.maxAmount,
      required this.fiatAmount,
      required this.paymentMethod,
      required this.premium,
      this.masterBuyerPubkey,
      this.masterSellerPubkey,
      this.buyerTradePubkey,
      this.sellerTradePubkey,
      this.buyerInvoice,
      this.createdAt,
      this.expiresAt,
      this.buyerToken,
      this.sellerToken});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['kind'] = Variable<String>($OrdersTable.$converterkind.toSql(kind));
    }
    {
      map['status'] =
          Variable<String>($OrdersTable.$converterstatus.toSql(status));
    }
    map['amount'] = Variable<int>(amount);
    map['fiat_code'] = Variable<String>(fiatCode);
    if (!nullToAbsent || minAmount != null) {
      map['min_amount'] = Variable<int>(minAmount);
    }
    if (!nullToAbsent || maxAmount != null) {
      map['max_amount'] = Variable<int>(maxAmount);
    }
    map['fiat_amount'] = Variable<int>(fiatAmount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['premium'] = Variable<int>(premium);
    if (!nullToAbsent || masterBuyerPubkey != null) {
      map['master_buyer_pubkey'] = Variable<String>(masterBuyerPubkey);
    }
    if (!nullToAbsent || masterSellerPubkey != null) {
      map['master_seller_pubkey'] = Variable<String>(masterSellerPubkey);
    }
    if (!nullToAbsent || buyerTradePubkey != null) {
      map['buyer_trade_pubkey'] = Variable<String>(buyerTradePubkey);
    }
    if (!nullToAbsent || sellerTradePubkey != null) {
      map['seller_trade_pubkey'] = Variable<String>(sellerTradePubkey);
    }
    if (!nullToAbsent || buyerInvoice != null) {
      map['buyer_invoice'] = Variable<String>(buyerInvoice);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<int>(expiresAt);
    }
    if (!nullToAbsent || buyerToken != null) {
      map['buyer_token'] = Variable<int>(buyerToken);
    }
    if (!nullToAbsent || sellerToken != null) {
      map['seller_token'] = Variable<int>(sellerToken);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      kind: Value(kind),
      status: Value(status),
      amount: Value(amount),
      fiatCode: Value(fiatCode),
      minAmount: minAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(minAmount),
      maxAmount: maxAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAmount),
      fiatAmount: Value(fiatAmount),
      paymentMethod: Value(paymentMethod),
      premium: Value(premium),
      masterBuyerPubkey: masterBuyerPubkey == null && nullToAbsent
          ? const Value.absent()
          : Value(masterBuyerPubkey),
      masterSellerPubkey: masterSellerPubkey == null && nullToAbsent
          ? const Value.absent()
          : Value(masterSellerPubkey),
      buyerTradePubkey: buyerTradePubkey == null && nullToAbsent
          ? const Value.absent()
          : Value(buyerTradePubkey),
      sellerTradePubkey: sellerTradePubkey == null && nullToAbsent
          ? const Value.absent()
          : Value(sellerTradePubkey),
      buyerInvoice: buyerInvoice == null && nullToAbsent
          ? const Value.absent()
          : Value(buyerInvoice),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      buyerToken: buyerToken == null && nullToAbsent
          ? const Value.absent()
          : Value(buyerToken),
      sellerToken: sellerToken == null && nullToAbsent
          ? const Value.absent()
          : Value(sellerToken),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<String>(json['id']),
      kind: $OrdersTable.$converterkind
          .fromJson(serializer.fromJson<String>(json['kind'])),
      status: $OrdersTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      amount: serializer.fromJson<int>(json['amount']),
      fiatCode: serializer.fromJson<String>(json['fiatCode']),
      minAmount: serializer.fromJson<int?>(json['minAmount']),
      maxAmount: serializer.fromJson<int?>(json['maxAmount']),
      fiatAmount: serializer.fromJson<int>(json['fiatAmount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      premium: serializer.fromJson<int>(json['premium']),
      masterBuyerPubkey:
          serializer.fromJson<String?>(json['masterBuyerPubkey']),
      masterSellerPubkey:
          serializer.fromJson<String?>(json['masterSellerPubkey']),
      buyerTradePubkey: serializer.fromJson<String?>(json['buyerTradePubkey']),
      sellerTradePubkey:
          serializer.fromJson<String?>(json['sellerTradePubkey']),
      buyerInvoice: serializer.fromJson<String?>(json['buyerInvoice']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
      expiresAt: serializer.fromJson<int?>(json['expiresAt']),
      buyerToken: serializer.fromJson<int?>(json['buyerToken']),
      sellerToken: serializer.fromJson<int?>(json['sellerToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kind':
          serializer.toJson<String>($OrdersTable.$converterkind.toJson(kind)),
      'status': serializer
          .toJson<String>($OrdersTable.$converterstatus.toJson(status)),
      'amount': serializer.toJson<int>(amount),
      'fiatCode': serializer.toJson<String>(fiatCode),
      'minAmount': serializer.toJson<int?>(minAmount),
      'maxAmount': serializer.toJson<int?>(maxAmount),
      'fiatAmount': serializer.toJson<int>(fiatAmount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'premium': serializer.toJson<int>(premium),
      'masterBuyerPubkey': serializer.toJson<String?>(masterBuyerPubkey),
      'masterSellerPubkey': serializer.toJson<String?>(masterSellerPubkey),
      'buyerTradePubkey': serializer.toJson<String?>(buyerTradePubkey),
      'sellerTradePubkey': serializer.toJson<String?>(sellerTradePubkey),
      'buyerInvoice': serializer.toJson<String?>(buyerInvoice),
      'createdAt': serializer.toJson<int?>(createdAt),
      'expiresAt': serializer.toJson<int?>(expiresAt),
      'buyerToken': serializer.toJson<int?>(buyerToken),
      'sellerToken': serializer.toJson<int?>(sellerToken),
    };
  }

  Order copyWith(
          {String? id,
          OrderType? kind,
          Status? status,
          int? amount,
          String? fiatCode,
          Value<int?> minAmount = const Value.absent(),
          Value<int?> maxAmount = const Value.absent(),
          int? fiatAmount,
          String? paymentMethod,
          int? premium,
          Value<String?> masterBuyerPubkey = const Value.absent(),
          Value<String?> masterSellerPubkey = const Value.absent(),
          Value<String?> buyerTradePubkey = const Value.absent(),
          Value<String?> sellerTradePubkey = const Value.absent(),
          Value<String?> buyerInvoice = const Value.absent(),
          Value<int?> createdAt = const Value.absent(),
          Value<int?> expiresAt = const Value.absent(),
          Value<int?> buyerToken = const Value.absent(),
          Value<int?> sellerToken = const Value.absent()}) =>
      Order(
        id: id ?? this.id,
        kind: kind ?? this.kind,
        status: status ?? this.status,
        amount: amount ?? this.amount,
        fiatCode: fiatCode ?? this.fiatCode,
        minAmount: minAmount.present ? minAmount.value : this.minAmount,
        maxAmount: maxAmount.present ? maxAmount.value : this.maxAmount,
        fiatAmount: fiatAmount ?? this.fiatAmount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        premium: premium ?? this.premium,
        masterBuyerPubkey: masterBuyerPubkey.present
            ? masterBuyerPubkey.value
            : this.masterBuyerPubkey,
        masterSellerPubkey: masterSellerPubkey.present
            ? masterSellerPubkey.value
            : this.masterSellerPubkey,
        buyerTradePubkey: buyerTradePubkey.present
            ? buyerTradePubkey.value
            : this.buyerTradePubkey,
        sellerTradePubkey: sellerTradePubkey.present
            ? sellerTradePubkey.value
            : this.sellerTradePubkey,
        buyerInvoice:
            buyerInvoice.present ? buyerInvoice.value : this.buyerInvoice,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
        buyerToken: buyerToken.present ? buyerToken.value : this.buyerToken,
        sellerToken: sellerToken.present ? sellerToken.value : this.sellerToken,
      );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      status: data.status.present ? data.status.value : this.status,
      amount: data.amount.present ? data.amount.value : this.amount,
      fiatCode: data.fiatCode.present ? data.fiatCode.value : this.fiatCode,
      minAmount: data.minAmount.present ? data.minAmount.value : this.minAmount,
      maxAmount: data.maxAmount.present ? data.maxAmount.value : this.maxAmount,
      fiatAmount:
          data.fiatAmount.present ? data.fiatAmount.value : this.fiatAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      premium: data.premium.present ? data.premium.value : this.premium,
      masterBuyerPubkey: data.masterBuyerPubkey.present
          ? data.masterBuyerPubkey.value
          : this.masterBuyerPubkey,
      masterSellerPubkey: data.masterSellerPubkey.present
          ? data.masterSellerPubkey.value
          : this.masterSellerPubkey,
      buyerTradePubkey: data.buyerTradePubkey.present
          ? data.buyerTradePubkey.value
          : this.buyerTradePubkey,
      sellerTradePubkey: data.sellerTradePubkey.present
          ? data.sellerTradePubkey.value
          : this.sellerTradePubkey,
      buyerInvoice: data.buyerInvoice.present
          ? data.buyerInvoice.value
          : this.buyerInvoice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      buyerToken:
          data.buyerToken.present ? data.buyerToken.value : this.buyerToken,
      sellerToken:
          data.sellerToken.present ? data.sellerToken.value : this.sellerToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('fiatCode: $fiatCode, ')
          ..write('minAmount: $minAmount, ')
          ..write('maxAmount: $maxAmount, ')
          ..write('fiatAmount: $fiatAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('premium: $premium, ')
          ..write('masterBuyerPubkey: $masterBuyerPubkey, ')
          ..write('masterSellerPubkey: $masterSellerPubkey, ')
          ..write('buyerTradePubkey: $buyerTradePubkey, ')
          ..write('sellerTradePubkey: $sellerTradePubkey, ')
          ..write('buyerInvoice: $buyerInvoice, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('buyerToken: $buyerToken, ')
          ..write('sellerToken: $sellerToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      kind,
      status,
      amount,
      fiatCode,
      minAmount,
      maxAmount,
      fiatAmount,
      paymentMethod,
      premium,
      masterBuyerPubkey,
      masterSellerPubkey,
      buyerTradePubkey,
      sellerTradePubkey,
      buyerInvoice,
      createdAt,
      expiresAt,
      buyerToken,
      sellerToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.status == this.status &&
          other.amount == this.amount &&
          other.fiatCode == this.fiatCode &&
          other.minAmount == this.minAmount &&
          other.maxAmount == this.maxAmount &&
          other.fiatAmount == this.fiatAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.premium == this.premium &&
          other.masterBuyerPubkey == this.masterBuyerPubkey &&
          other.masterSellerPubkey == this.masterSellerPubkey &&
          other.buyerTradePubkey == this.buyerTradePubkey &&
          other.sellerTradePubkey == this.sellerTradePubkey &&
          other.buyerInvoice == this.buyerInvoice &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt &&
          other.buyerToken == this.buyerToken &&
          other.sellerToken == this.sellerToken);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> id;
  final Value<OrderType> kind;
  final Value<Status> status;
  final Value<int> amount;
  final Value<String> fiatCode;
  final Value<int?> minAmount;
  final Value<int?> maxAmount;
  final Value<int> fiatAmount;
  final Value<String> paymentMethod;
  final Value<int> premium;
  final Value<String?> masterBuyerPubkey;
  final Value<String?> masterSellerPubkey;
  final Value<String?> buyerTradePubkey;
  final Value<String?> sellerTradePubkey;
  final Value<String?> buyerInvoice;
  final Value<int?> createdAt;
  final Value<int?> expiresAt;
  final Value<int?> buyerToken;
  final Value<int?> sellerToken;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.fiatCode = const Value.absent(),
    this.minAmount = const Value.absent(),
    this.maxAmount = const Value.absent(),
    this.fiatAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.premium = const Value.absent(),
    this.masterBuyerPubkey = const Value.absent(),
    this.masterSellerPubkey = const Value.absent(),
    this.buyerTradePubkey = const Value.absent(),
    this.sellerTradePubkey = const Value.absent(),
    this.buyerInvoice = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.buyerToken = const Value.absent(),
    this.sellerToken = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    required String id,
    required OrderType kind,
    required Status status,
    required int amount,
    required String fiatCode,
    this.minAmount = const Value.absent(),
    this.maxAmount = const Value.absent(),
    required int fiatAmount,
    required String paymentMethod,
    required int premium,
    this.masterBuyerPubkey = const Value.absent(),
    this.masterSellerPubkey = const Value.absent(),
    this.buyerTradePubkey = const Value.absent(),
    this.sellerTradePubkey = const Value.absent(),
    this.buyerInvoice = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.buyerToken = const Value.absent(),
    this.sellerToken = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        kind = Value(kind),
        status = Value(status),
        amount = Value(amount),
        fiatCode = Value(fiatCode),
        fiatAmount = Value(fiatAmount),
        paymentMethod = Value(paymentMethod),
        premium = Value(premium);
  static Insertable<Order> custom({
    Expression<String>? id,
    Expression<String>? kind,
    Expression<String>? status,
    Expression<int>? amount,
    Expression<String>? fiatCode,
    Expression<int>? minAmount,
    Expression<int>? maxAmount,
    Expression<int>? fiatAmount,
    Expression<String>? paymentMethod,
    Expression<int>? premium,
    Expression<String>? masterBuyerPubkey,
    Expression<String>? masterSellerPubkey,
    Expression<String>? buyerTradePubkey,
    Expression<String>? sellerTradePubkey,
    Expression<String>? buyerInvoice,
    Expression<int>? createdAt,
    Expression<int>? expiresAt,
    Expression<int>? buyerToken,
    Expression<int>? sellerToken,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (status != null) 'status': status,
      if (amount != null) 'amount': amount,
      if (fiatCode != null) 'fiat_code': fiatCode,
      if (minAmount != null) 'min_amount': minAmount,
      if (maxAmount != null) 'max_amount': maxAmount,
      if (fiatAmount != null) 'fiat_amount': fiatAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (premium != null) 'premium': premium,
      if (masterBuyerPubkey != null) 'master_buyer_pubkey': masterBuyerPubkey,
      if (masterSellerPubkey != null)
        'master_seller_pubkey': masterSellerPubkey,
      if (buyerTradePubkey != null) 'buyer_trade_pubkey': buyerTradePubkey,
      if (sellerTradePubkey != null) 'seller_trade_pubkey': sellerTradePubkey,
      if (buyerInvoice != null) 'buyer_invoice': buyerInvoice,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (buyerToken != null) 'buyer_token': buyerToken,
      if (sellerToken != null) 'seller_token': sellerToken,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith(
      {Value<String>? id,
      Value<OrderType>? kind,
      Value<Status>? status,
      Value<int>? amount,
      Value<String>? fiatCode,
      Value<int?>? minAmount,
      Value<int?>? maxAmount,
      Value<int>? fiatAmount,
      Value<String>? paymentMethod,
      Value<int>? premium,
      Value<String?>? masterBuyerPubkey,
      Value<String?>? masterSellerPubkey,
      Value<String?>? buyerTradePubkey,
      Value<String?>? sellerTradePubkey,
      Value<String?>? buyerInvoice,
      Value<int?>? createdAt,
      Value<int?>? expiresAt,
      Value<int?>? buyerToken,
      Value<int?>? sellerToken,
      Value<int>? rowid}) {
    return OrdersCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      fiatCode: fiatCode ?? this.fiatCode,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      fiatAmount: fiatAmount ?? this.fiatAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      premium: premium ?? this.premium,
      masterBuyerPubkey: masterBuyerPubkey ?? this.masterBuyerPubkey,
      masterSellerPubkey: masterSellerPubkey ?? this.masterSellerPubkey,
      buyerTradePubkey: buyerTradePubkey ?? this.buyerTradePubkey,
      sellerTradePubkey: sellerTradePubkey ?? this.sellerTradePubkey,
      buyerInvoice: buyerInvoice ?? this.buyerInvoice,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      buyerToken: buyerToken ?? this.buyerToken,
      sellerToken: sellerToken ?? this.sellerToken,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] =
          Variable<String>($OrdersTable.$converterkind.toSql(kind.value));
    }
    if (status.present) {
      map['status'] =
          Variable<String>($OrdersTable.$converterstatus.toSql(status.value));
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (fiatCode.present) {
      map['fiat_code'] = Variable<String>(fiatCode.value);
    }
    if (minAmount.present) {
      map['min_amount'] = Variable<int>(minAmount.value);
    }
    if (maxAmount.present) {
      map['max_amount'] = Variable<int>(maxAmount.value);
    }
    if (fiatAmount.present) {
      map['fiat_amount'] = Variable<int>(fiatAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (premium.present) {
      map['premium'] = Variable<int>(premium.value);
    }
    if (masterBuyerPubkey.present) {
      map['master_buyer_pubkey'] = Variable<String>(masterBuyerPubkey.value);
    }
    if (masterSellerPubkey.present) {
      map['master_seller_pubkey'] = Variable<String>(masterSellerPubkey.value);
    }
    if (buyerTradePubkey.present) {
      map['buyer_trade_pubkey'] = Variable<String>(buyerTradePubkey.value);
    }
    if (sellerTradePubkey.present) {
      map['seller_trade_pubkey'] = Variable<String>(sellerTradePubkey.value);
    }
    if (buyerInvoice.present) {
      map['buyer_invoice'] = Variable<String>(buyerInvoice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (buyerToken.present) {
      map['buyer_token'] = Variable<int>(buyerToken.value);
    }
    if (sellerToken.present) {
      map['seller_token'] = Variable<int>(sellerToken.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('fiatCode: $fiatCode, ')
          ..write('minAmount: $minAmount, ')
          ..write('maxAmount: $maxAmount, ')
          ..write('fiatAmount: $fiatAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('premium: $premium, ')
          ..write('masterBuyerPubkey: $masterBuyerPubkey, ')
          ..write('masterSellerPubkey: $masterSellerPubkey, ')
          ..write('buyerTradePubkey: $buyerTradePubkey, ')
          ..write('sellerTradePubkey: $sellerTradePubkey, ')
          ..write('buyerInvoice: $buyerInvoice, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('buyerToken: $buyerToken, ')
          ..write('sellerToken: $sellerToken, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NostrEventsTable extends NostrEvents
    with TableInfo<$NostrEventsTable, NostrEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NostrEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pubkeyMeta = const VerificationMeta('pubkey');
  @override
  late final GeneratedColumn<String> pubkey = GeneratedColumn<String>(
      'pubkey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<int> kind = GeneratedColumn<int>(
      'kind', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sigMeta = const VerificationMeta('sig');
  @override
  late final GeneratedColumn<String> sig = GeneratedColumn<String>(
      'sig', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, pubkey, content, createdAt, kind, sig, tags];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nostr_events';
  @override
  VerificationContext validateIntegrity(Insertable<NostrEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pubkey')) {
      context.handle(_pubkeyMeta,
          pubkey.isAcceptableOrUnknown(data['pubkey']!, _pubkeyMeta));
    } else if (isInserting) {
      context.missing(_pubkeyMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('sig')) {
      context.handle(
          _sigMeta, sig.isAcceptableOrUnknown(data['sig']!, _sigMeta));
    } else if (isInserting) {
      context.missing(_sigMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NostrEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NostrEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pubkey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pubkey'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kind'])!,
      sig: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sig'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
    );
  }

  @override
  $NostrEventsTable createAlias(String alias) {
    return $NostrEventsTable(attachedDatabase, alias);
  }
}

class NostrEvent extends DataClass implements Insertable<NostrEvent> {
  final String id;
  final String pubkey;
  final String content;
  final DateTime createdAt;
  final int kind;
  final String sig;
  final String tags;
  const NostrEvent(
      {required this.id,
      required this.pubkey,
      required this.content,
      required this.createdAt,
      required this.kind,
      required this.sig,
      required this.tags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pubkey'] = Variable<String>(pubkey);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['kind'] = Variable<int>(kind);
    map['sig'] = Variable<String>(sig);
    map['tags'] = Variable<String>(tags);
    return map;
  }

  NostrEventsCompanion toCompanion(bool nullToAbsent) {
    return NostrEventsCompanion(
      id: Value(id),
      pubkey: Value(pubkey),
      content: Value(content),
      createdAt: Value(createdAt),
      kind: Value(kind),
      sig: Value(sig),
      tags: Value(tags),
    );
  }

  factory NostrEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NostrEvent(
      id: serializer.fromJson<String>(json['id']),
      pubkey: serializer.fromJson<String>(json['pubkey']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      kind: serializer.fromJson<int>(json['kind']),
      sig: serializer.fromJson<String>(json['sig']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pubkey': serializer.toJson<String>(pubkey),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'kind': serializer.toJson<int>(kind),
      'sig': serializer.toJson<String>(sig),
      'tags': serializer.toJson<String>(tags),
    };
  }

  NostrEvent copyWith(
          {String? id,
          String? pubkey,
          String? content,
          DateTime? createdAt,
          int? kind,
          String? sig,
          String? tags}) =>
      NostrEvent(
        id: id ?? this.id,
        pubkey: pubkey ?? this.pubkey,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        kind: kind ?? this.kind,
        sig: sig ?? this.sig,
        tags: tags ?? this.tags,
      );
  NostrEvent copyWithCompanion(NostrEventsCompanion data) {
    return NostrEvent(
      id: data.id.present ? data.id.value : this.id,
      pubkey: data.pubkey.present ? data.pubkey.value : this.pubkey,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      sig: data.sig.present ? data.sig.value : this.sig,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NostrEvent(')
          ..write('id: $id, ')
          ..write('pubkey: $pubkey, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('kind: $kind, ')
          ..write('sig: $sig, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pubkey, content, createdAt, kind, sig, tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NostrEvent &&
          other.id == this.id &&
          other.pubkey == this.pubkey &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.kind == this.kind &&
          other.sig == this.sig &&
          other.tags == this.tags);
}

class NostrEventsCompanion extends UpdateCompanion<NostrEvent> {
  final Value<String> id;
  final Value<String> pubkey;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<int> kind;
  final Value<String> sig;
  final Value<String> tags;
  final Value<int> rowid;
  const NostrEventsCompanion({
    this.id = const Value.absent(),
    this.pubkey = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.sig = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NostrEventsCompanion.insert({
    required String id,
    required String pubkey,
    required String content,
    required DateTime createdAt,
    required int kind,
    required String sig,
    required String tags,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pubkey = Value(pubkey),
        content = Value(content),
        createdAt = Value(createdAt),
        kind = Value(kind),
        sig = Value(sig),
        tags = Value(tags);
  static Insertable<NostrEvent> custom({
    Expression<String>? id,
    Expression<String>? pubkey,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<int>? kind,
    Expression<String>? sig,
    Expression<String>? tags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pubkey != null) 'pubkey': pubkey,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (kind != null) 'kind': kind,
      if (sig != null) 'sig': sig,
      if (tags != null) 'tags': tags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NostrEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? pubkey,
      Value<String>? content,
      Value<DateTime>? createdAt,
      Value<int>? kind,
      Value<String>? sig,
      Value<String>? tags,
      Value<int>? rowid}) {
    return NostrEventsCompanion(
      id: id ?? this.id,
      pubkey: pubkey ?? this.pubkey,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      kind: kind ?? this.kind,
      sig: sig ?? this.sig,
      tags: tags ?? this.tags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pubkey.present) {
      map['pubkey'] = Variable<String>(pubkey.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(kind.value);
    }
    if (sig.present) {
      map['sig'] = Variable<String>(sig.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NostrEventsCompanion(')
          ..write('id: $id, ')
          ..write('pubkey: $pubkey, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('kind: $kind, ')
          ..write('sig: $sig, ')
          ..write('tags: $tags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pubkeyMeta = const VerificationMeta('pubkey');
  @override
  late final GeneratedColumn<String> pubkey = GeneratedColumn<String>(
      'pubkey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _keyIndexMeta =
      const VerificationMeta('keyIndex');
  @override
  late final GeneratedColumn<int> keyIndex = GeneratedColumn<int>(
      'key_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fullPrivacyMeta =
      const VerificationMeta('fullPrivacy');
  @override
  late final GeneratedColumn<bool> fullPrivacy = GeneratedColumn<bool>(
      'full_privacy', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("full_privacy" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _peerPublicKeyMeta =
      const VerificationMeta('peerPublicKey');
  @override
  late final GeneratedColumn<String> peerPublicKey = GeneratedColumn<String>(
      'peer_public_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        pubkey,
        isActive,
        keyIndex,
        fullPrivacy,
        createdAt,
        orderId,
        role,
        peerPublicKey
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pubkey')) {
      context.handle(_pubkeyMeta,
          pubkey.isAcceptableOrUnknown(data['pubkey']!, _pubkeyMeta));
    } else if (isInserting) {
      context.missing(_pubkeyMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('key_index')) {
      context.handle(_keyIndexMeta,
          keyIndex.isAcceptableOrUnknown(data['key_index']!, _keyIndexMeta));
    } else if (isInserting) {
      context.missing(_keyIndexMeta);
    }
    if (data.containsKey('full_privacy')) {
      context.handle(
          _fullPrivacyMeta,
          fullPrivacy.isAcceptableOrUnknown(
              data['full_privacy']!, _fullPrivacyMeta));
    } else if (isInserting) {
      context.missing(_fullPrivacyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('peer_public_key')) {
      context.handle(
          _peerPublicKeyMeta,
          peerPublicKey.isAcceptableOrUnknown(
              data['peer_public_key']!, _peerPublicKeyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pubkey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pubkey'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      keyIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}key_index'])!,
      fullPrivacy: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}full_privacy'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role']),
      peerPublicKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}peer_public_key']),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final String pubkey;
  final bool isActive;
  final int keyIndex;
  final bool fullPrivacy;
  final DateTime createdAt;
  final String? orderId;
  final String? role;
  final String? peerPublicKey;
  const Session(
      {required this.id,
      required this.pubkey,
      required this.isActive,
      required this.keyIndex,
      required this.fullPrivacy,
      required this.createdAt,
      this.orderId,
      this.role,
      this.peerPublicKey});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pubkey'] = Variable<String>(pubkey);
    map['is_active'] = Variable<bool>(isActive);
    map['key_index'] = Variable<int>(keyIndex);
    map['full_privacy'] = Variable<bool>(fullPrivacy);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || peerPublicKey != null) {
      map['peer_public_key'] = Variable<String>(peerPublicKey);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      pubkey: Value(pubkey),
      isActive: Value(isActive),
      keyIndex: Value(keyIndex),
      fullPrivacy: Value(fullPrivacy),
      createdAt: Value(createdAt),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      peerPublicKey: peerPublicKey == null && nullToAbsent
          ? const Value.absent()
          : Value(peerPublicKey),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      pubkey: serializer.fromJson<String>(json['pubkey']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      keyIndex: serializer.fromJson<int>(json['keyIndex']),
      fullPrivacy: serializer.fromJson<bool>(json['fullPrivacy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      role: serializer.fromJson<String?>(json['role']),
      peerPublicKey: serializer.fromJson<String?>(json['peerPublicKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pubkey': serializer.toJson<String>(pubkey),
      'isActive': serializer.toJson<bool>(isActive),
      'keyIndex': serializer.toJson<int>(keyIndex),
      'fullPrivacy': serializer.toJson<bool>(fullPrivacy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'orderId': serializer.toJson<String?>(orderId),
      'role': serializer.toJson<String?>(role),
      'peerPublicKey': serializer.toJson<String?>(peerPublicKey),
    };
  }

  Session copyWith(
          {String? id,
          String? pubkey,
          bool? isActive,
          int? keyIndex,
          bool? fullPrivacy,
          DateTime? createdAt,
          Value<String?> orderId = const Value.absent(),
          Value<String?> role = const Value.absent(),
          Value<String?> peerPublicKey = const Value.absent()}) =>
      Session(
        id: id ?? this.id,
        pubkey: pubkey ?? this.pubkey,
        isActive: isActive ?? this.isActive,
        keyIndex: keyIndex ?? this.keyIndex,
        fullPrivacy: fullPrivacy ?? this.fullPrivacy,
        createdAt: createdAt ?? this.createdAt,
        orderId: orderId.present ? orderId.value : this.orderId,
        role: role.present ? role.value : this.role,
        peerPublicKey:
            peerPublicKey.present ? peerPublicKey.value : this.peerPublicKey,
      );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      pubkey: data.pubkey.present ? data.pubkey.value : this.pubkey,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      keyIndex: data.keyIndex.present ? data.keyIndex.value : this.keyIndex,
      fullPrivacy:
          data.fullPrivacy.present ? data.fullPrivacy.value : this.fullPrivacy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      role: data.role.present ? data.role.value : this.role,
      peerPublicKey: data.peerPublicKey.present
          ? data.peerPublicKey.value
          : this.peerPublicKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('pubkey: $pubkey, ')
          ..write('isActive: $isActive, ')
          ..write('keyIndex: $keyIndex, ')
          ..write('fullPrivacy: $fullPrivacy, ')
          ..write('createdAt: $createdAt, ')
          ..write('orderId: $orderId, ')
          ..write('role: $role, ')
          ..write('peerPublicKey: $peerPublicKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pubkey, isActive, keyIndex, fullPrivacy,
      createdAt, orderId, role, peerPublicKey);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.pubkey == this.pubkey &&
          other.isActive == this.isActive &&
          other.keyIndex == this.keyIndex &&
          other.fullPrivacy == this.fullPrivacy &&
          other.createdAt == this.createdAt &&
          other.orderId == this.orderId &&
          other.role == this.role &&
          other.peerPublicKey == this.peerPublicKey);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<String> pubkey;
  final Value<bool> isActive;
  final Value<int> keyIndex;
  final Value<bool> fullPrivacy;
  final Value<DateTime> createdAt;
  final Value<String?> orderId;
  final Value<String?> role;
  final Value<String?> peerPublicKey;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.pubkey = const Value.absent(),
    this.isActive = const Value.absent(),
    this.keyIndex = const Value.absent(),
    this.fullPrivacy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.orderId = const Value.absent(),
    this.role = const Value.absent(),
    this.peerPublicKey = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required String pubkey,
    required bool isActive,
    required int keyIndex,
    required bool fullPrivacy,
    required DateTime createdAt,
    this.orderId = const Value.absent(),
    this.role = const Value.absent(),
    this.peerPublicKey = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pubkey = Value(pubkey),
        isActive = Value(isActive),
        keyIndex = Value(keyIndex),
        fullPrivacy = Value(fullPrivacy),
        createdAt = Value(createdAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<String>? pubkey,
    Expression<bool>? isActive,
    Expression<int>? keyIndex,
    Expression<bool>? fullPrivacy,
    Expression<DateTime>? createdAt,
    Expression<String>? orderId,
    Expression<String>? role,
    Expression<String>? peerPublicKey,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pubkey != null) 'pubkey': pubkey,
      if (isActive != null) 'is_active': isActive,
      if (keyIndex != null) 'key_index': keyIndex,
      if (fullPrivacy != null) 'full_privacy': fullPrivacy,
      if (createdAt != null) 'created_at': createdAt,
      if (orderId != null) 'order_id': orderId,
      if (role != null) 'role': role,
      if (peerPublicKey != null) 'peer_public_key': peerPublicKey,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? pubkey,
      Value<bool>? isActive,
      Value<int>? keyIndex,
      Value<bool>? fullPrivacy,
      Value<DateTime>? createdAt,
      Value<String?>? orderId,
      Value<String?>? role,
      Value<String?>? peerPublicKey,
      Value<int>? rowid}) {
    return SessionsCompanion(
      id: id ?? this.id,
      pubkey: pubkey ?? this.pubkey,
      isActive: isActive ?? this.isActive,
      keyIndex: keyIndex ?? this.keyIndex,
      fullPrivacy: fullPrivacy ?? this.fullPrivacy,
      createdAt: createdAt ?? this.createdAt,
      orderId: orderId ?? this.orderId,
      role: role ?? this.role,
      peerPublicKey: peerPublicKey ?? this.peerPublicKey,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pubkey.present) {
      map['pubkey'] = Variable<String>(pubkey.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (keyIndex.present) {
      map['key_index'] = Variable<int>(keyIndex.value);
    }
    if (fullPrivacy.present) {
      map['full_privacy'] = Variable<bool>(fullPrivacy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (peerPublicKey.present) {
      map['peer_public_key'] = Variable<String>(peerPublicKey.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('pubkey: $pubkey, ')
          ..write('isActive: $isActive, ')
          ..write('keyIndex: $keyIndex, ')
          ..write('fullPrivacy: $fullPrivacy, ')
          ..write('createdAt: $createdAt, ')
          ..write('orderId: $orderId, ')
          ..write('role: $role, ')
          ..write('peerPublicKey: $peerPublicKey, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MostroMessagesTable extends MostroMessages
    with TableInfo<$MostroMessagesTable, MostroMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MostroMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, type, content, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mostro_messages';
  @override
  VerificationContext validateIntegrity(Insertable<MostroMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MostroMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MostroMessage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MostroMessagesTable createAlias(String alias) {
    return $MostroMessagesTable(attachedDatabase, alias);
  }
}

class MostroMessage extends DataClass implements Insertable<MostroMessage> {
  final String id;
  final String type;
  final String content;
  final DateTime createdAt;
  const MostroMessage(
      {required this.id,
      required this.type,
      required this.content,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MostroMessagesCompanion toCompanion(bool nullToAbsent) {
    return MostroMessagesCompanion(
      id: Value(id),
      type: Value(type),
      content: Value(content),
      createdAt: Value(createdAt),
    );
  }

  factory MostroMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MostroMessage(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MostroMessage copyWith(
          {String? id, String? type, String? content, DateTime? createdAt}) =>
      MostroMessage(
        id: id ?? this.id,
        type: type ?? this.type,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
      );
  MostroMessage copyWithCompanion(MostroMessagesCompanion data) {
    return MostroMessage(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MostroMessage(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, content, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MostroMessage &&
          other.id == this.id &&
          other.type == this.type &&
          other.content == this.content &&
          other.createdAt == this.createdAt);
}

class MostroMessagesCompanion extends UpdateCompanion<MostroMessage> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MostroMessagesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MostroMessagesCompanion.insert({
    required String id,
    required String type,
    required String content,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        content = Value(content),
        createdAt = Value(createdAt);
  static Insertable<MostroMessage> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MostroMessagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String>? content,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MostroMessagesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MostroMessagesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $NostrEventsTable nostrEvents = $NostrEventsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $MostroMessagesTable mostroMessages = $MostroMessagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [orders, nostrEvents, sessions, mostroMessages];
}

typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  required String id,
  required OrderType kind,
  required Status status,
  required int amount,
  required String fiatCode,
  Value<int?> minAmount,
  Value<int?> maxAmount,
  required int fiatAmount,
  required String paymentMethod,
  required int premium,
  Value<String?> masterBuyerPubkey,
  Value<String?> masterSellerPubkey,
  Value<String?> buyerTradePubkey,
  Value<String?> sellerTradePubkey,
  Value<String?> buyerInvoice,
  Value<int?> createdAt,
  Value<int?> expiresAt,
  Value<int?> buyerToken,
  Value<int?> sellerToken,
  Value<int> rowid,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<String> id,
  Value<OrderType> kind,
  Value<Status> status,
  Value<int> amount,
  Value<String> fiatCode,
  Value<int?> minAmount,
  Value<int?> maxAmount,
  Value<int> fiatAmount,
  Value<String> paymentMethod,
  Value<int> premium,
  Value<String?> masterBuyerPubkey,
  Value<String?> masterSellerPubkey,
  Value<String?> buyerTradePubkey,
  Value<String?> sellerTradePubkey,
  Value<String?> buyerInvoice,
  Value<int?> createdAt,
  Value<int?> expiresAt,
  Value<int?> buyerToken,
  Value<int?> sellerToken,
  Value<int> rowid,
});

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$OrdersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$OrdersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<OrderType> kind = const Value.absent(),
            Value<Status> status = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> fiatCode = const Value.absent(),
            Value<int?> minAmount = const Value.absent(),
            Value<int?> maxAmount = const Value.absent(),
            Value<int> fiatAmount = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<int> premium = const Value.absent(),
            Value<String?> masterBuyerPubkey = const Value.absent(),
            Value<String?> masterSellerPubkey = const Value.absent(),
            Value<String?> buyerTradePubkey = const Value.absent(),
            Value<String?> sellerTradePubkey = const Value.absent(),
            Value<String?> buyerInvoice = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int?> expiresAt = const Value.absent(),
            Value<int?> buyerToken = const Value.absent(),
            Value<int?> sellerToken = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion(
            id: id,
            kind: kind,
            status: status,
            amount: amount,
            fiatCode: fiatCode,
            minAmount: minAmount,
            maxAmount: maxAmount,
            fiatAmount: fiatAmount,
            paymentMethod: paymentMethod,
            premium: premium,
            masterBuyerPubkey: masterBuyerPubkey,
            masterSellerPubkey: masterSellerPubkey,
            buyerTradePubkey: buyerTradePubkey,
            sellerTradePubkey: sellerTradePubkey,
            buyerInvoice: buyerInvoice,
            createdAt: createdAt,
            expiresAt: expiresAt,
            buyerToken: buyerToken,
            sellerToken: sellerToken,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required OrderType kind,
            required Status status,
            required int amount,
            required String fiatCode,
            Value<int?> minAmount = const Value.absent(),
            Value<int?> maxAmount = const Value.absent(),
            required int fiatAmount,
            required String paymentMethod,
            required int premium,
            Value<String?> masterBuyerPubkey = const Value.absent(),
            Value<String?> masterSellerPubkey = const Value.absent(),
            Value<String?> buyerTradePubkey = const Value.absent(),
            Value<String?> sellerTradePubkey = const Value.absent(),
            Value<String?> buyerInvoice = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int?> expiresAt = const Value.absent(),
            Value<int?> buyerToken = const Value.absent(),
            Value<int?> sellerToken = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            id: id,
            kind: kind,
            status: status,
            amount: amount,
            fiatCode: fiatCode,
            minAmount: minAmount,
            maxAmount: maxAmount,
            fiatAmount: fiatAmount,
            paymentMethod: paymentMethod,
            premium: premium,
            masterBuyerPubkey: masterBuyerPubkey,
            masterSellerPubkey: masterSellerPubkey,
            buyerTradePubkey: buyerTradePubkey,
            sellerTradePubkey: sellerTradePubkey,
            buyerInvoice: buyerInvoice,
            createdAt: createdAt,
            expiresAt: expiresAt,
            buyerToken: buyerToken,
            sellerToken: sellerToken,
            rowid: rowid,
          ),
        ));
}

class $$OrdersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<OrderType, OrderType, String> get kind =>
      $state.composableBuilder(
          column: $state.table.kind,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Status, Status, String> get status =>
      $state.composableBuilder(
          column: $state.table.status,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get fiatCode => $state.composableBuilder(
      column: $state.table.fiatCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get minAmount => $state.composableBuilder(
      column: $state.table.minAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get maxAmount => $state.composableBuilder(
      column: $state.table.maxAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get fiatAmount => $state.composableBuilder(
      column: $state.table.fiatAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get premium => $state.composableBuilder(
      column: $state.table.premium,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get masterBuyerPubkey => $state.composableBuilder(
      column: $state.table.masterBuyerPubkey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get masterSellerPubkey => $state.composableBuilder(
      column: $state.table.masterSellerPubkey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get buyerTradePubkey => $state.composableBuilder(
      column: $state.table.buyerTradePubkey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sellerTradePubkey => $state.composableBuilder(
      column: $state.table.sellerTradePubkey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get buyerInvoice => $state.composableBuilder(
      column: $state.table.buyerInvoice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get expiresAt => $state.composableBuilder(
      column: $state.table.expiresAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get buyerToken => $state.composableBuilder(
      column: $state.table.buyerToken,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sellerToken => $state.composableBuilder(
      column: $state.table.sellerToken,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$OrdersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get kind => $state.composableBuilder(
      column: $state.table.kind,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get fiatCode => $state.composableBuilder(
      column: $state.table.fiatCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get minAmount => $state.composableBuilder(
      column: $state.table.minAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get maxAmount => $state.composableBuilder(
      column: $state.table.maxAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get fiatAmount => $state.composableBuilder(
      column: $state.table.fiatAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get premium => $state.composableBuilder(
      column: $state.table.premium,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get masterBuyerPubkey => $state.composableBuilder(
      column: $state.table.masterBuyerPubkey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get masterSellerPubkey => $state.composableBuilder(
      column: $state.table.masterSellerPubkey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get buyerTradePubkey => $state.composableBuilder(
      column: $state.table.buyerTradePubkey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sellerTradePubkey => $state.composableBuilder(
      column: $state.table.sellerTradePubkey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get buyerInvoice => $state.composableBuilder(
      column: $state.table.buyerInvoice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get expiresAt => $state.composableBuilder(
      column: $state.table.expiresAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get buyerToken => $state.composableBuilder(
      column: $state.table.buyerToken,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sellerToken => $state.composableBuilder(
      column: $state.table.sellerToken,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$NostrEventsTableCreateCompanionBuilder = NostrEventsCompanion
    Function({
  required String id,
  required String pubkey,
  required String content,
  required DateTime createdAt,
  required int kind,
  required String sig,
  required String tags,
  Value<int> rowid,
});
typedef $$NostrEventsTableUpdateCompanionBuilder = NostrEventsCompanion
    Function({
  Value<String> id,
  Value<String> pubkey,
  Value<String> content,
  Value<DateTime> createdAt,
  Value<int> kind,
  Value<String> sig,
  Value<String> tags,
  Value<int> rowid,
});

class $$NostrEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NostrEventsTable,
    NostrEvent,
    $$NostrEventsTableFilterComposer,
    $$NostrEventsTableOrderingComposer,
    $$NostrEventsTableCreateCompanionBuilder,
    $$NostrEventsTableUpdateCompanionBuilder> {
  $$NostrEventsTableTableManager(_$AppDatabase db, $NostrEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$NostrEventsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$NostrEventsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> pubkey = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> kind = const Value.absent(),
            Value<String> sig = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NostrEventsCompanion(
            id: id,
            pubkey: pubkey,
            content: content,
            createdAt: createdAt,
            kind: kind,
            sig: sig,
            tags: tags,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String pubkey,
            required String content,
            required DateTime createdAt,
            required int kind,
            required String sig,
            required String tags,
            Value<int> rowid = const Value.absent(),
          }) =>
              NostrEventsCompanion.insert(
            id: id,
            pubkey: pubkey,
            content: content,
            createdAt: createdAt,
            kind: kind,
            sig: sig,
            tags: tags,
            rowid: rowid,
          ),
        ));
}

class $$NostrEventsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $NostrEventsTable> {
  $$NostrEventsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pubkey => $state.composableBuilder(
      column: $state.table.pubkey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get kind => $state.composableBuilder(
      column: $state.table.kind,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sig => $state.composableBuilder(
      column: $state.table.sig,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tags => $state.composableBuilder(
      column: $state.table.tags,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$NostrEventsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $NostrEventsTable> {
  $$NostrEventsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pubkey => $state.composableBuilder(
      column: $state.table.pubkey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get kind => $state.composableBuilder(
      column: $state.table.kind,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sig => $state.composableBuilder(
      column: $state.table.sig,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tags => $state.composableBuilder(
      column: $state.table.tags,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  required String id,
  required String pubkey,
  required bool isActive,
  required int keyIndex,
  required bool fullPrivacy,
  required DateTime createdAt,
  Value<String?> orderId,
  Value<String?> role,
  Value<String?> peerPublicKey,
  Value<int> rowid,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<String> id,
  Value<String> pubkey,
  Value<bool> isActive,
  Value<int> keyIndex,
  Value<bool> fullPrivacy,
  Value<DateTime> createdAt,
  Value<String?> orderId,
  Value<String?> role,
  Value<String?> peerPublicKey,
  Value<int> rowid,
});

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SessionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SessionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> pubkey = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> keyIndex = const Value.absent(),
            Value<bool> fullPrivacy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> orderId = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> peerPublicKey = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            pubkey: pubkey,
            isActive: isActive,
            keyIndex: keyIndex,
            fullPrivacy: fullPrivacy,
            createdAt: createdAt,
            orderId: orderId,
            role: role,
            peerPublicKey: peerPublicKey,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String pubkey,
            required bool isActive,
            required int keyIndex,
            required bool fullPrivacy,
            required DateTime createdAt,
            Value<String?> orderId = const Value.absent(),
            Value<String?> role = const Value.absent(),
            Value<String?> peerPublicKey = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion.insert(
            id: id,
            pubkey: pubkey,
            isActive: isActive,
            keyIndex: keyIndex,
            fullPrivacy: fullPrivacy,
            createdAt: createdAt,
            orderId: orderId,
            role: role,
            peerPublicKey: peerPublicKey,
            rowid: rowid,
          ),
        ));
}

class $$SessionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pubkey => $state.composableBuilder(
      column: $state.table.pubkey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get keyIndex => $state.composableBuilder(
      column: $state.table.keyIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get fullPrivacy => $state.composableBuilder(
      column: $state.table.fullPrivacy,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get peerPublicKey => $state.composableBuilder(
      column: $state.table.peerPublicKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SessionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pubkey => $state.composableBuilder(
      column: $state.table.pubkey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isActive => $state.composableBuilder(
      column: $state.table.isActive,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get keyIndex => $state.composableBuilder(
      column: $state.table.keyIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get fullPrivacy => $state.composableBuilder(
      column: $state.table.fullPrivacy,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get role => $state.composableBuilder(
      column: $state.table.role,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get peerPublicKey => $state.composableBuilder(
      column: $state.table.peerPublicKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MostroMessagesTableCreateCompanionBuilder = MostroMessagesCompanion
    Function({
  required String id,
  required String type,
  required String content,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$MostroMessagesTableUpdateCompanionBuilder = MostroMessagesCompanion
    Function({
  Value<String> id,
  Value<String> type,
  Value<String> content,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MostroMessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MostroMessagesTable,
    MostroMessage,
    $$MostroMessagesTableFilterComposer,
    $$MostroMessagesTableOrderingComposer,
    $$MostroMessagesTableCreateCompanionBuilder,
    $$MostroMessagesTableUpdateCompanionBuilder> {
  $$MostroMessagesTableTableManager(
      _$AppDatabase db, $MostroMessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MostroMessagesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MostroMessagesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MostroMessagesCompanion(
            id: id,
            type: type,
            content: content,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required String content,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MostroMessagesCompanion.insert(
            id: id,
            type: type,
            content: content,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$MostroMessagesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MostroMessagesTable> {
  $$MostroMessagesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MostroMessagesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MostroMessagesTable> {
  $$MostroMessagesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$NostrEventsTableTableManager get nostrEvents =>
      $$NostrEventsTableTableManager(_db, _db.nostrEvents);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$MostroMessagesTableTableManager get mostroMessages =>
      $$MostroMessagesTableTableManager(_db, _db.mostroMessages);
}
