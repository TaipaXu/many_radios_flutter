import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static const Duration _duration = Duration(seconds: 1);

  @override
  void initState() {
    super.initState();

    wait();
  }

  Future<void> wait() async {
    await Future.delayed(_duration);

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/radio.png',
          width: 160,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
