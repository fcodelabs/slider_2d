import 'package:flutter/material.dart';

import 'slider_2d.dart';

/// {@template pointer}
/// The pointer that is shown in the [Grid].
///
/// All the attributes of this is required. Providing null will result
/// in unexpected errors.
/// {@endtemplate}
class Pointer extends StatelessWidget {
  /// True if this [Pointer] is moving. False otherwise.
  final bool isMoving;

  /// Height and width of this [Pointer].
  /// [Slider2D] is assuming the both the height and width of this [Pointer]
  /// to be equal to this value.
  final double length;

  /// {@macro pointer}
  const Pointer({
    Key key,
    @required this.length,
    @required this.isMoving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: length,
      width: length,
      color: isMoving ? Colors.blueAccent : Colors.blue[900],
    );
  }
}
