import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/core/extension/context_ext.dart';
import 'package:iux/domain/model/project.dart';
import 'package:iux/domain/request_status.dart';
import 'package:iux/ui/core/icons/icons.dart';
import 'package:iux/ui/core/ui/button/button.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:iux/ui/core/ui/scaffold.dart';
import 'package:iux/ui/core/ui/text_input.dart';
import 'package:iux/ui/projects/cubit/projects_cubit.dart';
import 'package:iux/ui/projects/cubit/projects_state.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/add_project_dialog.dart';
import 'package:iux/ui/projects/widgets/project_view.dart';

@RoutePage()
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsCubit(
        projectsRepository: context.read(),
        iuxSettingsRepository: context.read(),
        getFolderPathUseCase: context.read(),
      )..init(),
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
                // TODO: localize
                Text('Projects:', style: typography.titleMedium),
                Expanded(
                  child: Align(
                    alignment: .centerLeft,
                    child: BlocSelector<ProjectsCubit, ProjectsState, String?>(
                      selector: (state) => state.projectsDirPath,
                      builder: (context, projectDir) {
                        return GhostButton(
                          onPressed: () => context
                              .read<ProjectsCubit>()
                              .chooseProjectDir('Select Project Directory'),
                          child: Text(
                            projectDir ??
                                'No directory selected', // TODO: localize
                            overflow: .ellipsis,
                            style: typography.titleSmall.copyWith(
                              decoration: .underline,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Button.primary(
                  leading: const Icon(Icons.plus),
                  child: Text('Add Project'),
                  onPressed: () => showAddProjectDialog(context),
                ), // TODO: localize
              ],
            ),

            Row(
              spacing: spacing.smaller,
              children: [Flexible(child: TextInput(value: 'Search'))],
            ),

            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(radius.medium),
                ),
                child:
                    BlocSelector<
                      ProjectsCubit,
                      ProjectsState,
                      RequestStatus<List<Project>>
                    >(
                      selector: (state) => state.projects,
                      builder: (context, projectsStatus) => projectsStatus.when(
                        idle: () => const SizedBox.expand(),
                        pending: () => Center(child: Text('loading')),
                        succeeded: (projects) {
                          if (projects.isEmpty) {
                            return const Center(child: Text('Empty'));
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: projects.length,
                            separatorBuilder: (_, _) => Gap(spacing.smaller),
                            itemBuilder: (context, index) {
                              final project = projects[index];

                              return ProjectView(
                                name: project.name,
                                path: project.dirPath,
                                onDelete: () => context
                                    .read<ProjectsCubit>()
                                    .delete(project.dirPath),
                              );
                            },
                          );
                        },
                        failed: (failure) => Center(
                          child: Text(
                            'Unexpected error.',
                            style: TextStyle(color: colorScheme.error),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
