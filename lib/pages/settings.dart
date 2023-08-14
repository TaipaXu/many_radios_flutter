import 'package:flutter/material.dart';
import '/storage/theme.dart' as storage;
import '/stores/theme.dart' as store;
import '/generated/l10n.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _theme = ThemeMode.system;

  @override
  void initState() {
    super.initState();

    _getTheme();
  }

  Future<void> _getTheme() async {
    _theme = await storage.ThemeStorage.getTheme();
    setState(() {});
  }

  Widget _themeItem({required String title, required ThemeMode value}) {
    return ListTile(
      title: Text(title),
      trailing: Radio(
        value: value,
        groupValue: _theme,
        onChanged: (ThemeMode? value) {},
      ),
      onTap: () {
        setState(() {
          _theme = value;
        });
        store.theme.themeMode = value;
        storage.ThemeStorage.setTheme(value);
      },
    );
  }

  List<Widget> get _darkModeGroup => [
        ListTile(
          title: Text(S.of(context).darkMode),
          subtitle: Text(S.of(context).followSystem),
          trailing: Switch(
            value: _theme == ThemeMode.system,
            onChanged: (bool value) {
              setState(() {
                if (value) {
                  _theme = ThemeMode.system;
                } else {
                  _theme = ThemeMode.light;
                }
              });
              store.theme.themeMode = _theme;
              storage.ThemeStorage.setTheme(_theme);
            },
          ),
        ),
        Offstage(
          offstage: _theme == ThemeMode.system,
          child: Column(
            children: [
              _themeItem(
                title: S.of(context).lightTheme,
                value: ThemeMode.light,
              ),
              _themeItem(
                title: S.of(context).darkTheme,
                value: ThemeMode.dark,
              ),
            ],
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: _darkModeGroup,
      ),
    );
  }
}
