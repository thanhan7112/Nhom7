import 'package:flutter/material.dart';
import 'ui/screens/screens.dart';
import 'package:fluttermovie/ui/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Raleway',
          errorColor: Colors.white),
      home: LoginScreen(),
      // routes: {
      //   VideoApp.route: (ctx) => VideoApp(),
      // },
    );
  }
}
