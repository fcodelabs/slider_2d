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

  /// Height of this [Pointer].
  /// [Slider2D] is assuming the height of this [Pointer] to be equal to
  /// this value. Default [buildPointer] method will make sure that this
  /// pointer's actual height is equal to the given [height].
  final double height;

  /// Width of this [Pointer].
  /// [Slider2D] is assuming the width of this [Pointer] to be equal to
  /// this value. Default [buildPointer] method will make sure that this
  /// pointer's actual width is equal to the given [width].
  final double width;

  /// If [isMoving] is false, this [Widget] will be shown in the grid.
  final WidgetBuilder restPointerBuilder;

  /// If [isMoving] is true, this [Widget] will be shown in the grid.
  final WidgetBuilder movingPointerBuilder;

  /// {@macro pointer}
  Pointer({
    Key key,
    @required this.height,
    @required this.width,
    @required this.restPointerBuilder,
    @required this.movingPointerBuilder,
    @required this.isMoving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildPointer(context,
        isMoving ? movingPointerBuilder(context) : restPointerBuilder(context));
  }

  /// This will generate the pointer widget of the Grid. This widget will
  /// receive a child either from [restPointerBuilder] or [movingPointerBuilder]
  /// and this method will wrap that [Widget] with some other [Widget]
  ///
  /// The default functionality of this method is to wrap the given [child]
  /// with a [FittedBox] to fit its size to the given [height] and [width].
  /// But you can override this functionality.
  ///
  /// Please note that the [Slider2D] will take the pointer size from [height]
  /// and [width] variables. Not from the actual size of this [Widget].
  Widget buildPointer(BuildContext context, Widget child) {
    return SizedBox(
      height: height,
      width: width,
      child: FittedBox(
        child: child,
      ),
    );
  }
}
