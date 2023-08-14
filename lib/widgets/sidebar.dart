import 'package:flutter/material.dart';
import '/generated/l10n.dart';
import '/widgets/sidebarItem.dart' as widget;

class Sidebar extends StatefulWidget {
  final int? activeIndex;
  final Function(int index)? onActive;
  const Sidebar({Key? key, this.activeIndex, this.onActive}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  Widget _sidebarItem(
      {required String label, required IconData icon, required int index}) {
    return widget.SidebarItem(
      label: label,
      icon: icon,
      active: this.widget.activeIndex == index,
      onTap: () => this.widget.onActive?.call(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          _sidebarItem(
            label: S.of(context).tops,
            icon: Icons.radar_outlined,
            index: 0,
          ),
          const SizedBox(height: 10),
          _sidebarItem(
            label: S.of(context).search,
            icon: Icons.search,
            index: 1,
          ),
          const SizedBox(height: 10),
          _sidebarItem(
            label: S.of(context).favorites,
            icon: Icons.favorite_outline,
            index: 2,
          ),
        ],
      ),
    );
  }
}
