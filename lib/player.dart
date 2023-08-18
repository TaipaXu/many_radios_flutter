import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '/models/radio.dart' as model;

class Player {
  static Player? _instance;
  static Player get instance {
    _instance ??= Player();
    return _instance!;
  }

  final List<void Function(bool)> _stopCallbacks = [];

  AudioPlayer? _player;

  void addStatusChangedCallback(void Function(bool) callback) {
    _stopCallbacks.add(callback);
  }

  void removeStatusChangedCallback(void Function(bool) callback) {
    _stopCallbacks.remove(callback);
  }

  Future<void> play(model.Radio radio) async {
    if (_player == null) {
      _player ??= AudioPlayer();
      _player?.playerStateStream.listen((event) {
        for (var callback in _stopCallbacks) {
          callback(event.playing);
        }
      }, onError: (Object e, StackTrace stackTrace) {
        for (var callback in _stopCallbacks) {
          callback(false);
        }
      });
    }

    _player?.stop();

    final playlist = ConcatenatingAudioSource(
      children: [
        ClippingAudioSource(
          child: AudioSource.uri(Uri.parse(radio.url)),
          tag: MediaItem(
            id: radio.url,
            title: radio.name,
          ),
        ),
      ],
    );
    _player?.setAudioSource(playlist);
    _player?.play();
  }

  Future<void> pause() async {
    await _player?.pause();
  }

  Future<void> resume() async {
    await _player?.play();
  }

  Future<void> stop() async {
    await _player?.stop();
    _player = null;
  }
}
