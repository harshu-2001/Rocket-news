import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tablls extends StatefulWidget {
  String s;
 
  Tablls(this.s);
  @override
  _TabllsState createState() => _TabllsState(s);
}

class _TabllsState extends State<Tablls> {
  String s;
  

  _TabllsState(this.s);
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(s,style:GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    
                    ),),); 
  }
}