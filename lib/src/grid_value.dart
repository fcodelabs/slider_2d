import 'dart:math';
import 'dart:ui';

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

  /// Indicate whether the pointer is moving in the grid or not.
  /// True if moving and false otherwise
  final bool moving;

  /// {@macro grid_val}
  GridValue({
    this.x = 0,
    this.y = 0,
    this.r = 0,
    this.teta = 0,
    this.moving = false,
  });

  /// Generate a new value from [x] and [y] values. [moving] will be
  /// considered as [false].
  static GridValue fromCoordinates({double x, double y}) {
    final vector = Offset(x, y);
    final teta = vector.direction;
    final r = min(1.0, vector.distance);
    return GridValue.fromPolar(r: r, teta: teta);
  }

  /// Generate a new value from [r] and [teta], which will be the polar
  /// coordinates of the grid. [moving] will be considered as [false].
  static GridValue fromPolar({double r, double teta}) {
    return GridValue(
      x: r * cos(teta),
      y: r * sin(teta),
      r: r,
      teta: teta,
      moving: false,
    );
  }

  /// Creates a copy of this grid value but with the given fields replaced
  /// with the new values.
  GridValue copyWith({
    double x,
    double y,
    double r,
    double teta,
    bool moving,
  }) {
    return GridValue(
      x: x ?? this.x,
      y: y ?? this.y,
      r: r ?? this.r,
      teta: teta ?? this.teta,
      moving: moving ?? this.moving,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GridValue &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          r == other.r &&
          teta == other.teta &&
          moving == other.moving;

  @override
  int get hashCode =>
      x.hashCode ^ y.hashCode ^ r.hashCode ^ teta.hashCode ^ moving.hashCode;
}
