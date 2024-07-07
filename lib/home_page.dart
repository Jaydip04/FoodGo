import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_go/authentication/login_page.dart';
import 'package:food_go/common/toast.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),),
                    ),
                  ),
                ),
                onPressed: () {
                  {
                    showCupertinoDialog(
                      context: context,
                      // barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text(
                          "Sign Out?",
                          style: commonTextStyletitle(),
                        ),
                        content: Text(
                          "Are You Sure?",
                          style: commonTextStyle16(),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: commonElevatedButton(),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: commonTextStyle18(),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                style: commonElevatedButton(),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => login_page()),
                                          (Route<dynamic> route) => false);
                                  show_toast(message: "Successfully signed out");
                                },
                                child: Text("Sign Out", style: commonTextStyle18()),
                              ),
                            ],
                          )
                        ],
                        elevation: 24.0,
                        backgroundColor: Colors.pinkAccent,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 27,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 27,
                      ),
                      Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),),),
      ),
    );
  }

  // Widget signOut() {
  //   return
  // }
  TextStyle commonTextStyletitle() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white);
  }

  TextStyle commonTextStyle18() {
    return TextStyle(
        color: Colors.pinkAccent, fontSize: 18, fontWeight: FontWeight.w500);
  }

  TextStyle commonTextStyle16() {
    return TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  ButtonStyle commonElevatedButton() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width / 4, 40));
  }
}
