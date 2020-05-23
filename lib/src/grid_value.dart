import 'package:meta/meta.dart';

/// {@template grid_val}
/// This is used to store the current position of the [Pointer] in the [Grid].
/// {@endtemplate}
@immutable
class GridValue {

  /// x coordinate of the pointer
  /// Value is always between -1 and +1
  final double x;
  /// y coordinate of the pointer
  /// Value is always between -1 and +1
  final double y;
  /// Distance to the pointer from the center
  /// Value is always between -1 and +1
  final double r;
  /// Angle to line formed by joining the location of the pointer and the
  /// center, from the x-axis.
  /// Value is always between -pi and +pi
  /// Positive angles are measured anti-clockwise
  final double teta;

  /// {@macro grid_val}
  GridValue({
    this.x,
    this.y,
    this.r,
    this.teta,
  });
}
