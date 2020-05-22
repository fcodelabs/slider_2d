import 'dart:math';

import 'package:flutter/material.dart';

import 'grid.dart';
import 'grid_theme.dart';

class Slider2D extends StatelessWidget {
  final GridTheme gridTheme;
  final double length;
  final ValueNotifier<Offset> _position;
  final Offset _center;

  Slider2D({
    Key key,
    @required this.gridTheme,
    this.length,
  })  : _position = ValueNotifier<Offset>(Offset(length / 2, length / 2)),
        _center = Offset(length / 2, length / 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final length = this.length ?? min(size.height, size.width);

    return Center(
      child: SizedBox(
        width: length,
        height: length,
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: Container()),
            Positioned.fill(
              child: Center(
                child: SizedBox(
                  height: length - 12,
                  width: length - 12,
                  child: CustomPaint(
                    painter: Grid(theme: gridTheme),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: _position,
                child: Container(
                  height: 24,
                  width: 24,
                  color: Colors.red,
                ),
                builder: (context, value, child) {
                  return Positioned(
                    left: value.dx - 12,
                    top: value.dy - 12,
                    child: child,
                  );
                }),
            GestureDetector(
              onPanStart: (details) => _update(details.localPosition),
              onPanUpdate: (details) => _update(details.localPosition),
            ),
          ],
        ),
      ),
    );
  }

  void _update(Offset value) {
    if ((_center - value).distance.abs() > length / 2) {
      return;
    }
    final distance = (_position.value - value).distance.abs();
    if (distance > 8) {
      _position.value = value;
    }
  }
}
