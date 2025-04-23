import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mostro_mobile/data/models/nostr_filter.dart';
import 'package:mostro_mobile/data/repositories/event_storage.dart';
import 'package:mostro_mobile/features/settings/settings.dart';
import 'package:mostro_mobile/notifications/notification_service.dart';
import 'package:mostro_mobile/services/nostr_service.dart';
import 'package:mostro_mobile/shared/providers/mostro_database_provider.dart';

bool isAppForeground = false;

@pragma('vm:entry-point')
Future<void> serviceMain(ServiceInstance service) async {
  // For Android, we rely on the AndroidConfiguration to set up the foreground service
  if (service is AndroidServiceInstance) {
    //await service.setAsForegroundService();
  }

  final Map<String, Map<String, dynamic>> activeSubscriptions = {};
  final nostrService = NostrService();
  final db = await openMostroDatabase('mostro.db');
  final eventStore = EventStorage(db: db);

  service.on('app-foreground-status').listen((data) {
    isAppForeground = data?['is-foreground'] ?? isAppForeground;
  });

  service.on('start').listen((data) async {
    if (data == null) return;

    final settingsMap = data['settings'];
    if (settingsMap == null) return;

    try {
      final settings = Settings.fromJson(settingsMap);
      await nostrService.init(settings);
      
      // Notify successful initialization
      service.invoke('on-start', {
        'isRunning': true,
        'initialized': true,
      });
    } catch (e) {
      // Notify initialization failure
      service.invoke('on-start', {
        'isRunning': false,
        'error': e.toString(),
      });
    }
  });

  service.on('create-subscription').listen((data) async {
    if (data == null || data['filters'] == null) return;

    try {
      final filterMap = data['filters'];
      final filters = filterMap.toList();
      final request = NostrRequestX.fromJson(filters);

      final subscription = nostrService.subscribeToEvents(request);
      subscription.listen(
        (event) async {
          if (await eventStore.hasItem(event.id!)) return;
          await showLocalNotification(event);
        },
        onError: (error) {
          // Report subscription error back to the app
          service.invoke('subscription-error', {
            'error': error.toString(),
          });
        },
      );

      // Notify successful subscription
      service.invoke('subscription-created', {
        'success': true,
      });
    } catch (e) {
      // Notify subscription failure
      service.invoke('subscription-error', {
        'error': e.toString(),
      });
    }
  });

  service.on('cancel-subscription').listen((event) {
    if (event == null) return;

    final id = event['id'] as String?;
    if (id != null && activeSubscriptions.containsKey(id)) {
      activeSubscriptions.remove(id);
      nostrService.unsubscribe(id);
    }
  });

  service.on("stop").listen((event) async {
    nostrService.disconnectFromRelays();
    await db.close();
    service.stopSelf();
  });

  // Initial service ready notification
  service.invoke('on-start', {
    'isRunning': true,
    'initialized': false,
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}
