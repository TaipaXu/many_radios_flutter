import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/generated/l10n.dart';
import '/widgets/favorite.dart' as widget;
import '/models/radio.dart' as model;
import '/stores/radio.dart' as store;
import '/storages/radio.dart';
import '/events/favorite.dart' as event;

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<model.Radio>? _radios;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());

    _subscription = event.favorite.addEventListener((event) {
      if (event.eventName == 'update') {
        _loadFavorites();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();

    super.dispose();
  }

  Future<void> _loadFavorites() async {
    List<model.Radio>? radios = await radioStorage.get();
    setState(() {
      _radios = radios;
    });
  }

  Future<void> _removeFavoriteRadio(model.Radio radio) async {
    HapticFeedback.mediumImpact();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).tips),
          content: Text(S.of(context).removeFavorite),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                _radios?.remove(radio);
                await radioStorage.remove(radio);
                store.radio.update();
                _loadFavorites();
              },
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _loadFavorites,
        child: ListView(children: [
          if (_radios != null)
            for (model.Radio radio in _radios!)
              widget.Favorite(
                child: radio,
                onRemove: () => _removeFavoriteRadio(radio),
              )
        ]),
      ),
    );
  }
}
