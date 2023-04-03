import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth/pages/authedPage.dart';
import 'package:firebaseauth/pages/signInPage.dart';
import 'package:firebaseauth/pages/signUpPage.dart';
import 'package:firebaseauth/pages/imagesPage.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        //FinanceData.routeName: (context) => const FinanceData(),
        "/SignIn": (context) => SignInPage(),
        "/SignUp":  (context) => SignUpPage(),
        "/AuthedPage":(context) => ProfilePage(),
        "/ImagesPage":(context)=>ImagesPage(title: "Firebase Storage",)
        //SignIn.routeName: (context) => const SignIn()
      },
      home:  SignInPage(),
    );
  }
}