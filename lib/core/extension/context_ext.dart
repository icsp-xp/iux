import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/theme/data/theme_data.dart';
import 'package:iux/ui/core/theme/theme_provider.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => ThemeProvider.of(this);
}
