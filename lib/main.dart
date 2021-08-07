import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Authentication/Login.dart';
import 'package:news_app/Authentication/forgot.dart';
import 'package:news_app/Authentication/signup.dart';
import 'package:news_app/pages/Splash.dart';

import 'Homepage/homepage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "RocketNews",
    debugShowCheckedModeBanner: false,
  home:MyApp(),
  
  ),
  
  );

}
class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rocket News",
      home: Splash(),
    routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>Signup(),
        "Home":(BuildContext context)=>Homepage(),
        "forget":(BuildContext context)=>Forgot(),
        
      },
    );
  }
}
