import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../provider/wallet_provider.dart';

class SendScreen extends StatefulWidget {
  final ethAddress;
  const SendScreen({super.key, this.ethAddress});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: [
            TextFormField(
              controller: _addressController,
            ),
            TextFormField(
              controller: _amountController,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  var amount= num.parse(_amountController.text);
                  BigInt bigInt = BigInt.from( amount* pow(10, 18));
                  EtherAmount etherAmount =
                      EtherAmount.fromBigInt(EtherUnit.wei, bigInt);
                  print(etherAmount);
                  // sendToken(_addressController.text, etherAmount);
                  getUserTransactionHistory();

                },
                child: Container(
                  height: 50,
                  width: 230,
                  color: Colors.cyanAccent,
                  child: const Center(
                    child: Text("Send"),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
  getUserTransactionHistory() async {
    var apiUrl =
        "https://polygon-mumbai.g.alchemy.com/v2/pqv_HkAtQjslgUcuMXuG_xC7wF99yVXA";// Replace with your Infura project ID or other Ethereum node URL
  final client = Web3Client(apiUrl, Client());

  final ethAddress = EthereumAddress.fromHex(widget.ethAddress);

  final transactions = await client.getTransactionByHash (
  "0x1eef94aa726cb9b40c91cd72bd7ac50441d44ef55c24928b8988abfcfb161438"
  );

  print(transactions);
  return transactions;
}

  sendToken(receiver, amount) async {
    PrefService prefService = PrefService();
    var data = await prefService.getPrivateKey();
    var apiUrl =
        "https://polygon-mumbai.g.alchemy.com/v2/pqv_HkAtQjslgUcuMXuG_xC7wF99yVXA";
    try {
      var httpClient = http.Client();
      var web3Client = Web3Client(apiUrl, httpClient);
      final ethPrivateKey = EthereumAddress.fromHex(widget.ethAddress);
      print(ethPrivateKey);
      final etherAmount = await web3Client.getBalance(ethPrivateKey);
      final bala = etherAmount.getValueInUnit(EtherUnit.ether);
      EtherAmount gasAmount = await web3Client.getGasPrice();
      print(bala);
      print(gasAmount);

     var trans= await web3Client.sendTransaction(
          EthPrivateKey.fromHex("0x$data"),
          Transaction(
              to: EthereumAddress.fromHex(receiver),
              // to: EthereumAddress.fromHex(receiver),
              value: amount,
              maxGas: 100000,
              gasPrice: gasAmount),
          chainId: 80001);
          print(trans);
    } catch (e) {
      print(e);
    }
  }
}
