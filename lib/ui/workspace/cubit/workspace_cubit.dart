import 'package:flutter_bloc/flutter_bloc.dart';

import './workspace_state.dart';

final class WorkspaceCubit extends Cubit<WorkspaceState> {
  WorkspaceCubit() : super(const WorkspaceState());
}
