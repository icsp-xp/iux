import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/localizations.dart';
import 'package:forui/theme.dart';
import 'package:forui/widgets/toast.dart';
import 'package:forui/widgets/tooltip.dart';
import 'package:iux/core/constants.dart';
import 'package:iux/core/talker_bloc_observer.dart';
import 'package:iux/data/repositories/iux_settings_repository.dart';
import 'package:iux/data/repositories/projects_repository.dart';
import 'package:iux/data/services/iux_settings_service.dart';
import 'package:iux/domain/use_cases/get_folder_path_use_case.dart';
import 'package:iux/routing/router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:talker/talker.dart';

final talker = Talker();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final iuxDir = await getApplicationSupportDirectory();
  final iuxSettingsFile = File(p.join(iuxDir.path, Constants.settingsFile));

  // Services
  final iuxSettingsService = IuxSettingsService(iuxSettingsFile);

  // Repositories
  final iuxSettingsRepository = IuxSettingsRepository(iuxSettingsService);
  final projectsRepository = ProjectsRepository();

  // Use cases
  final getFolderPathUseCase = GetFolderPathUseCase();

  Bloc.observer = TalkerBlocObserver(talker);

  final router = IuxRouter();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: iuxSettingsRepository),
        RepositoryProvider.value(value: projectsRepository),
        // Use cases
        RepositoryProvider.value(value: getFolderPathUseCase),
      ],
      child: IuxApp(router: router),
    ),
  );
}

class IuxApp extends StatelessWidget {
  final IuxRouter router;

  const IuxApp({required this.router, super.key});

  @override
  Widget build(BuildContext context) {
    final (lightTheme, darkTheme) =
        const <TargetPlatform>{
          .android,
          .iOS,
          .fuchsia,
        }.contains(defaultTargetPlatform)
        ? (FTheme.neutral.light.touch, FTheme.neutral.dark.touch)
        : (FTheme.neutral.light.desktop, FTheme.neutral.dark.desktop);

    return MaterialApp.router(
      localizationsDelegates: const [FLocalizations.delegate],

      theme: lightTheme.toApproximateMaterialTheme(),
      darkTheme: darkTheme.toApproximateMaterialTheme(),

      routerConfig: router.config(),

      builder: (context, child) => FTheme(
        data: Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
        child: FToaster(child: FTooltipGroup(child: child!)),
      ),
    );
  }
}
