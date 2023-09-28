import 'package:cryptoWallet/pages/main_screen.dart';
import 'package:cryptoWallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
     ChangeNotifierProvider(create: (_)=>WalletProvider())
    ],child:  const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Crypto Wallet',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
