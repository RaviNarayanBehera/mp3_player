import 'package:flutter/material.dart';
import 'package:mp3_player/modal/song_modal.dart';
import 'package:mp3_player/provider/song_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0a071e),
        title: const Text(
          'My Songs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
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
        child: Provider.of<SongProvider>(context).songModal == null
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white70,),
              )
            : Consumer<SongProvider>(
                builder: (context, provider, child) {
                  List<Result> recentlyPlayed = provider.recentlyPlayedSongs;
                  return ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: const Text(
                              'Recently Played',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/seeAll');
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 190,
                          child: recentlyPlayed.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No recently played songs',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recentlyPlayed.length,
                                  itemBuilder: (context, index) {
                                    Result song = recentlyPlayed[index];
                                    return GestureDetector(
                                      onTap: () {
                                        provider.selectSong(song, index);
                                        provider
                                            .getSong(song.downloadUrl[2].url);
                                        Navigator.of(context)
                                            .pushNamed('/song');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  song.image[2].url,
                                                  fit: BoxFit.cover,
                                                  height: 120,
                                                  width: 150,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                song.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                song.artists.primary[0].name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                          'All Songs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // All Songs List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.songModal!.data.results.length,
                        itemBuilder: (context, index) {
                          Result result =
                              provider.songModal!.data.results[index];
                          return GestureDetector(
                            onTap: () {
                              provider.selectSong(result, index);
                              provider.getSong(result.downloadUrl[2].url);
                              Navigator.of(context).pushNamed('/song');
                            },
                            child: Container(
                              height: 105,
                              child: Card(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Image.network(
                                      result.image[2].url,
                                      height: 100,
                                    ),
                                    title: Text(
                                      result.name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      result.artists.primary[0].name,
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                    trailing: const Icon(
                                      Icons.play_arrow_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
