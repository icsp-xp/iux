import 'package:auto_route/auto_route.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:iux/core/extension/build_context_ext.dart';
import 'package:iux/ui/core/theme/spacing.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:iux/ui/core/ui/show_toast.dart';
import 'package:iux/ui/projects/projects_ui_event.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_cubit.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';

void showAddProjectDialog(BuildContext context) {
  final theme = context.theme;

  showFDialog(
    context: context,
    builder: (context, style, animation) => BlocProvider(
      create: (context) => AddProjectDialogCubit(
        projectsRepository: context.read(),
        iuxSettingsRepository: context.read(),
        getFolderPathUseCase: context.read(),
      )..setDirPathToDefault(),
      child: BlocPresentationListener<AddProjectDialogCubit, ProjectsUiEvent>(
        listener: (context, event) {
          switch (event) {
            case FailedToCreateTheProject():
              showErrorToast(
                context: context,
                errorMsg: context.l10n.failedToCreateProject,
              );
            default:
              break;
          }
        },
        child: FDialog(
          style: style,
          animation: animation,
          builder: (context, style) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                FTextField(
                  label: Text(context.l10n.projectNameLabel),
                  control: .managed(
                    onChange: (textEditingValue) => context
                        .read<AddProjectDialogCubit>()
                        .onNameChanged(textEditingValue.text),
                  ),
                ),

                Gap(theme.spacing.sm),

                Row(
                  crossAxisAlignment: .end,
                  spacing: theme.spacing.sm,
                  children: [
                    Expanded(
                      child:
                          BlocBuilder<
                            AddProjectDialogCubit,
                            AddProjectDialogState
                          >(
                            builder: (context, state) {
                              return FTextField(
                                label: Text(context.l10n.projectDirPathLabel),
                                control: .lifted(
                                  value: TextEditingValue(
                                    text: state.dirPath,
                                    selection: .collapsed(
                                      offset: state.dirPath.length,
                                    ),
                                  ),
                                  onChange: (textEditingValue) => context
                                      .read<AddProjectDialogCubit>()
                                      .onDirPathChanged(textEditingValue.text),
                                ),
                              );
                            },
                          ),
                    ),
                    FButton.icon(
                      variant: .secondary,
                      child: const Icon(FLucideIcons.plus),
                      onPress: () => context
                          .read<AddProjectDialogCubit>()
                          .getProjectDir(context.l10n.selectProjectDirectory),
                    ),
                  ],
                ),

                const Spacer(),

                Row(
                  spacing: theme.spacing.sm,
                  mainAxisAlignment: .center,
                  children: [
                    FButton(
                      variant: .secondary,
                      onPress: context.pop,
                      child: Text(context.l10n.actionCancel),
                    ),
                    BlocBuilder<AddProjectDialogCubit, AddProjectDialogState>(
                      builder: (context, state) {
                        return FButton(
                          variant: .primary,
                          onPress: state.canAdd()
                              ? () {
                                  context.read<AddProjectDialogCubit>().onAdd();
                                  context.pop();
                                }
                              : null,
                          child: Text(context.l10n.actionAdd),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
