import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgot extends StatefulWidget {
  const Forgot({ Key? key }) : super(key: key);

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email;
Future<void>forgotpass()async{
  
  if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        await _auth.sendPasswordResetEmail(email: _email);
         showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text("Password Reset Link sended to $_email"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
      } catch (e) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange.shade800,
        title: Row(
          children: [
            IconButton(onPressed: (){
                Navigator.popAndPushNamed(context, "Login");
            }, icon: Icon(Icons.arrow_back_ios_new)),
            SizedBox(width:30),
            Text("Forget Password"),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: <Color>[Colors.orange.shade800,Colors.orange.shade600, Colors.orange.shade100],
          )
        ),
        child: Column(
          children: <Widget>[

            SizedBox(height:40),
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
            SizedBox(height:30),
             Text("Forgot Password", style:GoogleFonts.lato(
                                      fontSize:30,
                                      color:Colors.white,
                                      fontWeight: FontWeight.w600,

                                    ),),
                  SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                                  child: Container(
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
                                      autofocus: true,
                                    ),
                                  ),),),
                ],
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
                            onTap: (){
                                  forgotpass();
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
                                child: Text("Reset Link",style:GoogleFonts.lato(
                                        fontSize: 17,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w600,
                          
                                      ),),
                              ),
                              
                            ),
                          ),
                          
            
            ]
        ),)
    );
  }
}