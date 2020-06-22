import 'package:flutter/material.dart';
import 'package:slider2d/slider2d.dart';

class HomePage extends StatelessWidget {
  final _sliderController = SliderController.withPolar(r: 0.4, teta: 1.2);

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
          Slider2D(
            length: 200,
            controller: _sliderController,
            gridTheme: GridTheme(
              background: Colors.blue[100],
              showGrid: true,
              showAxis: true,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("x:"),
                  Text("y:"),
                  Text("radius:"),
                  Text("teta:"),
                ],
              ),
              SizedBox(width: 16),
              ValueListenableBuilder<GridValue>(
                valueListenable: _sliderController,
                builder: (context, value, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${value.x}"),
                    Text("${value.y}"),
                    Text("${value.r}"),
                    Text("${value.teta}"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
