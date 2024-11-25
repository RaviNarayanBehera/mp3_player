import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mp3_player/views/home_page.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade800,
              const Color(0xFF0a071e),
              const Color(0xFF1c0b36),
              Colors.purple.shade800,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/logo.png'))
                ),
              ),
              // const SizedBox(height: 5),
              const Text('BeatFlow',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              const Text('Feel the beat, live the moment.',style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}
