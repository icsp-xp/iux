import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';

class ResizeHandle extends StatefulWidget {
  final ValueChanged<Offset> onResize;
  final Axis direction;
  final Color? color;
  final double size;

  const ResizeHandle({
    required this.onResize,
    super.key,
    this.direction = Axis.horizontal,
    this.color,
    this.size = 4,
  });

  @override
  State<ResizeHandle> createState() => _ResizeHandleState();
}

class _ResizeHandleState extends State<ResizeHandle> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final handleColor =
        widget.color ?? ThemeProvider.of(context).colorScheme.primary;

    return MouseRegion(
      cursor: widget.direction == Axis.horizontal
          ? SystemMouseCursors.resizeColumn
          : SystemMouseCursors.resizeRow,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onHorizontalDragUpdate: widget.direction == Axis.horizontal
            ? (details) => widget.onResize(details.delta)
            : null,
        onVerticalDragUpdate: widget.direction == Axis.vertical
            ? (details) => widget.onResize(details.delta)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _isHovering
              ? handleColor.withValues(alpha: .8)
              : handleColor.withValues(alpha: .5),
          width: widget.direction == Axis.horizontal ? widget.size : null,
          height: widget.direction == Axis.vertical ? widget.size : null,
        ),
      ),
    );
  }
}
