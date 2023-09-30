import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../provider/wallet_provider.dart';
import 'home_page.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    loadScreen();
  }
  
    loadScreen()async{
      PrefService prefService=PrefService();
    var data =await prefService.getPrivateKey();
        if (data!=null) {
          print(data);
        return Timer(
            const Duration(seconds: 2),
            (() => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const HomePage()))));
      } else {
        return Timer(
            const Duration(seconds: 2),
            (() => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const MainScreen()))));
      }
 
    }
  @override
  Widget build(BuildContext context) {
 return Scaffold(body: Center(child: Text("Wallet"),),);
  }
}