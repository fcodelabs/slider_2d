import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'grid_theme.dart';

/// {@template grid}
/// 2D grid is generated here. Attributes of the [Grid] can be changed by
/// providing a [theme]. Slider can be moved only inside this area.
/// {@endtemplate}
class Grid extends CustomPainter {
  /// [GridTheme] that will be used to generate this [Grid].
  final GridTheme theme;

  final Paint _backP;
  final Paint _axisP;
  final Paint _gridP;

  /// {@macro grid}
  Grid({
    @required this.theme,
  })  : _backP = Paint()..color = theme.background,
        _axisP = Paint()
          ..color = theme.axisColor
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        _gridP = Paint()
          ..color = theme.gridColor
          ..strokeWidth = 0.6
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

  void _drawLine(
    Path path,
    Offset start,
    Offset end,
    double dashWidth,
    double dashSpace,
  ) {
    final delta = end - start;
    final dWx = dashWidth * cos(delta.direction);
    final dWy = dashWidth * sin(delta.direction);
    final dSx = dashSpace * cos(delta.direction);
    final dSy = dashSpace * sin(delta.direction);

    var next = Offset(start.dx + dWx, start.dy + dWy);
    var line = true;
    while (end.distance >= next.distance) {
      if (line) {
        path.moveTo(start.dx, start.dy);
        path.lineTo(next.dx, next.dy);
      } else {
        path.moveTo(next.dx, next.dy);
      }
      line = !line;
      start = next;
      if (line) {
        next = Offset(next.dx + dWx, next.dy + dWy);
      } else {
        next = Offset(next.dx + dSx, next.dy + dSy);
      }
    }
  }

  void _drawCircle(
    Path path,
    Offset center,
    double r,
    double dashLength,
    double spaceLength,
  ) {
    final dashArc = dashLength / r;
    final spaceArc = spaceLength / r;

    var start = 0.0;
    var next = dashArc;
    var line = true;
    while (next <= 2 * pi) {
      if (line) {
        path.addArc(Rect.fromCircle(center: center, radius: r), start, dashArc);
      }
      line = !line;
      start = next;
      if (line) {
        next += dashArc;
      } else {
        next += spaceArc;
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _backP,
    );

    if (theme.showAxis) {
      final path = Path();
      _drawLine(path, Offset(0, size.height / 2),
          Offset(size.width, size.height / 2), 2, 4);
      _drawLine(path, Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height), 2, 4);
      canvas.drawPath(path, _axisP);
    }

    if (theme.showGrid) {
      final path = Path();
      for (var i = 1; i < theme.gridCount + 1; i++) {
        final ratio = 0.5 * i / (theme.gridCount + 1);
        _drawCircle(path, Offset(size.width / 2, size.height / 2),
            ratio * size.width, 2, 4);
      }
      canvas.drawPath(path, _gridP);
    }
  }

  @override
  bool shouldRepaint(Grid oldDelegate) => theme != oldDelegate.theme;
}
