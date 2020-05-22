import 'package:flutter/material.dart';
import 'package:slider2d/slider2d.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2D Slider Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity),
          Slider2D(
            length: 200,
            gridTheme: GridTheme(
              background: Colors.green[100],
              showGrid: true,
              showAxis: true,
            ),
          ),
        ],
      ),
    );
  }
}
