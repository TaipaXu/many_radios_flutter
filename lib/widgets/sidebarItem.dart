import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final Function? onTap;

  const SidebarItem(
      {Key? key,
      required this.label,
      required this.icon,
      this.active = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = active ? Theme.of(context).primaryColor : Colors.black;

    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 40,
            ),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
