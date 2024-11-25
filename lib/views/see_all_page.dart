import 'package:flutter/material.dart';
import 'package:mp3_player/modal/song_modal.dart';
import 'package:mp3_player/provider/song_provider.dart';
import 'package:provider/provider.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0a071e),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Recently Played',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<SongProvider>(
        builder: (context, provider, child) {
          List<Result> recentlyPlayed = provider.recentlyPlayedSongs;
          return Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0a071e),
                  const Color(0xFF1c0b36),
                  Colors.purple.shade800,
                ],
              ),
            ),
            child: recentlyPlayed.isEmpty
                ? const Center(
              child: Text(
                'No recently played songs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
                : ListView.builder(
              itemCount: recentlyPlayed.length,
              itemBuilder: (context, index) {
                Result song = recentlyPlayed[index];
                return ListTile(
                  leading: Image.network(
                    song.image[2].url,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                  title: Text(
                    song.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    song.artists.primary[0].name,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      provider.selectSong(song, index);
                      provider.getSong(song.downloadUrl[2].url);
                      Navigator.of(context).pushNamed('/song');
                    },
                    icon: const Icon(Icons.play_arrow_outlined),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
