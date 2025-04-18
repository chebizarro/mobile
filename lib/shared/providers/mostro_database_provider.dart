import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostro_mobile/data/database/database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<AppDatabase> openMostroDatabase() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'mostro.db'));
  return AppDatabase(file.path);
}

final mostroDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError();
});
