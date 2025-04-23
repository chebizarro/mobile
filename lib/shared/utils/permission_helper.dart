import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<void> requestNotificationPermissions() async {
    if (!Platform.isAndroid) return;

    // Request notification permission for Android 13+ (API level 33+)
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    // For Android 14+ (API level 34+), foreground service permissions are
    // automatically granted when declared in the manifest
  }
}
