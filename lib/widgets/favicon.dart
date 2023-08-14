import 'package:flutter/material.dart';

class Favicon extends StatelessWidget {
  final String favicon;
  final double size;
  const Favicon({Key? key, required this.favicon, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      favicon,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              Image.asset(
        'assets/images/radio.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
