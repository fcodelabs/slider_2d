import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'grid.dart';

/// {@template gridTheme}
/// 2D grid is generated here. Attributes of the [Grid] can be changed by
/// providing a [theme]. Slider can be moved only inside this area.
/// {@endtemplate}
class GridTheme {
  /// Background color of the [Grid].
  final Color background;

  /// If true, x and y axis of the [Grid] will be shown.
  final bool showAxis;

  /// Color of the axis of the [Grid].
  final Color axisColor;

  /// If true, circular dotted  grids will be shown in the [Grid].
  final bool showGrid;

  /// Color of the dotted grid.
  final Color gridColor;

  /// Number of dotted grids to be shown in the [Grid].
  final int gridCount;

  /// {@macro gridTheme}
  GridTheme({
    @required this.background,
    this.showAxis = false,
    this.axisColor = Colors.black54,
    this.showGrid = false,
    this.gridColor = Colors.black38,
    this.gridCount = 3,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GridTheme &&
              runtimeType == other.runtimeType &&
              background == other.background &&
              showAxis == other.showAxis &&
              axisColor == other.axisColor &&
              showGrid == other.showGrid &&
              gridColor == other.gridColor &&
              gridCount == other.gridCount;

  @override
  int get hashCode =>
      background.hashCode ^
      showAxis.hashCode ^
      axisColor.hashCode ^
      showGrid.hashCode ^
      gridColor.hashCode ^
      gridCount.hashCode;


}
