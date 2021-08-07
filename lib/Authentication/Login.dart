import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Authentication/signup.dart';


class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);

        Navigator.pushReplacementNamed(context, "Home");
      }
    });
  }
  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
        print(e);
      }
    }
    else{
      print("hello");
    }
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
  }
  navigatortostart()async{
    Navigator.pushReplacementNamed(context, "Home");
  }

 @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        //width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: <Color>[Colors.orange.shade800,Colors.orange.shade600, Colors.orange.shade100],
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     
                     Text("Rocket",
                     style:GoogleFonts.courgette(
                       fontSize: 28,
                       fontWeight: FontWeight.w700,
                       color: Colors.red[600],
                       letterSpacing: 2
                       ),
                     ),
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
                  Text("Login", style:GoogleFonts.lato(
                                      fontSize: 40,
                                      color:Colors.white,
                                      fontWeight: FontWeight.w600,

                                    ),),
                  SizedBox(height: 10,),
                  Text("Welcome Back", style:GoogleFonts.lato(
                                      fontSize: 20,
                                      color:Colors.white,
                                      fontWeight: FontWeight.w600,

                                    ),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                  ),
                                  child: TextFormField(
                                    validator: (input)
                                      {
                                        if(input!.isEmpty){
                                            return "Enter email";
                                      }
                                      },
                                      onSaved: (input)=>_email=input!,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined ,color: Colors.orange.shade800,),
                                      hintText: "Enter email Address",
                                      hintStyle: GoogleFonts.lato(
                                      fontSize: 14,
                                      color:Colors.grey,
                                      fontWeight: FontWeight.w600,

                                    ),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                                //SizedBox(height:30,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                  ),
                                  child: TextFormField(
                                    validator: (input)
                                      {
                                        if(input!.length<6){
                                            return "Wrong Password";
                                      }
                                      },
                                      onSaved: (input)=>_password=input!,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock ,color: Colors.orange.shade800,),
                                      hintText: "Password",
                                      
                                      hintStyle: GoogleFonts.lato(
                                      fontSize: 14,
                                      color:Colors.grey,
                                      fontWeight: FontWeight.w600,

                                    ),
                                      border: InputBorder.none
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        GestureDetector( onTap: (){
                              Navigator.pushReplacementNamed(context, "SignUp");
                        }
                          ,child: Text(
                            "Forgot Password?", 
                            style:GoogleFonts.lato(
                                      fontSize: 12,
                                      color:Colors.grey.shade800,
                                      fontWeight: FontWeight.w600,

                                    ),)
                              ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                                login();
                            },
                          child: Container(
                            
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: <Color>[ Colors.orange.shade800,Colors.orange.shade900,Colors.orange.shade500],
                              ),
                              borderRadius: BorderRadius.circular(50),
                              //color: Colors.orange[900]
                            ),
                            child: Center(
                              child: Text("Login",style:GoogleFonts.lato(
                                      fontSize: 17,
                                      color:Colors.white,
                                      fontWeight: FontWeight.w600,
                        
                                    ),),
                            ),
                            
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 80,
                                      child: Divider(color: Colors.grey.shade600,),
                                    ),
                                    Text("or",style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color:Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,

                                    ),),
                                    Container(
                                      width: 80,
                                      child: Divider(color: Colors.grey.shade600,),
                                    ),
                                    
                                  ],
                                ),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Fluttertoast.showToast(
                                  msg: " Available in next version",
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16,
                                  backgroundColor: Colors.red,
                                  
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue
                                  ),
                                  child: Center(
                                    child: Text("Facebook",style:GoogleFonts.lato(
                                        fontSize: 16,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                              
                                      ),),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Fluttertoast.showToast(
                                  msg: " Available in next version",
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16,
                                  backgroundColor: Colors.red,
                                  
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.redAccent.shade700,
                                  ),
                                  child: Center(
                                    child: Text("Google +", style:GoogleFonts.lato(
                                        fontSize: 16,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                              
                                      ),),
                                  ),
                                ),
                              )),
                              SizedBox(width: 20,),
                              Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          Fluttertoast.showToast(
                                          msg: " Available in next version",
                                          textColor: Colors.white,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          fontSize: 16,
                                          backgroundColor: Colors.red,
                                          
                                          );
                                        },
                                        child: Container(
                                            height: 50,
                                            
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.blue.shade700,
                                          ),
                                          child: Center(
                                            child: Text("Linkedin", style:GoogleFonts.lato(
                                        fontSize: 16,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                                       ),),
                                          ),
                                        ),
                                      ),
                                    ),
                            
                          ],
                        ),
                        SizedBox(height:30),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                           child: Center(
                             child: Row(
                              children: [
                                Text("Don't have an account?", style:GoogleFonts.lato(
                                          fontSize: 14,
                                          color:Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,

                                        ),),

                                SizedBox(width: 10,),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                        Navigator.pushReplacementNamed(context, "forget");
                                    },
                                    child: Center(
                                      child: Text("Create New", style:GoogleFonts.lato(
                                        fontSize: 14,
                                        color:Colors.orange.shade800,
                                        fontWeight: FontWeight.w600,

                                      ),),
                                    ),
                                  )),
                                
                              ],

                        ),
                           ),
                         ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    
  }
}