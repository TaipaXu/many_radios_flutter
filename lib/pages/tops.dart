import 'package:flutter/material.dart';
import '/widgets/someTopRadios.dart' as widget;
import '/models/topRadios.dart' as model;

class Tops extends StatefulWidget {
  const Tops({Key? key}) : super(key: key);

  @override
  State<Tops> createState() => _TopsState();
}

class _TopsState extends State<Tops> {
  final GlobalKey<widget.SomeTopRadiosState> _statoinsByClicksKey =
      GlobalKey<widget.SomeTopRadiosState>();
  final GlobalKey<widget.SomeTopRadiosState> _statoinsByVotesKey =
      GlobalKey<widget.SomeTopRadiosState>();
  final GlobalKey<widget.SomeTopRadiosState> _statoinsByRecentClickKey =
      GlobalKey<widget.SomeTopRadiosState>();
  final GlobalKey<widget.SomeTopRadiosState> _statoinsByRecentlyChangeKey =
      GlobalKey<widget.SomeTopRadiosState>();

  Future<void> _refreash() async {
    await Future.wait([
      _statoinsByClicksKey.currentState!.refreash(),
      _statoinsByVotesKey.currentState!.refreash(),
      _statoinsByRecentClickKey.currentState!.refreash(),
      _statoinsByRecentlyChangeKey.currentState!.refreash(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreash,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          cacheExtent: 1000,
          children: [
            widget.SomeTopRadios(
              key: _statoinsByClicksKey,
              topRadiosType: model.TopRadiosType.byClicks,
            ),
            const SizedBox(height: 20),
            widget.SomeTopRadios(
              key: _statoinsByVotesKey,
              topRadiosType: model.TopRadiosType.byVotes,
            ),
            const SizedBox(height: 20),
            widget.SomeTopRadios(
              key: _statoinsByRecentClickKey,
              topRadiosType: model.TopRadiosType.byRecentClick,
            ),
            const SizedBox(height: 20),
            widget.SomeTopRadios(
              key: _statoinsByRecentlyChangeKey,
              topRadiosType: model.TopRadiosType.byRecentlyChange,
            ),
          ],
        ),
      ),
    );
  }
}
