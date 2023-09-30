import 'package:cryptoWallet/pages/send_screen.dart';
import 'package:cryptoWallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  String ethAddress = "";
  String balance = "";
  loadData() async {
    PrefService prefService = PrefService();
    var data = await prefService.getPrivateKey();
    final walletProvider = WalletProvider();

    EthereumAddress address = await walletProvider.getPublicKey(data);
    setState(() {
      ethAddress = address.hex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WalletProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ethAddress),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () async {
                // BigInt bigIntValue = BigInt.from(amount * pow(10, 18));
                // print(bigIntValue);
                // EtherAmount ethAmount =
                //     EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                // print(ethAmount);
Navigator.push(context, MaterialPageRoute(builder: (_)=>SendScreen(ethAddress:ethAddress)));
              },
              child: const Text("Send"))
        ],
      ),
    );
  }

  sendToken(receiver, amount) async {
    PrefService prefService = PrefService();
    var data = await prefService.getPrivateKey();
    var apiUrl = "";

    var httpClient = http.Client();
    var web3Client = Web3Client(apiUrl, httpClient);
    EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex("0x" + data);
    EtherAmount etherAmount =
        await web3Client.getBalance(ethPrivateKey.address);
    EtherAmount gasAmount = await web3Client.getGasPrice();

    await web3Client.sendTransaction(
        ethPrivateKey,
        Transaction(
            to: EthereumAddress.fromHex(receiver),
            value: amount,
            maxGas: 100000,
            gasPrice: gasAmount),chainId: 111111);
  }
}
