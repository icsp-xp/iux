import 'package:mason/mason.dart';

void run(HookContext context) {
  final stateManagement = context.vars['state_management']
      .toString()
      .toLowerCase();

  context.vars['is_cubit'] = stateManagement == 'cubit';
  context.vars['is_bloc'] = stateManagement == 'bloc';
}
