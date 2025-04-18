import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';
import '../repositories/event_repository.dart';
import '../repositories/mostro_message_repository.dart';
import '../repositories/order_repository.dart';
import '../repositories/session_repository.dart';
import '../../features/key_manager/key_manager_provider.dart';

part 'database_provider.g.dart';

@riverpod
Future<AppDatabase> database(DatabaseRef ref) async {
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'mostro.db');
  return AppDatabase(dbPath);
}

@riverpod
EventRepository eventRepository(EventRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return EventRepository(db.requireValue);
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return OrderRepository(db.requireValue);
}

@riverpod
SessionRepository sessionRepository(SessionRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  final keyManager = ref.watch(keyManagerProvider);
  return SessionRepository(db.requireValue, keyManager: keyManager);
}

@riverpod
MostroMessageRepository mostroMessageRepository(MostroMessageRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return MostroMessageRepository(db.requireValue);
}
