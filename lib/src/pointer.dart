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

  /// True if the [Pointer] is enabled. False otherwise.
  final bool enabled;

  /// {@macro pointer}
  const Pointer({
    Key key,
    @required this.length,
    @required this.isMoving,
    @required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deco = BoxDecoration(
      color: enabled
          ? isMoving ? Colors.blueAccent : Colors.blue[900]
          : Colors.grey,
      shape: BoxShape.circle,
    );
    final trans = BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    );
    return Container(
      height: length,
      width: length,
      decoration: deco,
      child: Center(
        child: Container(
          height: length / 2 + 1,
          width: length / 2 + 1,
          decoration: trans,
          child: Center(
            child: Container(
              height: length / 2 - 1,
              width: length / 2 - 1,
              decoration: deco,
              child: Center(
                child: Container(
                  height: 2,
                  width: 2,
                  decoration: trans,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
