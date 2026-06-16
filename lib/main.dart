import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iux/core/constants.dart';
import 'package:iux/core/extension/context_ext.dart';
import 'package:iux/core/talker_bloc_observer.dart';
import 'package:iux/data/repositories/iux_settings_repository.dart';
import 'package:iux/data/repositories/projects_repository.dart';
import 'package:iux/data/services/iux_settings_service.dart';
import 'package:iux/routing/router.dart';
import 'package:iux/ui/core/theme/iux_theme.dart';
import 'package:iux/ui/core/theme/theme.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';
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

  Bloc.observer = TalkerBlocObserver(talker);

  final router = IuxRouter();
  const theme = IuxTheme();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: iuxSettingsRepository),
        RepositoryProvider.value(value: projectsRepository),
      ],
      child: IuxApp(router: router, theme: theme),
    ),
  );
}

class IuxApp extends StatelessWidget {
  final IuxRouter router;
  final Theme theme;

  const IuxApp({required this.theme, required this.router, super.key});

  @override
  Widget build(BuildContext context) {
    final systemBrightness = MediaQuery.of(context).platformBrightness;

    return ThemeProvider(
      themeData: theme.getThemeData(systemBrightness),
      child: Builder(
        builder: (context) {
          return WidgetsApp.router(
            color: context.theme.colorScheme.primary,
            routerConfig: router.config(),
          );
        },
      ),
    );
  }
}
