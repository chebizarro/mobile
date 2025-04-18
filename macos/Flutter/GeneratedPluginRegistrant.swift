//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import flutter_local_notifications
import flutter_secure_storage_darwin
import local_auth_darwin
import path_provider_foundation
import shared_preferences_foundation
import sqlite3_flutter_libs
import system_tray

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FlutterLocalNotificationsPlugin.register(with: registry.registrar(forPlugin: "FlutterLocalNotificationsPlugin"))
  FlutterSecureStorageDarwinPlugin.register(with: registry.registrar(forPlugin: "FlutterSecureStorageDarwinPlugin"))
  FLALocalAuthPlugin.register(with: registry.registrar(forPlugin: "FLALocalAuthPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  Sqlite3FlutterLibsPlugin.register(with: registry.registrar(forPlugin: "Sqlite3FlutterLibsPlugin"))
  SystemTrayPlugin.register(with: registry.registrar(forPlugin: "SystemTrayPlugin"))
}
