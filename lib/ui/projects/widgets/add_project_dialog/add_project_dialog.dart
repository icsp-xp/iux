import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:iux/ui/core/constants/spacing.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_cubit.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';

void showAddProjectDialog(BuildContext context) {
  showFDialog(
    context: context,
    builder: (context, style, animation) => BlocProvider(
      create: (context) => AddProjectDialogCubit(
        projectsRepository: context.read(),
        iuxSettingsRepository: context.read(),
        getFolderPathUseCase: context.read(),
      )..setDirPathToDefault(),
      child: FDialog(
        style: style,
        animation: animation,
        builder: (context, style) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('Name'),
              FTextField(
                control: FTextFieldControl.managed(
                  onChange: (textEditingValue) => context
                      .read<AddProjectDialogCubit>()
                      .onNameChanged(textEditingValue.text),
                ),
              ),

              const Gap(Spacing.sm),

              Text('Dir Path'),
              Row(
                spacing: Spacing.sm,
                children: [
                  Expanded(
                    child:
                        BlocBuilder<
                          AddProjectDialogCubit,
                          AddProjectDialogState
                        >(
                          builder: (context, state) {
                            return FTextField(
                              control: FTextFieldControl.managed(
                                initial: TextEditingValue(text: state.dirPath),
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
                        .getProjectDir('Select Project Directory'),
                  ),
                ],
              ),

              const Spacer(),

              Row(
                spacing: Spacing.sm,
                mainAxisAlignment: .center,
                children: [
                  FButton(
                    variant: .secondary,
                    onPress: context.pop,
                    child: Text('Cancel'),
                  ),
                  BlocBuilder<AddProjectDialogCubit, AddProjectDialogState>(
                    builder: (context, state) {
                      return FButton(
                        variant: .primary,
                        child: Text('Add'),
                        onPress: state.canAdd()
                            ? () {
                                context.read<AddProjectDialogCubit>().onAdd();
                                context.pop();
                              }
                            : null,
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
  );
}
