import 'dart:async';

import 'package:dart_nostr/nostr/model/request/filter.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mostro_mobile/background/background.dart';
import 'package:mostro_mobile/core/config.dart';
import 'package:mostro_mobile/features/settings/settings.dart';
import 'abstract_background_service.dart';

class MobileBackgroundService implements BackgroundService {
  Settings _settings;

  MobileBackgroundService(this._settings);

  final service = FlutterBackgroundService();

  final _subscriptions = <String, Map<String, dynamic>>{};
  bool _isRunning = false;
  bool _isInitialized = false;
  bool _isStarting = false;
  Completer<void>? _initCompleter;

  @override
  Future<void> init() async {
    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: serviceMain,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: false,
        onStart: serviceMain,
        isForegroundMode: true,
        autoStartOnBoot: true,
        foregroundServiceNotificationId: Config.notificationId,
        initialNotificationTitle: 'Mostro Service',
        initialNotificationContent: 'Initializing...',
        notificationChannelId: 'mostro_foreground',
      ),
    );

    service.on('on-start').listen((data) {
      _isRunning = true;
      _isStarting = false;
      if (!_isInitialized) {
        _isInitialized = true;
        if (_initCompleter?.isCompleted == false) {
          _initCompleter?.complete();
        }
      }
    });

    // Handle service stop
    service.on('on-stop').listen((data) {
      _isRunning = false;
      _isInitialized = false;
      _isStarting = false;
      if (_initCompleter?.isCompleted == false) {
        _initCompleter?.completeError('Service stopped');
      }
      _initCompleter = null;
    });
  }

  @override
  Future<void> subscribe(List<NostrFilter> filters) async {
    // If service isn't running, start it
    if (!_isRunning) {
      await _startService();
    }

    // Create initial completer if needed
    _initCompleter ??= Completer<void>();

    // Wait for service to be fully initialized
    if (!_isInitialized) {
      await _initCompleter?.future;
    }

    // Add retry logic for subscription
    int retryCount = 0;
    const maxRetries = 3;
    const retryDelay = Duration(seconds: 1);

    while (retryCount < maxRetries) {
      try {
        service.invoke('create-subscription', {
          'filters': filters.map((f) => f.toMap()).toList(),
        });
        break;
      } catch (e) {
        retryCount++;
        if (retryCount == maxRetries) {
          throw Exception('Failed to create subscription after $maxRetries attempts');
        }
        await Future.delayed(retryDelay);
      }
    }
  }

  @override
  Future<bool> unsubscribe(String subscriptionId) async {
    if (!_subscriptions.containsKey(subscriptionId)) {
      return false;
    }

    _subscriptions.remove(subscriptionId);
    service.invoke('cancel-subscription', {
      'id': subscriptionId,
    });

    if (_subscriptions.isEmpty && _isRunning) {
      await _stopService();
    }

    return true;
  }

  @override
  Future<void> unsubscribeAll() async {
    for (final id in _subscriptions.keys.toList()) {
      await unsubscribe(id);
    }
  }

  @override
  Future<int> getActiveSubscriptionCount() async {
    return _subscriptions.length;
  }

  @override
  Future<void> setForegroundStatus(bool isForeground) async {
    if (isForeground) {
      await _stopService();
    } else {
      await _startService();
    }
  }

  Future<void> _startService() async {
    if (_isRunning || _isStarting) return;
    _isStarting = true;

    // Reset initialization state
    _isInitialized = false;
    if (_initCompleter?.isCompleted == false) {
      _initCompleter?.completeError('Service restarting');
    }
    _initCompleter = Completer<void>();

    // Start service with settings immediately
    await service.startService();
    service.invoke('start', {
      'settings': _settings.toJson(),
    });

    // Wait for service to be running with a shorter timeout for Android foreground service requirements
    final timeout = const Duration(seconds: 5);
    final startTime = DateTime.now();

    while (!(await service.isRunning())) {
      if (DateTime.now().difference(startTime) > timeout) {
        throw Exception('Service failed to start within $timeout');
      }
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  Future<void> _stopService() async {
    if (!_isRunning) return;

    service.invoke('stop');
    _isRunning = false;
    _isInitialized = false;
  }

  @override
  void updateSettings(Settings settings) {
    _settings = settings;
  }

  @override
  bool get isRunning => _isRunning;
}
