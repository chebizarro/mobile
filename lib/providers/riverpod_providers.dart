import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/data/repositories/mostro_order_repository.dart';
import 'package:mostro_mobile/data/repositories/order_repository_interface.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:mostro_mobile/services/mostro_service.dart';
import 'package:mostro_mobile/services/nostr_service.dart';

final nostrServicerProvider = Provider<NostrService>((ref) {
  final nostrService = NostrService();
  nostrService.init();
  return nostrService;
});

final mostrServiceProvider = Provider<MostroService>((ref) {
  final nostrService = ref.read(nostrServicerProvider);
  return MostroService(nostrService);
});

final ordersRepositoryProvider = Provider<OrderRepository>((ref) {
  final ordersRepository = ref.read(mostrServiceProvider);
  return MostroOrderRepository(ordersRepository);
});

final homeBlocProvider = Provider<HomeBloc>((ref) {
  final orderRepository = ref.read(ordersRepositoryProvider);
  return HomeBloc(orderRepository);
});
