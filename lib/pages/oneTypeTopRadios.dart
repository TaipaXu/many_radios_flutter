import 'package:flutter/material.dart';
import '/widgets/radios.dart' as widget;
import '/widgets/blur.dart' as widget;
import '/widgets/playControl.dart' as widget;
import '/models/radio.dart' as model;
import '/models/topRadios.dart' as model;
import '/stores/radio.dart' as store;
import '/apis/radio.dart' as api;

class OneTypeTopRadios extends StatefulWidget {
  final model.TopRadiosType topRadiosType;

  const OneTypeTopRadios({Key? key, required this.topRadiosType})
      : super(key: key);

  @override
  State<OneTypeTopRadios> createState() => _OneTypeTopRadiosState();
}

class _OneTypeTopRadiosState extends State<OneTypeTopRadios>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;
  bool _isLoading = false;
  int _offset = 0;
  final int _limit = 20;
  List<model.Radio> _radios = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState?.show());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getRadios();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    store.radio.addListener(_checkRadioStore);
    _checkRadioStore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    store.radio.removeListener(_checkRadioStore);

    super.dispose();
  }

  void _checkRadioStore() {
    if (store.radio.showPlayControl) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Future<void> _getRadios() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;

    List<model.Radio> radios = [];
    try {
      dynamic data = await api.getRadiosByType(
        type: this.widget.topRadiosType,
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
    await _getRadios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.topRadiosType.name(context)),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                widget.Radios(radios: _radios),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    50 * (1 - _animationController.value).toDouble(),
                  ),
                  child: const widget.Blur(
                    child: widget.PlayControl(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
