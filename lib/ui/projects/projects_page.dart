import 'package:auto_route/auto_route.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:iux/core/extension/build_context_ext.dart';
import 'package:iux/core/extension/failure_ext.dart';
import 'package:iux/domain/model/project.dart';
import 'package:iux/domain/request_status.dart';
import 'package:iux/ui/core/theme/spacing.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:iux/ui/core/ui/show_toast.dart';
import 'package:iux/ui/projects/cubit/projects_cubit.dart';
import 'package:iux/ui/projects/cubit/projects_state.dart';
import 'package:iux/ui/projects/projects_ui_event.dart';
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
      child: BlocPresentationListener<ProjectsCubit, ProjectsUiEvent>(
        listener: (context, event) {
          switch (event) {
            case FailedToChooseProjectDir():
              showErrorToast(
                context: context,
                errorMsg: context.l10n.failedToChooseProjectDir,
              );
            default:
              break;
          }
        },
        child: const ProjectsView(),
      ),
    );
  }
}

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FScaffold(
      child: Padding(
        padding: const .all(16.0),
        child: Column(
          spacing: theme.spacing.xs,
          children: [
            Row(
              spacing: theme.spacing.xs,
              children: [
                Text(
                  context.l10n.projectsListTitle,
                  style: theme.typography.display.lg,
                ),
                Expanded(
                  child: Align(
                    alignment: .centerLeft,
                    child: BlocSelector<ProjectsCubit, ProjectsState, String?>(
                      selector: (state) => state.projectsDirPath,
                      builder: (context, projectDir) {
                        return FButton(
                          variant: .ghost,
                          mainAxisSize: .min,
                          onPress: () =>
                              context.read<ProjectsCubit>().chooseProjectDir(
                                context.l10n.selectProjectDirectory,
                              ),
                          child: Text(
                            projectDir ?? context.l10n.noDirectorySelected,
                            overflow: .ellipsis,
                            style: theme.typography.display.md.copyWith(
                              decoration: .underline,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                FButton(
                  variant: .primary,
                  prefix: const Icon(FLucideIcons.plus),
                  child: Text(context.l10n.actionAddProject),
                  onPress: () => showAddProjectDialog(context),
                ),
              ],
            ),

            Gap(theme.spacing.sm),

            Row(
              spacing: theme.spacing.xs,
              children: [
                Flexible(
                  child: FTextField(
                    control: .managed(
                      onChange: (value) =>
                          context.read<ProjectsCubit>().onSearch(value.text),
                    ),
                    prefixBuilder: (_, _, _) => const Padding(
                      padding: .all(10),
                      child: Icon(FLucideIcons.search),
                    ),
                    hint: context.l10n.searchProjectsBarPlaceholder,
                  ),
                ),
              ],
            ),

            Expanded(
              child:
                  BlocSelector<
                    ProjectsCubit,
                    ProjectsState,
                    RequestStatus<List<Project>>
                  >(
                    selector: (state) => state.projects,
                    builder: (context, projectsStatus) => projectsStatus.when(
                      idle: () => const SizedBox.expand(),
                      pending: () => const Center(child: FCircularProgress()),
                      succeeded: (projects) {
                        if (projects.isEmpty) {
                          return Center(
                            child: Text(context.l10n.emptyProjectsListLabel),
                          );
                        }

                        return ListView.separated(
                          padding: const .symmetric(vertical: 16.0),
                          itemCount: projects.length,
                          separatorBuilder: (_, _) => Gap(theme.spacing.xs),
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
                          failure.localize(context),
                          style: TextStyle(color: theme.colors.error),
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
