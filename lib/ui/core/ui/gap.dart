import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  final double size;

  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    Axis? parentAxis;

    context.visitAncestorElements((element) {
      final widget = element.widget;

      if (widget is Flex) {
        parentAxis = widget.direction;
      } else if (widget is Scrollable) {
        parentAxis = widget.axis;
      }

      return false;
    });

    assert(
      parentAxis != null,
      'Gap widget must be placed directly inside a Row, Column, Flex, or ListView.',
    );

    return switch (parentAxis!) {
      Axis.horizontal => SizedBox(width: size),
      Axis.vertical => SizedBox(height: size),
    };
  }
}
