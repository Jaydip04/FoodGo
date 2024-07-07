import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_go/authentication/login_page.dart';
import 'package:food_go/authentication/sign_up_page.dart';
import 'package:food_go/home_page.dart';
import 'package:food_go/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDOcisThBw-Vs3P-RhJrxWEDq8LJKI7AAQ",
        appId: "1:301258823049:android:93d649d7083cfd37a63d58",
        messagingSenderId: "301258823049",
        projectId: "foodgo-a3df1",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
    if (isLoggedIn) { // if user is logged in, open dashboard
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const splash_screen(

            child: home_page(),
          ),
          '/login': (context) => const login_page(),
          '/signUp': (context) => const sign_up_page(),
          '/home': (context) => const home_page(),

        }, //dashboard
      );
    } else {// if user isn't logged in, open login page
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const splash_screen(

            child: login_page(),
          ),
          '/login': (context) => const login_page(),
          '/signUp': (context) => const sign_up_page(),
          '/home': (context) => const home_page(),

        }, //login page
      );
    }
    // return
    //   MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: splash_screen(),
    // );
    // MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   routes: {
    //     '/': (context) => const splash_screen(
    //
    //       child: home_page(),
    //     ),
    //     '/login': (context) => const login_page(),
    //     '/signUp': (context) => const sign_up_page(),
    //     '/home': (context) => const home_page(),
    //
    //   }, //dashboard
    // );
  }
}
