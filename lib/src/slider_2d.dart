import 'dart:math';

import 'package:flutter/material.dart';

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
  final ValueNotifier<Offset> _position;
  final _dragging = ValueNotifier(false);
  final Offset _center;

  /// {@macro slider_2d}
  Slider2D({
    Key key,
    @required this.gridTheme,
    this.pointerBuilder,
    this.length,
    this.pointerLength,
  })  : _position = ValueNotifier<Offset>(Offset(length / 2, length / 2)),
        _center = Offset(length / 2, length / 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final length = this.length ?? min(size.height, size.width);
    final pointerLength = this.pointerLength ?? 24;
    final dl = pointerLength / 2;

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
                  height: length - dl,
                  width: length - dl,
                  child: CustomPaint(
                    painter: Grid(theme: gridTheme),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _position,
              child: ValueListenableBuilder(
                valueListenable: _dragging,
                builder: (context, value, child) =>
                    pointerBuilder?.call(context, pointerLength, value) ??
                    Pointer(length: pointerLength, isMoving: value),
              ),
              builder: (context, value, child) {
                return Positioned(
                  left: value.dx - dl,
                  top: value.dy - dl,
                  child: child,
                );
              },
            ),
            GestureDetector(
              onPanStart: (details) => _update(details.localPosition, true),
              onPanUpdate: (details) => _update(details.localPosition),
              onPanEnd: (details) => _update(_position.value, false),
            ),
          ],
        ),
      ),
    );
  }

  void _update(Offset value, [bool isMoving]) {
    if (isMoving != null) {
      _dragging.value = isMoving;
    }
    if ((_center - value).distance.abs() > length / 2) {
      return;
    }
    final distance = (_position.value - value).distance.abs();
    if (distance > 8) {
      _position.value = value;
    }
  }
}
