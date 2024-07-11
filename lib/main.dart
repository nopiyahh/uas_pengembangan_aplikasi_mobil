import 'package:flutter/material.dart';
import 'package:uas_novia/screens/auth_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:AuthScreen(),
    );
  }
}