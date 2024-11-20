import 'package:flutter/material.dart';
import 'package:mp3_player/provider/song_provider.dart';
import 'package:provider/provider.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a071e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0a071e),
        title: const Text('Song Page', style: TextStyle(color: Colors.white)),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<SongProvider>(
        builder: (context, provider, child) => SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(provider.result!.image[2].url),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  provider.result!.name,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, top: 2),
                child: Text(
                  provider.result!.artists.primary[0].name,
                  style: const TextStyle(fontSize: 20, color: Colors.white70),
                ),
              ),
              StreamBuilder(
                stream: provider.getCurrentPosition(),
                builder: (context, snapshot) => Slider(
                  max: provider.duration!.inSeconds.toDouble() ?? 0,
                  value: snapshot.data!.inSeconds.toDouble(),
                  onChanged: (value) {
                    provider.jumpSong(Duration(seconds: value.toInt()));
                  },
                ),
              ),
              StreamBuilder<Duration>(
                stream: provider.getCurrentPosition(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final currentPosition = snapshot.data ?? Duration.zero;
                  final duration = provider.duration ?? Duration.zero;
                  String formatDuration(Duration d) {
                    String twoDigits(int n) => n.toString().padLeft(2, '0');
                    String twoDigitMinutes =
                        twoDigits(d.inMinutes.remainder(60));
                    String twoDigitSeconds =
                        twoDigits(d.inSeconds.remainder(60));
                    return "$twoDigitMinutes:$twoDigitSeconds";
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(currentPosition),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          formatDuration(duration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await provider.previousSong();
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await provider.playSong();
                      },
                      icon: Icon(
                        provider.player.playing
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await provider.nextSong();
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
