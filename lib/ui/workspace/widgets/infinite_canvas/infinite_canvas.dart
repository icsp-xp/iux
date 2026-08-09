import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:iux/ui/workspace/widgets/canvas_components/box_component.dart';
import 'package:iux/ui/workspace/widgets/canvas_grid/line_grid.dart';
import 'package:iux/ui/workspace/widgets/infinite_canvas/cubit/infinite_canvas_cubit.dart';

class InfiniteCanvas extends StatefulWidget {
  final Size canvasSize = const .square(99999);

  const InfiniteCanvas({super.key});

  @override
  State<InfiniteCanvas> createState() => _InfiniteCanvasState();
}

class _InfiniteCanvasState extends State<InfiniteCanvas> {
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void centerOn(Offset scenePoint, Size viewportSize) {
    final scale = _transformationController.value.getMaxScaleOnAxis();

    final viewportCenter = Offset(
      viewportSize.width / 2,
      viewportSize.height / 2,
    );

    final translation = viewportCenter - scenePoint * scale;

    _transformationController.value = Matrix4.identity()
      ..translateByDouble(translation.dx, translation.dy, 0, 1)
      ..scaleByDouble(scale, scale, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<InfiniteCanvasCubit>(),
      child: LayoutBuilder(
        builder: (context, canvasCstr) {
          final viewSize = Size(canvasCstr.maxWidth, canvasCstr.maxHeight);

          return Stack(
            children: [
              InteractiveViewer(
                transformationController: _transformationController,
                constrained: false,
                boundaryMargin: const .all(double.infinity),
                minScale: 0.1,
                maxScale: 5,
                child: ValueListenableBuilder(
                  valueListenable: _transformationController,
                  builder: (context, _, child) {
                    final viewportRect = Rect.fromPoints(
                      _transformationController.toScene(Offset.zero),
                      _transformationController.toScene(
                        Offset(canvasCstr.maxWidth, canvasCstr.maxHeight),
                      ),
                    );

                    return CustomPaint(
                      painter: LineGrid(
                        viewportRect: viewportRect,
                        lineColor: context.theme.colors.primary,
                      ),
                      child: child,
                    );
                  },
                  child: SizedBox.fromSize(
                    size: widget.canvasSize,
                    // Where to place project components
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: BoxComponent(
                            position: Offset(0, 0),
                            size: Size(3, 10),
                          ),
                        ),

                        CustomPaint(
                          painter: BoxComponent(
                            position: Offset(10, 0),
                            size: Size(30, 10),
                          ),
                        ),

                        CustomPaint(
                          painter: BoxComponent(
                            position: Offset(0, 20),
                            size: Size(80, 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Overlay UI
              Align(
                alignment: .topRight,
                child: Padding(
                  padding: const .all(8),
                  child: FButton.icon(
                    size: .lg,
                    onPress: () => centerOn(Offset.zero, viewSize),
                    child: const Icon(FLucideIcons.shrink),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
