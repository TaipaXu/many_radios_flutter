import 'package:flutter/material.dart';
import '/storages/theme.dart';
import '/storages/server.dart';
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
    _getCurrentServer();
  }

  Future<void> _getTheme() async {
    _theme = await themeStorage.get();
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
        themeStorage.set(value);
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
              themeStorage.set(_theme);
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
        if (item['ip'].contains('.')) {
          servers.add(model.Server.fromJson(item));
        }
      });
    } catch (e) {}
    setState(() {
      _servers.addAll(servers);
    });
  }

  Future<void> _getCurrentServer() async {
    final model.Server? server = await serverStorage.get();
    setState(() {
      _currentServer = server;
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
              serverStorage.set(server);
            });
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'about');
            },
            child: Text(
              S.of(context).about,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ],
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
