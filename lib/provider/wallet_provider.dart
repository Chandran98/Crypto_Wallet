// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/foundation.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletProvider extends ChangeNotifier {
  getMnemonics() {
    return bip39.generateMnemonic();
  }

  getPrivateKey(mnemonics) async {
    final seedBytes = bip39.mnemonicToSeed(mnemonics);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seedBytes);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;

    return address;
  }
}
