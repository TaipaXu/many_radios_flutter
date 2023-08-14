import 'package:flutter/material.dart';
import '/generated/l10n.dart';
import '/widgets/radios.dart' as widget;
import '/models/radio.dart' as model;
import '/apis/search.dart' as api;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ScrollController _scrollController = ScrollController();
  List<String> _countries = [];
  List<String> _languages = [];
  String? _name;
  String? _currentCountry;
  String? _currentLanguage;
  bool _isLoading = false;
  int _offset = 0;
  final int _limit = 20;
  List<model.Radio> _radios = [];

  @override
  void initState() {
    super.initState();

    _getCountries();
    _getLanguages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _searchRadios();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _getCountries() async {
    try {
      List<String> countries = [''];
      dynamic data = await api.getCountries();
      for (var country in data) {
        countries.add(country['name']);
      }
      setState(() {
        _countries = countries;
      });
    } catch (e) {}
  }

  Future<void> _getLanguages() async {
    try {
      List<String> languages = [''];
      dynamic data = await api.getLanguages();
      for (var language in data) {
        languages.add(language['name']);
      }
      setState(() {
        _languages = languages;
      });
    } catch (e) {}
  }

  Future<void> _searchRadios() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;

    try {
      List<model.Radio> radios = [];
      dynamic data = await api.searchRadios(
        name: _name,
        country: _currentCountry,
        language: _currentLanguage,
        offset: _offset,
        limit: _limit,
      );
      data.forEach((item) {
        radios.add(model.Radio(
          name: item['name'],
          url: item['url'],
          favicon: item['favicon'],
        ));
      });
      if (_offset == 0) {
        _radios = radios;
      } else {
        _radios.addAll(radios);
      }
      _offset += _limit;
      setState(() {});
    } catch (e) {}

    _isLoading = false;
  }

  Future<void> _refresh() async {
    _offset = 0;
    await _searchRadios();
  }

  Widget _nameInput(BuildContext context) => TextField(
        decoration: InputDecoration(
          labelText: S.of(context).searchName,
          hintText: S.of(context).searchNameHint,
        ),
        onChanged: (value) {
          setState(() {
            _name = value;
          });
        },
      );

  Widget _countrySelector(BuildContext context) =>
      DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          labelText: S.of(context).country,
        ),
        value: _countries.isNotEmpty ? _countries[0] : null,
        items: _countries
            .map((String country) => DropdownMenuItem(
                  value: country,
                  child: Text(country),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _currentCountry = value;
          });
        },
      );

  Widget _languageSelector(BuildContext context) =>
      DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          labelText: S.of(context).language,
        ),
        value: _languages.isNotEmpty ? _languages[0] : null,
        items: _languages
            .map((String language) => DropdownMenuItem(
                  value: language,
                  child: Text(language),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _currentLanguage = value;
          });
        },
      );

  Widget _searchButton(BuildContext context) => ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: _refresh,
        child: Text(S.of(context).search),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(10),
        children: [
          _nameInput(context),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _countrySelector(context),
              ),
              Expanded(
                child: _languageSelector(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _searchButton(context),
            ],
          ),
          const SizedBox(height: 10),
          widget.Radios(radios: _radios),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
