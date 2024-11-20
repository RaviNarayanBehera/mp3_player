import 'package:flutter/material.dart';
import 'package:mp3_player/provider/song_provider.dart';
import 'package:mp3_player/views/home_page.dart';
import 'package:mp3_player/views/songs_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SongProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
          '/song': (context) => SongsPage(),
        },
      ),
    );
  }
}
