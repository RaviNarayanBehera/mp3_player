import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mp3_player/modal/song_modal.dart';
import 'api_service.dart';

class SongProvider extends ChangeNotifier {
  SongModal? songModal;
  Result? result;
  AudioPlayer player = AudioPlayer();
  Duration? duration;

  int currentIndex = -1;

  // List to hold recently played songs
  List<Result> recentlyPlayedSongs = [];

  Future<void> getSongs() async {
    // Fetch song list from API
    ApiService apiService = ApiService();
    Map<String, dynamic> json = await apiService.fetchSongs();
    songModal = SongModal.fromJson(json);
    notifyListeners();
  }

  // Select a song and update current index
  void selectSong(Result selectedSong, int index) {
    result = selectedSong;
    currentIndex = index;

    // Add song to recently played list
    _addRecentlyPlayedSong(selectedSong);
    notifyListeners();
  }

  // Load song URL based on current song
  Future<void> getSong(String url) async {
    duration = await player.setUrl(url);
    await player.play();
    notifyListeners();
  }

  // Play or pause song
  Future<void> playSong() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
    notifyListeners();
  }

  // Seek to next song in the list
  Future<void> nextSong() async {
    if (songModal != null && currentIndex < songModal!.data.results.length - 1) {
      currentIndex++;
      selectSong(songModal!.data.results[currentIndex], currentIndex);
      await getSong(songModal!.data.results[currentIndex].downloadUrl[0].url);
    }
    notifyListeners();
  }

  // Seek to previous song in the list
  Future<void> previousSong() async {
    if (songModal != null && currentIndex > 0) {
      currentIndex--;
      selectSong(songModal!.data.results[currentIndex], currentIndex);
      await getSong(songModal!.data.results[currentIndex].downloadUrl[0].url);
    }
    notifyListeners();
  }

  Stream<Duration> getCurrentPosition() {
    return player.positionStream;
  }

  Future<void> jumpSong(Duration position) async {
    await player.seek(position);
    notifyListeners();
  }

  // Method to add a song to the recently played list
  void _addRecentlyPlayedSong(Result song) {
    // Add song to the beginning of the list
    recentlyPlayedSongs.insert(0, song);

    // Limit the list size to the most recent 5 songs
    if (recentlyPlayedSongs.length > 5) {
      recentlyPlayedSongs.removeLast();
    }
  }

  SongProvider() {
    getSongs();
  }
}
