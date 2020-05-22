import 'package:flutter/material.dart';

import 'grid.dart';
import 'grid_theme.dart';

class Slider2D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Grid(
        theme: GridTheme(
          background: Colors.blue[100],
        ),
      ),
    );
  }
}
