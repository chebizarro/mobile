import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostro_mobile/data/repositories/order_repository_interface.dart';
import 'add_order_event.dart';
import 'add_order_state.dart';

class AddOrderBloc extends Bloc<AddOrderEvent, AddOrderState> {
  final OrderRepository orderRepository;

  AddOrderBloc(this.orderRepository) : super(const AddOrderState()) {
    on<ChangeOrderType>(_onChangeOrderType);
    on<SubmitOrder>(_onSubmitOrder);
  }

  void _onChangeOrderType(ChangeOrderType event, Emitter<AddOrderState> emit) {
    emit(state.copyWith(currentType: event.orderType));
  }

  void _onSubmitOrder(SubmitOrder event, Emitter<AddOrderState> emit) {
    // For now, just emit a success state

    //orderRepository.createOrder(order);

    emit(state.copyWith(status: AddOrderStatus.success));
  }
}
