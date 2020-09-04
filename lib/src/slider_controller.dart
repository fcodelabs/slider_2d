import 'package:flutter/material.dart';

import 'grid_value.dart';
import 'slider_2d.dart';

/// {@template slider_ctrl}
/// A controller for [Slider2D]
///
/// Whenever user drag and change the position of the pointer, the slider
/// will update the [value] and the controller will notify its listeners.
/// Listeners can then read the [value] to learn what the user did to the
/// slider.
///
/// Similarly, you can modify the [value] property, the Slider will be
/// notified and will update itself appropriately.
///
///
/// See also:
///
///  * [Slider2D] - Slider that this controller is used with
///  * [Grid] - Used to generate the place that pointer is moving
///  * [GridTheme] - Theme that is used in the [Grid]
///  * [GridValue] - Position of the pointer in the grid
///  * [Pointer] - Default pointer that is used in the [Grid].
///  Can be override with [pointerBuilder].
/// {@endtemplate}
class SliderController extends ValueNotifier<GridValue> {
  /// {@macro slider_ctrl}
  SliderController() : super(GridValue());

  /// Creates a controller with cartesian coordinates
  SliderController.withCoordinates({double x, double y})
      : super(GridValue.fromCoordinates(x: x, y: y));

  /// Creates a controller with polar coordinates
  SliderController.withPolar({double r, double teta})
      : super(GridValue.fromPolar(r: r, teta: teta));

  /// Get whether this slider is enabled or not
  bool get enabled => value.enabled;

  /// Set whether this slider is enabled or not
  set enabled(bool enabled) => value.copyWith(enabled: enabled);

  /// Get the x coordinate of the slider pointer
  double get x => value.x;

  /// Set the x coordinate of the slider pointer
  set x(double x) => value = value.copyWith(x: x);

  /// Get the y coordinate of the slider pointer
  double get y => value.y;

  /// Set the y coordinate of the slider pointer
  set y(double y) => value = value.copyWith(y: y);

  /// Get the distance to the slider pointer from the center
  double get r => value.r;

  /// Set the distance to the slider pointer from the center
  set r(double r) => value = value.copyWith(r: r);

  /// Get the angle to the pointer from the x-axis
  double get teta => value.teta;

  /// Set the angle to the pointer from the x-axis
  set teta(double teta) => value = value.copyWith(teta: teta);
}
