import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:food_go/authentication/login_page.dart';
import 'package:food_go/common/form_container_widget.dart';
import 'package:food_go/common/toast.dart';
import 'package:food_go/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sign_up_page extends StatefulWidget {
  const sign_up_page({super.key});

  @override
  State<sign_up_page> createState() => _sign_up_pageState();
}

class _sign_up_pageState extends State<sign_up_page> {
  final firebase_auth_services _auth = firebase_auth_services();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.pinkAccent.shade100, Colors.pink],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Stack(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 48,
                              fontFamily: GoogleFonts.lobster().fontFamily),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        form_container_widget(
                          controller: _usernameController,
                          hintText: "Username",
                          isPasswordField: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        form_container_widget(
                          controller: _emailController,
                          hintText: "Email",
                          isPasswordField: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        form_container_widget(
                          controller: _passwordController,
                          hintText: "Password",
                          isPasswordField: true,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            _signUp();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                                child: isSigningUp
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => login_page()),
                                      (Route<dynamic> route) => false);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // Text("SignUp",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28,fontFamily: GoogleFonts.lobster().fontFamily),),
                )
              ],
            )),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      show_toast(message: "User is successfully created");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => home_page()),
          (Route<dynamic> route) => false);
    } else {
      show_toast(message: "Some error happend");
    }
  }
}
