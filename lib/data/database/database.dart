import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mostro_mobile/data/models/enums/order_type.dart';
import 'package:mostro_mobile/data/models/enums/status.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// Configure Drift to handle multiple database instances
void configureDriftRuntime() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
}

@DriftDatabase(tables: [
  Orders,
  NostrEvents,
  Sessions,
  MostroMessages,
])
class AppDatabase extends _$AppDatabase {
  // Call configureDriftRuntime in constructor to ensure it's set for each instance
  AppDatabase([String? path]) : super(_openConnection(path)) {
    configureDriftRuntime();
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          await m.alterTable(TableMigration(sessions));
        }
      },
    );
  }
}

LazyDatabase _openConnection([String? path]) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path ?? p.join(dbFolder.path, 'mostro.db'));
    return NativeDatabase.createInBackground(file);
  });
}

class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get kind => textEnum<OrderType>()();
  TextColumn get status => textEnum<Status>()();
  IntColumn get amount => integer()();
  TextColumn get fiatCode => text()();
  IntColumn get minAmount => integer().nullable()();
  IntColumn get maxAmount => integer().nullable()();
  IntColumn get fiatAmount => integer()();
  TextColumn get paymentMethod => text()();
  IntColumn get premium => integer()();
  TextColumn get masterBuyerPubkey => text().nullable()();
  TextColumn get masterSellerPubkey => text().nullable()();
  TextColumn get buyerTradePubkey => text().nullable()();
  TextColumn get sellerTradePubkey => text().nullable()();
  TextColumn get buyerInvoice => text().nullable()();
  IntColumn get createdAt => integer().nullable()();
  IntColumn get expiresAt => integer().nullable()();
  IntColumn get buyerToken => integer().nullable()();
  IntColumn get sellerToken => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class NostrEvents extends Table {
  TextColumn get id => text()();
  TextColumn get pubkey => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get kind => integer()();
  TextColumn get sig => text()();
  TextColumn get tags => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get pubkey => text()();
  BoolColumn get isActive => boolean()();
  IntColumn get keyIndex => integer()();
  BoolColumn get fullPrivacy => boolean()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get orderId => text().nullable()();
  TextColumn get role => text().nullable()();
  TextColumn get peerPublicKey => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MostroMessages extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
