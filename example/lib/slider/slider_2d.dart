import 'package:flutter/material.dart';
import 'package:slider/slider/grid.dart';

class Slider2D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Grid(
        background: Colors.blue[100],
        showAxis: true,
      ),
    );
  }
}
