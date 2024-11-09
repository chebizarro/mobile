import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/data/repositories/mostro_order_repository.dart';
import 'package:mostro_mobile/data/repositories/order_repository_interface.dart';
import 'package:mostro_mobile/data/repositories/secure_storage_manager.dart';
import 'package:mostro_mobile/presentation/home/bloc/home_bloc.dart';
import 'package:mostro_mobile/services/exchange_service.dart';
import 'package:mostro_mobile/services/mostro_service.dart';
import 'package:mostro_mobile/services/nostr_service.dart';
import 'package:mostro_mobile/services/yadio_exchange_service.dart';

final nostrServicerProvider = Provider<NostrService>((ref) {
  return NostrService()..init();
});

final mostroServiceProvider = Provider<MostroService>((ref) {
  final nostrService = ref.read(nostrServicerProvider);
  return MostroService(nostrService);
});

final ordersRepositoryProvider = Provider<OrderRepository>((ref) {
  final ordersRepository = ref.read(mostroServiceProvider);
  return MostroOrderRepository(ordersRepository);
});

final homeBlocProvider = Provider<HomeBloc>((ref) {
  final orderRepository = ref.read(ordersRepositoryProvider);
  return HomeBloc(orderRepository);
});

final sessionManagerProvider = Provider<SecureStorageManager>((ref) {
  return SecureStorageManager();
});

final exchangeServiceProvider = Provider<ExchangeService>((ref) {
  return YadioExchangeService();
});

final exchangeRateProvider = StateNotifierProvider.family<ExchangeRateNotifier, AsyncValue<double>, String>((ref, currency) {
  final exchangeService = ref.read(exchangeServiceProvider);
  final notifier = ExchangeRateNotifier(exchangeService);
  notifier.fetchExchangeRate(currency);
  return notifier;
});

final currencyCodesProvider = FutureProvider<Map<String, String>>((ref) async {
  final exchangeService = ref.read(exchangeServiceProvider);
  return await exchangeService.getCurrencyCodes();
});

