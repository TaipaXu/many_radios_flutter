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

  @override
  Radio() {
    _player.addStatusChangedCallback((bool playing) {
      _isPlaying = playing;
      notifyListeners();
    });
  }

  void play(model.Radio radio) {
    _radio = radio;
    _showPlayControl = true;
    _player.play(radio);

    notifyListeners();
  }

  void pause() {
    _player.pause();
    notifyListeners();
  }

  void resume() {
    _player.resume();
    notifyListeners();
  }

  void stop() {
    _player.stop();
    _showPlayControl = false;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}

final radio = Radio();
