import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:iux/ui/workspace/widgets/infinite_canvas/infinite_canvas.dart';

import './cubit/workspace_cubit.dart';

@RoutePage()
class WorkspacePage extends StatelessWidget {
  final String projectPath;

  const WorkspacePage({required this.projectPath, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkspaceCubit(),
      child: const WorkspaceView(),
    );
  }
}

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: FResizable(
        control: const .managed(),
        axis: .horizontal,
        children: [
          .flex(builder: (_, data, _) => Placeholder()),
          .flex(flex: 3, builder: (_, data, _) => const InfiniteCanvas()),
          .flex(builder: (_, data, _) => Placeholder()),
        ],
      ),
    );
  }
}
