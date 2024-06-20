import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/views/TicTacToe.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Tictactoe(),));
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 210, 218, 224),
        child: Center(child: Image.asset( 'assets/app_icon.png')),
      ),
    );
  }
}