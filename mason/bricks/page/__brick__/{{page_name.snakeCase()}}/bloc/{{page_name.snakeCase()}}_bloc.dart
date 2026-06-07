import 'package:flutter_bloc/flutter_bloc.dart';
import './{{page_name.snakeCase()}}_events.dart';
import './{{page_name.snakeCase()}}_state.dart';

final class {{page_name.pascalCase()}}Bloc extends Bloc<{{page_name.pascalCase()}}Event, {{page_name.pascalCase()}}State> {
  {{page_name.pascalCase()}}Bloc() : super(const {{page_name.pascalCase()}}State());
}