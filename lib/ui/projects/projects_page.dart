import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/core/extension/context_ext.dart';
import 'package:iux/ui/core/icons/icons.dart';
import 'package:iux/ui/core/ui/button/button.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:iux/ui/core/ui/scaffold.dart';
import 'package:iux/ui/core/ui/text_input.dart';
import 'package:iux/ui/projects/cubit/projects_cubit.dart';
import 'package:iux/ui/projects/widgets/project.dart';

@RoutePage()
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsCubit(projectsRepository: context.read()),
      child: const ProjectsView(),
    );
  }
}

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final typography = theme.typography;
    final colorScheme = theme.colorScheme;
    final radius = theme.radiusSize;
    final spacing = theme.spacing;

    return Scaffold(
      leftBar: Container(color: colorScheme.surfaceContainerHigh),
      leftBarWidth: 200.0,
      center: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: spacing.medium,
          children: [
            Row(
              spacing: spacing.smaller,
              children: [
                Expanded(
                  child: Text('Projects', style: typography.titleMedium),
                ), // TODO: localize
                Button.primary(
                  leading: const Icon(Icons.plus),
                  child: Text('Add Project'),
                  onPressed: () {},
                ), // TODO: localize
              ],
            ),

            Row(
              spacing: spacing.smaller,
              children: [Flexible(child: TextInput(initialValue: 'Search'))],
            ),

            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(radius.medium),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (_, _) {
                    return const Project(name: 's', path: 'as');
                  },
                  separatorBuilder: (_, _) => Gap(spacing.smaller),
                  itemCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
