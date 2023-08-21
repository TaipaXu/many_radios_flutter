import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/favicon.dart' as widget;
import '/models/radio.dart' as model;
import '/stores/radio.dart' as store;

class Favorite extends StatelessWidget {
  final model.Radio child;
  final Function? onRemove;
  const Favorite({Key? key, required this.child, this.onRemove})
      : super(key: key);

  void _onTap() {
    HapticFeedback.mediumImpact();
    store.radio.play(child);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Row(
          children: [
            widget.Favicon(
              favicon: child.favicon,
              size: 80,
            ),
            const SizedBox(width: 8),
            Text(
              child.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              iconSize: 20,
              onPressed: () => onRemove?.call(),
            ),
          ],
        ),
        onTap: _onTap,
      ),
    );
  }
}
