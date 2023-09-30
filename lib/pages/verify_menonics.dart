import 'package:cryptoWallet/pages/home_page.dart';
import 'package:cryptoWallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class VerifyMenonics extends StatefulWidget {
  String data;
   VerifyMenonics({super.key,required this.data});

  @override
  State<VerifyMenonics> createState() => _VerifyMenonicsState();
}

class _VerifyMenonicsState extends State<VerifyMenonics> {
  

  final _verifyController= TextEditingController();
  String verifyCase="";

  bool _verifyData=false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WalletProvider>(context);
    return  Scaffold(body: Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Column(
        children: [
          TextFormField(controller: _verifyController,onTap: ()  {
            setState(() {
              _verifyData=true;
            });
          },),
          InkWell(onTap: ()async{
            if (widget.data==_verifyController.text) {
              print(true);
          var  data= await provider.getPrivateKey(_verifyController.text);

         await  provider.getPublicKey(data);
              print(data);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
            } else {
              print("object");
              
            }
            
          },child: Container(child: Center(child: Text("Verify")),height: 50,width: 300,color: Colors.amber,))
        ],
      ),
    ),);
  }
}