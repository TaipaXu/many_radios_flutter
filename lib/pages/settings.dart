import 'package:flutter/material.dart';
import '/storage/theme.dart' as storage;
import '/stores/theme.dart' as store;
import '/generated/l10n.dart';
import '/models/server.dart' as model;
import '/apis/base.dart' as api;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _theme = ThemeMode.system;
  final List<model.Server> _servers = [];
  model.Server? _currentServer;

  @override
  void initState() {
    super.initState();

    _getTheme();
    _getServers();
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

  Future<void> _getServers() async {
    final List<model.Server> servers = [];
    try {
      dynamic data = await api.getServers();
      data.forEach((item) {
        servers.add(model.Server(
          name: item['name'],
          ip: item['ip'],
        ));
      });
    } catch (e) {}
    setState(() {
      _servers.addAll(servers);
    });
  }

  Widget _serverSelector() => ListTile(
        title: Text(S.of(context).server),
        subtitle: Text(_currentServer?.name ?? ''),
        onTap: () async {
          final model.Server? server = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(S.of(context).server),
                children: [
                  for (var server in _servers)
                    SimpleDialogOption(
                      child: Text(server.name),
                      onPressed: () => Navigator.pop(context, server),
                    ),
                ],
              );
            },
          );
          if (server != null) {
            setState(() {
              _currentServer = server;
            });
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: [
          ..._darkModeGroup,
          const Divider(),
          _serverSelector(),
        ],
      ),
    );
  }
}
