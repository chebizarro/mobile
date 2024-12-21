import 'package:bip32_bip44/dart_bip32_bip44.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:dart_nostr/dart_nostr.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyManager {
  final FlutterSecureStorage secureStorage;
  final SharedPreferencesAsync sharedPreferences;

  static const String _masterKeyKey = 'master_key';
  static const String _mnemonicKey = 'mnemonic';
  static const String _keyIndexKey = 'key_index';

  KeyManager({required this.secureStorage, required this.sharedPreferences});

  static String getPrivateKeyFromMnemonic(String mnemonic) {
    final seed = bip39.mnemonicToSeedHex(mnemonic);
    final chain = Chain.seed(seed);
    final key = chain.forPath("m/44'/1237'/38383'/0/0");
    return key.privateKeyHex();
  }

  static String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  static bool isMnemonicValid(String text) {
    return bip39.validateMnemonic(text);
  }

  Future<bool> hasMasterKey() async {
    String? masterKey = await secureStorage.read(key: _masterKeyKey);
    return masterKey != null;
  }

  Future<NostrKeyPairs?> getMasterKey() async {
    String? masterKeyHex = await secureStorage.read(key: _masterKeyKey);
    if (masterKeyHex == null) {
      return null;
    }
    return NostrKeyPairs(private: masterKeyHex);
  }

  Future<void> generateAndStoreMasterKey() async {
    final mnemonic = bip39.generateMnemonic();
    final key = getPrivateKeyFromMnemonic(mnemonic);
    await secureStorage.write(key: _mnemonicKey, value: mnemonic);
    await secureStorage.write(key: _masterKeyKey, value: key);
  }

  /// Derives a new trade key based on the current key index.
  Future<NostrKeyPairs> deriveTradeKey() async {
    int currentIndex = await sharedPreferences.getInt(_keyIndexKey) ?? 0;
    final masterKey = await getMasterKey();
    if (masterKey == null) {
      throw Exception('Master key not found.');
    }
    final chain = Chain.import(masterKey.private);
    final key = chain.forPath("m/44'/1237'/38383'/0/0") as ExtendedPrivateKey;
    final tradeKey = deriveExtendedPrivateChildKey(key, currentIndex);

    // Increment and save the key index
    await sharedPreferences.setInt(_keyIndexKey, currentIndex + 1);

    return NostrKeyPairs(private: tradeKey.privateKeyHex());
  }

  /// Retrieves the current key index
  Future<int> getCurrentKeyIndex() async {
    return await sharedPreferences.getInt(_keyIndexKey) ?? 0;
  }
}
