import 'package:dart_nostr/nostr/model/event/event.dart';
import 'package:equatable/equatable.dart';
import 'package:mostro_mobile/data/models/mostro_message.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderDetails extends OrderDetailsEvent {
  final NostrEvent order;

  const LoadOrderDetails(this.order);

  @override
  List<Object> get props => [order];
}

class CancelOrder extends OrderDetailsEvent {}

class ContinueOrder extends OrderDetailsEvent {
  final NostrEvent order;

  const ContinueOrder(this.order);

  @override
  List<Object> get props => [order];
}

class OrderUpdateReceived extends OrderDetailsEvent {
  final MostroMessage order;

  const OrderUpdateReceived(this.order);

  @override
  List<Object> get props => [order];
}
