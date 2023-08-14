import 'package:flutter/material.dart';
import '/models/radio.dart' as model;
import '/player.dart';

class Radio with ChangeNotifier {
  final Player _player = Player.instance;
  model.Radio? _radio;
  bool _isPlaying = false;
  bool _showPlayControl = false;

  model.Radio? get radio => _radio;

  bool get isPlaying => _isPlaying;

  bool get showPlayControl => _showPlayControl;

  void play(model.Radio radio) {
    _radio = radio;
    _isPlaying = true;
    _showPlayControl = true;
    _player.play(radio.url);

    notifyListeners();
  }

  void pause() {
    _player.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() {
    _player.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void stop() {
    _player.stop();
    _isPlaying = false;
    _showPlayControl = false;
    notifyListeners();
  }
}

final radio = Radio();
