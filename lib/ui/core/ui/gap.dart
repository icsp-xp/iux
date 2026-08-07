import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Gap extends LeafRenderObjectWidget {
  final double gap;

  const Gap(this.gap, {super.key}) : assert(gap >= 0);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGap(gap);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderGap renderObject,
  ) {
    renderObject.setSize(gap);
  }
}

class RenderGap extends RenderBox {
  RenderGap(double gap) : _gap = gap;

  double _gap;

  void setSize(double value) {
    if (_gap != value) {
      _gap = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final parentNode = parent;

    if (parentNode is RenderFlex) {
      if (parentNode.direction == Axis.horizontal) {
        size = constraints.constrain(Size(_gap, 0));
      } else {
        size = constraints.constrain(Size(0, _gap));
      }
    } else {
      size = constraints.constrain(Size(_gap, _gap));
    }
  }
}
