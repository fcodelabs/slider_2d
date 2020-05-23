import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slider2d/src/grid_value.dart';

import 'grid.dart';
import 'grid_theme.dart';
import 'pointer.dart';

/// This will generate a [Widget] that will be used as the pointer of this
/// slider given the [BuildContext], whether the pointer is moving or not
/// and pointer's size.
///
/// [Pointer] is used as default pointer.
typedef PointerBuilder = Widget Function(
  BuildContext context,
  double length,
  bool isMoving,
);

/// {@template slider_2d}
/// {@endtemplate}
class Slider2D extends StatelessWidget {
  final GridTheme gridTheme;
  final double length;
  final double pointerLength;
  final PointerBuilder pointerBuilder;
  final ValueChanged<GridValue> onChange;

  final _position = ValueNotifier<Offset>(null);
  final _dragging = ValueNotifier(false);

  /// {@macro slider_2d}
  Slider2D({
    Key key,
    @required this.gridTheme,
    @required this.onChange,
    this.pointerBuilder,
    this.length,
    this.pointerLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final length = this.length ?? min(size.height, size.width);
    final pointerLength = this.pointerLength ?? 24;
    final dl = pointerLength / 2;
    final center = Offset(length / 2, length / 2);
    if (_position.value == null) {
      _changeValue(center, center, length, dl);
    }

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
                  height: length - pointerLength,
                  width: length - pointerLength,
                  child: CustomPaint(
                    painter: Grid(theme: gridTheme),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<Offset>(
              valueListenable: _position,
              child: ValueListenableBuilder(
                valueListenable: _dragging,
                builder: (context, value, child) =>
                    pointerBuilder?.call(context, pointerLength, value) ??
                    Pointer(length: pointerLength, isMoving: value),
              ),
              builder: (context, value, child) {
                if (value == null) {
                  return Container();
                }
                return Positioned(
                  left: value.dx - dl,
                  top: value.dy - dl,
                  child: child,
                );
              },
            ),
            GestureDetector(
              onPanStart: (details) {
                _update(details.localPosition, center, length, dl);
                _dragging.value = true;
              },
              onPanUpdate: (details) =>
                  _update(details.localPosition, center, length, dl),
              onPanEnd: (details) {
                _update(_position.value, center, length, dl);
                _dragging.value = false;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _update(Offset value, Offset center, double length, double dl) {
    final vector = value - center;
    final limit = (length / 2) - dl;
    if (vector.distance > limit) {
      value = Offset(
            limit * cos(vector.direction),
            limit * sin(vector.direction),
          ) +
          center;
    }
    final delta = (_position.value - value).distance;
    if (delta > 0) {
      _changeValue(value, center, length, dl);
    }
  }

  void _changeValue(Offset value, Offset center, double length, double dl) {
    final vector = value - center;
    final limit = (length / 2) - dl;
    onChange?.call(GridValue(
      x: vector.dx / limit,
      y: vector.dy / limit,
      r: vector.distance / limit,
      teta: vector.direction,
    ));
    _position.value = value;
  }
}
