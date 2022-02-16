import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TollApp());//Runs the application
}

class TollApp extends StatelessWidget {
  const TollApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Tolls',
      theme: ThemeData(backgroundColor: Colors.green
          // primarySwatch: Colors.blue,
          ),
      home: const LogIn(),//Navigates to the login screen
    );
  }
}
