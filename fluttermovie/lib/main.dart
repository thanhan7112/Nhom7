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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: LoginScreen(),
      // initialRoute: '/',
      routes: {
        // '/': (ctx) => HomeScreen(),
        VideoApp.route: (ctx) => VideoApp(),
      },
    );
  }
}
