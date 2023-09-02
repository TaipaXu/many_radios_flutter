import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '/generated/l10n.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();

    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Many Radios',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/radio.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 10),
          Text(
            'Version: ${packageInfo?.version ?? ''}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              launchUrl(
                  Uri.parse('https://github.com/TaipaXu/many_radios_flutter'));
            },
            child: const Text('Homepage(Github)'),
          ),
        ],
      ),
    );
  }
}
