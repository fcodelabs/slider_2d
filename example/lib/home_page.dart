import 'package:flutter/material.dart';
import 'package:slider2d/slider2d.dart';

class HomePage extends StatelessWidget {
  final _gridValue = ValueNotifier<GridValue>(null);

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
            gridTheme: GridTheme(
              background: Colors.blue[100],
              showGrid: true,
              showAxis: true,
            ),
            onChange: (value) => _gridValue.value = value,
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
                valueListenable: _gridValue,
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
