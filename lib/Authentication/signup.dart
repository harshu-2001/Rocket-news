import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Authentication/check.dart';
import 'package:news_app/Authentication/database.dart';
import 'package:string_validator/string_validator.dart';

class Signup extends StatefulWidget {
 
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  var _name, _email, _password,check,_mob;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }
   signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var c= new Check(_name, _email, _mob);
      savepost(c);
      if(equals(check,_password)){
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser!.updateDisplayName(_name);
          
        }
      } catch (e) {
        showError(e.toString(),"error");
        print(e);
      }
    }
    else{
      showError("Password unmatched", "Incorrect");
    }
   }
  }
 showError(String errormessage,String val) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$val'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
@override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

 navigatortoLogin()async{
    Navigator.pushReplacementNamed(context, "Login");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        //width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: <Color>[
              Colors.orange.shade700,
              Colors.orange.shade600, 
              Colors.orange.shade200,
              ],
          )
          
        ),
        child: Expanded(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
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

                 Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text("Let's get Started ",textAlign: TextAlign.center, style: GoogleFonts.lato(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0.1, 10, 5),
              child: Text("Create an account to see news ",textAlign: TextAlign.center, style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600
              ),),
            ),    
            SizedBox(height:20),
                  ],
        
              ),
            ),
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                    ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formKey,
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[

                                SizedBox(height:25),
                                Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10)
                                      )]
                                    ),
                                      child: TextFormField(
                                         validator: (input)
                                                {
                                                  if(input!.isEmpty){
                                                      return "Empty";
                                                }
                                                },
                                                onSaved: (input)=>_name=input!,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.person ,color: Colors.orange.shade800,),
                                                hintText: "Full Name ",
                                                hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
                                                border: InputBorder.none
                                              ),
                                      ),
                                    ),
                                    
                                SizedBox(height: 20,),
                                Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10)
                                      )]
                                    ),
                                      child: TextFormField(
                                         validator: (input)
                                                {
                                                  if(input!.isEmpty){
                                                      return "Empty";
                                                }
                                                },
                                                onSaved: (input)=>_email=input!,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.mail_outline,color: Colors.orange.shade800,),
                                                hintText: "Email Address",
                                                hintStyle:GoogleFonts.lato(
                                                    fontSize: 14,
                                                    color:Colors.grey,
                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                border: InputBorder.none
                                              ),

                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                   
                                   Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10)
                                      )]
                                    ),
                                      child: TextFormField(
                                         validator: (input)
                                                {
                                                  if(input!.length<10){
                                                      return "wrong number";
                                                }
                                                },
                                                onSaved: (input)=>_mob=input!,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.call ,color: Colors.orange.shade800,),
                                                hintText: "Mobile number",
                                                hintStyle:GoogleFonts.lato(
                                                    fontSize: 14,
                                                    color:Colors.grey,
                                                    fontWeight: FontWeight.w600,

                                                  ),
                                                border: InputBorder.none
                                              ),
                                      ),
                                    ),
                                  SizedBox(height:20),
                                   Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10)
                                      )]
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
                                     SizedBox(height: 20,),
                                   Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10)
                                      )]
                                    ),

                                      child: TextFormField(
                                    validator: (input)
                                      {
                                        if(input!.length<6){
                                            return "Wrong Password";
                                      }
                                      },
                                      onSaved: (input)=>check=input!,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock ,color: Colors.orange.shade800,),
                                      hintText: "Confirm Password",
                                      
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

                                    SizedBox(height: 20,),

                                Container(
                                  
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      colors: <Color>[ Colors.orange.shade700,Colors.orange.shade500,Colors.orange.shade900],
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    //color: Colors.orange[900]
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                          signUp();
                                    },
                                    child: Center(
                                      child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                                SizedBox(height: 10,)
                              ],
                            ),
                          )
                          
                          
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: Row(
                            children: [
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
                                            color: Colors.blue
                                          ),
                                          child: Center(
                                            child: Text("Facebook", style:GoogleFonts.lato(
                                        fontSize: 16,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                                
                                      ),),
                                          ),
                                        ),
                                ),
                              ),
                                    SizedBox(width: 10,),
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
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child: Text("Google +", style:GoogleFonts.lato(
                                        fontSize: 16,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                                       ),),
                                          ),
                                          
                                        ),
                                      ),
                                    ),
                                    
                                    SizedBox(width: 10,),
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
                        ),
                        SizedBox(height: 20,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?", style: TextStyle(color: Colors.black),),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                  navigatortoLogin();
                              },
                              child: Text("Login Here", style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold),),
                            ),
                            
                          ],
                        )     
                              
                      ],
                    ),
                  ),
                ),
                
              
                ),
            ),
            ],
          ),
        ),
      ),
      );
 }
}
