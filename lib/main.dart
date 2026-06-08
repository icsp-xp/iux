import 'package:flutter/widgets.dart';
import 'package:iux/routing/router.dart';
import 'package:iux/ui/core/theme/iux_theme.dart';
import 'package:iux/ui/core/theme/theme.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';

void main() {
  final router = IuxRouter();
  const theme = IuxTheme();

  runApp(IuxApp(router: router, theme: theme));
}

class IuxApp extends StatelessWidget {
  final IuxRouter router;
  final Theme theme;

  const IuxApp({required this.theme, required this.router, super.key});

  @override
  Widget build(BuildContext context) {
    final systemBrightness = MediaQuery.of(context).platformBrightness;

    return ThemeProvider(
      themeData: theme.getThemeFromBrightness(systemBrightness),
      child: WidgetsApp.router(
        color: const Color.fromARGB(1, 0, 0, 0),
        routerConfig: router.config(),
      ),
    );
  }
}
