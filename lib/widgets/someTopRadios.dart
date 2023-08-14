import 'package:flutter/material.dart';
import 'package:x_responsive/x_responsive.dart';
import '/pages/oneTypeTopRadios.dart' as page;
import './radios.dart' as widget;
import '/models/radio.dart' as model;
import '/models/topRadios.dart' as model;
import '/apis/radio.dart' as api;

class SomeTopRadios extends StatefulWidget {
  final model.TopRadiosType topRadiosType;
  final int offset;
  final int limit;

  const SomeTopRadios(
      {Key? key, required this.topRadiosType, this.offset = 0, this.limit = 50})
      : super(key: key);

  @override
  State<SomeTopRadios> createState() => SomeTopRadiosState();
}

class SomeTopRadiosState extends State<SomeTopRadios> {
  List<model.Radio> _radios = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _getRadios();
  }

  Future<void> refreash() async {
    if (!_isLoading) {
      await _getRadios();
    }
  }

  Future<void> _getRadios() async {
    _isLoading = true;
    try {
      final List<model.Radio> radios = [];
      dynamic data = await api.getRadiosByType(
        type: this.widget.topRadiosType,
        offset: this.widget.offset,
        limit: this.widget.limit,
      );
      data.forEach((item) {
        radios.add(model.Radio(
          name: item['name'],
          url: item['url'],
          favicon: item['favicon'],
        ));
      });
      setState(() {
        _radios = radios;
      });
    } catch (e) {}
    _isLoading = false;
  }

  void _gotoRadiosPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page.OneTypeTopRadios(
            topRadiosType: this.widget.topRadiosType,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      final double width =
          Condition.screenUp(Breakpoint.md).check(context) ? 230 : 120;
      const int lineCount = 3;
      final int count = (screenWidth / width).round() * lineCount;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.widget.topRadiosType.name(context),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: _gotoRadiosPage,
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          widget.Radios(
            radios: _radios.take(count).toList(),
          ),
        ],
      );
    });
  }
}
