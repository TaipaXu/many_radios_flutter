import 'package:flutter/material.dart';
import '/models/radio.dart' as model;
import './radio.dart' as widget;

class Radios extends StatelessWidget {
  final List<model.Radio> radios;

  const Radios({Key? key, required this.radios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (var radio in radios)
          widget.Radio(
            radio: radio,
          ),
      ],
    );
  }
}
