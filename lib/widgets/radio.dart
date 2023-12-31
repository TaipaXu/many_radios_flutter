import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_responsive/x_responsive.dart';
import '/generated/l10n.dart';
import '/widgets/favicon.dart' as widget;
import '/models/radio.dart' as model;
import '/stores/radio.dart' as store;
import '/storages/radio.dart';
import '/events/favorite.dart' as event;

class Radio extends StatelessWidget {
  final model.Radio radio;

  const Radio({Key? key, required this.radio}) : super(key: key);

  void _onTap() {
    HapticFeedback.mediumImpact();
    store.radio.play(radio);
  }

  void _onLongPress(BuildContext context) async {
    HapticFeedback.mediumImpact();
    final bool isFavoriteRadio = await radioStorage.contains(radio);
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          HapticFeedback.mediumImpact();
          return AlertDialog(
            title: Text(S.of(context).tips),
            content: Text(isFavoriteRadio
                ? S.of(context).removeFavorite
                : S.of(context).addFavorite),
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
                  isFavoriteRadio
                      ? await radioStorage.remove(radio)
                      : await radioStorage.add(radio);
                  store.radio.update();
                  event.favorite.fireEvent('update');
                },
                child: Text(S.of(context).confirm),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width =
        Condition.screenUp(Breakpoint.md).check(context) ? 230 : 120;
    final double height =
        Condition.screenUp(Breakpoint.md).check(context) ? 170 : 155;
    final double fontSize =
        Condition.screenUp(Breakpoint.md).check(context) ? 13 : 9;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: (constraints.maxWidth - 1) /
              (constraints.maxWidth / width).round(),
          height: height,
          child: Card(
            margin: const EdgeInsets.all(6),
            clipBehavior: Clip.antiAlias,
            color: const Color.fromRGBO(255, 217, 65, 1),
            child: InkWell(
              highlightColor: const Color.fromRGBO(255, 211, 33, 1),
              splashColor: const Color.fromRGBO(255, 211, 33, 0.3),
              onTap: _onTap,
              onLongPress: () => _onLongPress(context),
              child: Padding(
                padding: const EdgeInsets.all(15.0).copyWith(bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.Favicon(
                      favicon: radio.favicon,
                      size: 80,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      radio.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
