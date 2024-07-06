import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class splash_screen extends StatefulWidget {
  final Widget? child;
  const splash_screen({super.key, this.child});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  // void initState() {
  //   Future.delayed(
  //     const Duration(seconds: 5),(){
  //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
  //   }
  //   );
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.pinkAccent,
        child:Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        width: 200,
                        height: 200,
                        "assets/splash/burger_1.png",
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.bottomCenter,
                      ),
                      Image.asset(
                        width: 150,
                        height: 200,
                        "assets/splash/burger_2.png",
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Center(
              child: Text("Foodgo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 60,fontFamily: GoogleFonts.lobster().fontFamily),),
            )
          ],
        )
      ),
    );
  }
}
