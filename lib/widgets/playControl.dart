import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/widgets/favicon.dart' as widget;
import '/storages/radio.dart';
import '/stores/radio.dart' as store;

class PlayControl extends StatefulWidget {
  final Function? onPlay;
  final Function? onStop;
  const PlayControl({Key? key, this.onPlay, this.onStop}) : super(key: key);

  @override
  State<PlayControl> createState() => _PlayControlState();
}

class _PlayControlState extends State<PlayControl> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    store.radio.addListener(_checkRadioStore);
  }

  @override
  void dispose() {
    store.radio.removeListener(_checkRadioStore);

    super.dispose();
  }

  void _checkRadioStore() async {
    if (store.radio.radio != null) {
      _isFavorite = await radioStorage.contains(store.radio.radio!);
    }
  }

  void _pause() {
    HapticFeedback.mediumImpact();

    setState(() {
      store.radio.pause();
    });
  }

  void _resume() {
    HapticFeedback.mediumImpact();

    setState(() {
      store.radio.resume();
    });
  }

  void _play() {
    HapticFeedback.mediumImpact();

    if (store.radio.isPlaying) {
      _pause();
    } else {
      _resume();
    }
  }

  void _stop() {
    HapticFeedback.mediumImpact();

    setState(() {
      store.radio.stop();
    });
  }

  void _favoriteOrNot() {
    HapticFeedback.mediumImpact();

    if (_isFavorite) {
      _isFavorite = false;
      radioStorage.remove(store.radio.radio!);
    } else {
      _isFavorite = true;
      radioStorage.add(store.radio.radio!);
    }
    setState(() {});
  }

  Widget get _favoriteButton => IconButton(
        icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
        iconSize: 20,
        onPressed: _favoriteOrNot,
      );

  Widget get _playButton => IconButton(
        icon: Icon(
            store.radio.isPlaying ? Icons.pause_circle : Icons.play_circle),
        iconSize: 30,
        onPressed: _play,
      );

  Widget get _stopButton => IconButton(
        icon: const Icon(Icons.stop),
        iconSize: 20,
        onPressed: _stop,
      );

  @override
  Widget build(BuildContext context) {
    final store.Radio radioStore = Provider.of<store.Radio>(context);

    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 4),
                widget.Favicon(
                  favicon: radioStore.radio?.favicon ?? '',
                  size: 40,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    radioStore.radio?.name ?? 'Radio',
                    style: const TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: _favoriteButton),
                Expanded(child: _playButton),
                Expanded(child: _stopButton),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
