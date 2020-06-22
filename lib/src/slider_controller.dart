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
  // TODO: Update this controller as TextEditingController.

  /// {@macro slider_ctrl}
  SliderController() : super(GridValue());

  /// Creates a controller with cartesian coordinates
  SliderController.withCoordinates({double x, double y})
      : super(GridValue.fromCoordinates(x: x, y: y));

  /// Creates a controller with polar coordinates
  SliderController.withPolar({double r, double teta})
      : super(GridValue.fromPolar(r: r, teta: teta));
}
