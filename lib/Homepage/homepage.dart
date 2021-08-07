import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/Homepage/General.dart';
import 'package:news_app/Homepage/Sources.dart';
import 'package:news_app/Homepage/news_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Widget/tabs.dart';
import 'package:news_app/pages/general.dart';


class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  var user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("Login");
      }
    });
  }
  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedin = true;
      });
    }
  }
  late News no;
  List<Articles>news=[];
  General gen=General();
  late String y;

  general()async{
    await gen.getnews();
    if (!mounted) return;
    setState(() {
    news=gen.news;
    
    });
    }
    signOut() async {
    _auth.signOut();

    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentification();
    this.getUser();
    general();
  }
  void toast(){
  Fluttertoast.showToast(
                   msg: " Available in next version",
                   textColor: Colors.white,
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.CENTER,
                   fontSize: 16,
                   backgroundColor: Colors.red,
                   
                   );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          
          //backgroundColor:
          appBar: AppBar(
            backgroundColor: Colors.orange[600],
            bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.black87,
            automaticIndicatorColorAdjustment: true,
            indicatorWeight: 2.3,
            indicatorSize:TabBarIndicatorSize.label ,
              tabs: [

                    Tablls("General"),
                    Tablls("Health"),
                    Tablls("Sports"),
                    Tablls("Entertainment"),
                    Tablls("Business"),
                    Tablls("Science"),
                    Tablls("Technology"),
                    
            ],),
            elevation: 0,
            automaticallyImplyLeading: false,
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              
               SizedBox(width: 10,),
               Row(
                 children: [
                   Text("Rocket",
                   style:GoogleFonts.courgette(
                     fontSize: 28,
                     fontWeight: FontWeight.w700,
                     color: Colors.red[600],
                     letterSpacing: 2,
                     ),),
                   
                   Text("News",
                   style:GoogleFonts.courgette(
                     fontSize: 25,
                     fontWeight: FontWeight.w600,
                     letterSpacing: 2,
                     color: Colors.white,
                     ),
                   ),
                   
                 ],
               ),
               IconButton(
                 onPressed:toast,
               icon: Icon(
                 Icons.search,
                 size: 25,
                 color: Colors.white,
                )
               ),
            
               
            ],
            ),
            
            leading:Builder(builder: (context)=>IconButton(
                 onPressed: (){
                    Scaffold.of(context).openDrawer();
                   }, icon: CircleAvatar(backgroundColor:Colors.white ,//Colors.red.shade600,
                     backgroundImage: AssetImage("asset/images/avatar.png"),radius: 20,),
                   iconSize:25 ,
                   )) ,
            
          ),
      
          drawer:!isloggedin
            ? 
            Drawer(
              child: Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        height: 100.0,
                        width: 100.0,
                        ),
                    ],
                  ),
                ),
              ),
            ): Drawer(
            elevation: 0,
            child: ListView(
              children: [
              DrawerHeader(
                 decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                child: Column(
                  children: [
                    Material(
                      elevation: 8,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(50)) ,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar( radius: 40,

                        backgroundColor: Colors.red.shade600,
                        backgroundImage: AssetImage("asset/images/avatar.png"),),
                      ),
                    ) , 
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("${user.displayName}",
                      style:GoogleFonts.lato(
                     fontSize: 21,
                     fontWeight: FontWeight.w700,
                     //letterSpacing: 2,
                     color: Colors.black,
                     ),)),
                    ),
                  ],
                )),
              
              CustomTile(Icons.person,"Profile",toast),
              CustomTile(Icons.settings_rounded,"Settings",toast),
              CustomTile(Icons.logout_outlined,"Logout",signOut),
              SizedBox(height:410),
              Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Version 1.0",
                      style:GoogleFonts.lato(
                     fontSize: 16,
                     fontWeight: FontWeight.w700,
                     letterSpacing: 2,
                     color: Colors.black,
                     ),
                     ),
                     ),
                    ),
              
            ],),

          ),

          body: !isloggedin
            ? 
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 100.0,
                      width: 100.0,
                      ),
                  ],
                ),
              ),
            ):TabBarView(
                    children:<Widget>[ 

            Control(),
            Clone("health"),
            Clone("sports"),
            Clone("Entertainment"),
            Clone("Business"),
            Clone("Science"),
            Clone("Technology"),
            
            ]
          ),
        ),
      
    );
  }
}

class CustomTile extends StatelessWidget {
  var icon,text;
  var ontap;

  CustomTile(this.icon,this.text,this.ontap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: InkWell(
        splashColor: Colors.orange.shade700,
        onTap: ontap,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(text,
                    style:GoogleFonts.lato(
                     fontSize: 16,
                     fontWeight: FontWeight.w500,
                     //letterSpacing: 2,
                     color: Colors.black,
                     ),),
                  
                  )

                ],
              ),
              Icon(Icons.arrow_right),
              
            ],
          ),
          ),
      ),
    );
  }
}