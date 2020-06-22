import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slider2d/slider2d.dart';

import 'grid.dart';
import 'grid_theme.dart';
import 'grid_value.dart';
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
/// A 2 Dimensional slider that can be used to pick values from
/// a 2 dimensional grid.
///
/// Value of the slider can be obtained as cartesian coordinates
/// or polar coordinates. The position is wrapped in [GridValue].
/// Maximum and minimum values of this slider is -1 and +1. Regardless
/// the [length] of the [Slider2D], the value of [Slider2D] is in
/// between -1 and +1.
///
/// See also:
///
///  * [Grid] - Used to generate the place that pointer is moving
///  * [GridTheme] - Theme that is used in the [Grid]
///  * [GridValue] - Position of the pointer in the grid
///  * [Pointer] - Default pointer that is used in the [Grid].
///  Can be override with [pointerBuilder].
/// {@endtemplate}
class Slider2D extends StatelessWidget {
  /// Theme that is used in [Grid] which is used to generate the
  /// plane that the pointer is moving
  final GridTheme gridTheme;

  /// Height and width of this [Slider2D] is equal to [length].
  final double length;

  /// Height and width of the pointer on the [Grid] is equal to this value.
  final double pointerLength;

  /// By providing this builder, you can change the default [Pointer]
  /// that is shown in the [Grid].
  final PointerBuilder pointerBuilder;

  /// This function is called whenever the position of the pointer changed.
  /// This is called with [GridValue] which wraps the position coordinates.
  final ValueChanged<GridValue> onChange;

  final SliderController _controller;

  /// {@macro slider_2d}
  Slider2D({
    Key key,
    @required this.gridTheme,
    this.onChange,
    SliderController controller,
    this.pointerBuilder,
    this.length,
    this.pointerLength,
  })  : _controller = (controller ?? SliderController()),
        super(key: key) {
    _controller.addListener(() => onChange?.call(_controller.value));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final length = this.length ?? min(size.height, size.width);
    final pointerLength = this.pointerLength ?? 24;
    final dl = pointerLength / 2;
    final center = Offset(length / 2, length / 2);

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
            ValueListenableBuilder<GridValue>(
              valueListenable: _controller,
              builder: (context, value, _) {
                if (value == null) {
                  return Container();
                }
                final offset = _toLocal(value, center, length, dl);
                return Positioned(
                  left: offset.dx - dl,
                  top: offset.dy - dl,
                  child: pointerBuilder?.call(
                          context, pointerLength, value.moving) ??
                      Pointer(length: pointerLength, isMoving: value.moving),
                );
              },
            ),
            GestureDetector(
              onPanStart: (details) {
                final gridValue = _toGrid(
                  details.localPosition,
                  center,
                  length,
                  dl,
                );
                _controller.value = gridValue.copyWith(moving: true);
              },
              onPanUpdate: (details) {
                final gridValue = _toGrid(
                  details.localPosition,
                  center,
                  length,
                  dl,
                );
                _controller.value = gridValue.copyWith(moving: true);
              },
              onPanEnd: (details) =>
                  _controller.value = _controller.value.copyWith(moving: false),
            ),
          ],
        ),
      ),
    );
  }

  Offset _toLocal(GridValue value, Offset center, double length, double dl) {
    final limit = (length / 2) - dl;
    final x = value.x * limit;
    final y = -value.y * limit;
    return Offset(x, y) + center;
  }

  GridValue _toGrid(Offset value, Offset center, double length, double dl) {
    final vector = value - center;
    final limit = (length / 2) - dl;
    return GridValue.fromCoordinates(
      x: vector.dx / limit,
      y: -vector.dy / limit,
    );
  }
}
