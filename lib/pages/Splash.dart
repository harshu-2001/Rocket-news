import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Homepage/homepage.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.of(context).pushReplacementNamed("Home");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatetohome();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade600,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            
            color:Colors.orange.shade600,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Container(
                  
                  child: Image.asset("asset/images/s.png",fit: BoxFit.fill),),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}