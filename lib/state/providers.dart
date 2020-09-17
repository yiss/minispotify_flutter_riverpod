import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minispotify/models/audio_track_model.dart';

final playlistProvider = Provider((ref) => [
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'My Old East Coast (feat. Melanie)',
          thumbnail: 'https://www.bensound.com/bensound-img/ukulele.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-ukulele.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Creative Minds',
          thumbnail: 'https://www.bensound.com/bensound-img/creativeminds.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-creativeminds.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Little Idea',
          thumbnail: 'https://www.bensound.com/bensound-img/littleidea.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-littleidea.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Jazzy Frenchy',
          thumbnail: 'https://www.bensound.com/bensound-img/jazzyfrenchy.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-jazzyfrenchy.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Cute',
          thumbnail: 'https://www.bensound.com/bensound-img/littleidea.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-littleidea.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Cute',
          thumbnail: 'https://www.bensound.com/bensound-img/cute.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-cute.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Memories',
          thumbnail: 'https://www.bensound.com/bensound-img/memories.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-memories.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Slow Motion',
          thumbnail: 'https://www.bensound.com/bensound-img/slowmotion.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-slowmotion.mp3'),
      AudioTrackModel(
          artistName: 'Benjamin Tissot',
          trackName: 'Funny Song',
          thumbnail: 'https://www.bensound.com/bensound-img/funnysong.jpg',
          audioUrl:
              'https://www.bensound.com/bensound-music/bensound-funnysong.mp3'),
    ]);

final audioPlayerProvider = Provider.autoDispose<AssetsAudioPlayer>((ref) {
  final playlist = ref.watch(playlistProvider);
  final audioPlayer = AssetsAudioPlayer();
  audioPlayer.open(
      Playlist(
          audios: playlist
              .map((audioTrackModel) => Audio.network(audioTrackModel.audioUrl))
              .toList()),
      autoStart: false);
  return audioPlayer;
});

final currentlyPlayingProvider =
    StreamProvider.autoDispose<AudioTrackModel>((ref) {
  final playlist = ref.watch(playlistProvider);
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.current.map((playing) => playlist[playing.index]);
});

final totalDurationProvider = StreamProvider.autoDispose<double>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.current
      .map((playing) => playing.audio.duration.inSeconds.toDouble());
});

final currentPositionProvider = StreamProvider.autoDispose<double>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.currentPosition
      .map((position) => position.inSeconds.toDouble());
});

final playingStateProvider = StreamProvider.autoDispose<bool>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.isPlaying;
});
