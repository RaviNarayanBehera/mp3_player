import 'package:flutter/material.dart';
import 'package:mp3_player/modal/song_modal.dart';
import 'package:mp3_player/provider/song_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a071e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0a071e),
        title: const Text(
          'My Songs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Provider.of<SongProvider>(context).songModal == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<SongProvider>(
              builder: (context, provider, child) => ListView.builder(
                itemCount: provider.songModal!.data.results.length,
                itemBuilder: (context, index) {
                  Result result = provider.songModal!.data.results[index];
                  return ListTile(
                    leading: Image.network(
                      result.image[2].url,
                    ),
                    title: Text(
                      result.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      result.artists.primary[0].name,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        provider.selectSong(result, index);
                        provider.getSong(result.downloadUrl[0].url);
                        Navigator.of(context).pushNamed('/song');
                      },
                      icon: const Icon(Icons.play_arrow_outlined),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
