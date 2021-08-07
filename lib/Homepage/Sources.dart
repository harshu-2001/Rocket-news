import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Homepage/news_api.dart';
import 'package:news_app/pages/general.dart';
import 'package:url_launcher/url_launcher.dart';

class Clone extends StatefulWidget {
 String s;
 Clone(this.s);

  @override
  _CloneState createState() => _CloneState(s);
}

class _CloneState extends State<Clone> {
  General gen=General();
  List<Articles>news1=[];
  String s;
  _CloneState(this.s);
  Future fun()async{
    await gen.getcat(s);
    setState(() {
      news1=gen.news1;
    });
  }
 @override
  void initState() {
    super.initState();
    fun();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: news1.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          print(news1[index].urlToImage.toString());
          return Padding(
           padding: const EdgeInsets.all(4.0),
           child: Container(
             
             child: GestureDetector(
                  onTap:() async {
                    var url = news1[index].url;
                    if (await canLaunch(url)) {
                      await launch(url, forceSafariVC: true, forceWebView: true);
                    } else {
                      throw 'Could not launch $url';
                    }
                    },

               child: Card(
                 //color:  Colors.grey.shade50,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Container(
                        //  height: 400,
                        //  width: 400,
                         child: news1[index].urlToImage==null?Image.asset("asset/images/buisness.jpg",fit: BoxFit.fill,):Image.network(news1[index].urlToImage,)
                        
                       ),
                       Container(
                         
                         child: Column(
                           children: [
                             Text(news1[index].title,
                             style:GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              ),
                             ),
                             Text(news1[index].description,
                             style:GoogleFonts.poppins(
                              fontSize: 14,
                              //fontWeight: FontWeight.w00,
                              color: Colors.black,
                              ),
                             ),
                             
                             SizedBox(height:6.0),
                         TextButton.icon(
                           onPressed:(){
                             setState(() {
                              news1.removeAt(index);
                             });
                           },
                           label: Text("delete article",
                           style: TextStyle(
                             fontSize: 10,
                             color: Colors.grey.shade500,
                           ),
                           ),
                           icon: Icon(Icons.delete,
                           size: 15,
                           color: Colors.redAccent.shade700,),
                           
                           ),
                           ],
                         ),

                       ),

                     ],
                   ),
                 ),
               ),
             ),),);
        }); 
  }
}