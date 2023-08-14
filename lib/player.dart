import 'package:audioplayers/audioplayers.dart';

class Player {
  static Player? _instance;
  static Player get instance {
    _instance ??= Player();
    return _instance!;
  }

  AudioPlayer? _player;

  Future<void> play(String url) async {
    _player ??= AudioPlayer();
    await _player?.play(UrlSource(url));
  }

  Future<void> pause() async {
    await _player?.pause();
  }

  Future<void> resume() async {
    await _player?.resume();
  }

  Future<void> stop() async {
    await _player?.stop();
    _player = null;
  }
}
