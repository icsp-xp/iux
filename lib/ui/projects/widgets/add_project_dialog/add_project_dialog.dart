import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/core/extension/context_ext.dart';
import 'package:iux/ui/core/icons/icons.dart';
import 'package:iux/ui/core/ui/button/button.dart';
import 'package:iux/ui/core/ui/dialog.dart';
import 'package:iux/ui/core/ui/gap.dart';
import 'package:iux/ui/core/ui/text_input.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_cubit.dart';
import 'package:iux/ui/projects/widgets/add_project_dialog/cubit/add_project_dialog_state.dart';

void showAddProjectDialog(BuildContext context) {
  final spacing = context.theme.spacing;

  showRawDialog(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => AddProjectDialogCubit(
        projectsRepository: context.read(),
        iuxSettingsRepository: context.read(),
      )..setDirPathToDefault(),
      child: Dialog(
        builder: (context) => Column(
          crossAxisAlignment: .start,
          children: [
            Text('Name'),
            TextInput(
              onChanged: context.read<AddProjectDialogCubit>().onNameChanged,
            ),

            Gap(spacing.small),

            Text('Dir Path'),
            Row(
              spacing: spacing.smaller,
              children: [
                Expanded(
                  child:
                      BlocBuilder<AddProjectDialogCubit, AddProjectDialogState>(
                        builder: (context, state) {
                          return TextInput(
                            value: state.dirPath,
                            onChanged: context
                                .read<AddProjectDialogCubit>()
                                .onDirPathChanged,
                          );
                        },
                      ),
                ),
                Button.secondary(
                  child: Icon(Icons.plus),
                  onPressed: () => context
                      .read<AddProjectDialogCubit>()
                      .getProjectDir('Project folder'),
                ),
              ],
            ),

            const Spacer(),

            Row(
              spacing: spacing.smaller,
              mainAxisAlignment: .center,
              children: [
                Button.secondary(child: Text('Cancel'), onPressed: context.pop),
                BlocBuilder<AddProjectDialogCubit, AddProjectDialogState>(
                  builder: (context, state) {
                    return Button.primary(
                      child: Text('Add'),
                      onPressed: state.canAdd()
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
  );
}
