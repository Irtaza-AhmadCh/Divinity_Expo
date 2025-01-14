import 'package:divinity/firebase_options.dart';
import 'package:divinity/resourses/colors.dart';
import 'package:divinity/screens/AdminSide/AdminMain.dart';
import 'package:divinity/screens/HomeScreen.dart';
import 'package:divinity/screens/NavigationBar/NavigationBar.dart';
import 'package:divinity/screens/SignUp.dart';
import 'package:divinity/screens/forgetPassword.dart';
import 'package:divinity/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
      scaffoldBackgroundColor: MyColors.white,
       splashColor: Colors.transparent
      ),
      home: Splashscreen(),
    );
  }
}
