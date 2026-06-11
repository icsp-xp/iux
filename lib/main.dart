import 'package:flutter/widgets.dart';
import 'package:iux/data/iux_database.dart';
import 'package:iux/data/repository/projects_repository.dart';
import 'package:iux/routing/router.dart';
import 'package:iux/ui/core/theme/iux_theme.dart';
import 'package:iux/ui/core/theme/theme.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = IuxDatabase();

  final projectsRepository = ProjectsRepository(database);

  final router = IuxRouter();
  const theme = IuxTheme();

  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: projectsRepository)],
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
          final primaryColor = ThemeProvider.of(context).colorScheme.primary;

          return WidgetsApp.router(
            color: primaryColor,
            routerConfig: router.config(),
          );
        },
      ),
    );
  }
}
