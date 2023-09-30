import 'package:cryptoWallet/pages/verify_menonics.dart';
import 'package:cryptoWallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var mnemonicsWords = "";
  bool _set = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WalletProvider>(context);
    var mnemonicsList = mnemonicsWords.split(" ");
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _set
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                          mnemonicsList.length,
                          (index) =>
                              Text("${index + 1} ${mnemonicsList[index]}")),
                      InkWell(
                          onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyMenonics(data: mnemonicsWords,)));
                            Clipboard.setData(
                                ClipboardData(text: mnemonicsWords));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.amber,
                                content: Text(mnemonicsWords)));
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            color: Colors.black,
                            child: const Center(
                                child: Text(
                              "data",
                              style: TextStyle(color: Colors.white),
                            )),
                          ))
                    ],
                  )
                : InkWell(
                    onTap: () async {
                      var mnemonics = provider.getMnemonics();
                      setState(() {
                        mnemonicsWords = mnemonics;
                        _set = true;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      color: Colors.amber,
                      child: const Center(
                        child: Text(
                          "Create Wallet",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
