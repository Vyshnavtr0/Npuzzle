
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puzzle/board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {
  String? playtype="3";
  late SharedPreferences prefs;
  next(context) async {
   prefs = await SharedPreferences.getInstance();
   String? playtype = prefs.getString('playtype');
   if(playtype==null){
     setState(() {
       playtype ="3";
     });
   }
   await Future.delayed(const Duration(seconds: 3));
   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>board(playtype: playtype!,)));
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    
    next(context);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
           backgroundColor: Colors.transparent,
           body: Center(
             child: Image.asset(
          "assets/images/logo.png",
          height: MediaQuery.of(context).size.width/2,
          width: MediaQuery.of(context).size.width/1.5,
          fit: BoxFit.contain,
        ),
           ),

        ),
      ],
    );
  }
}