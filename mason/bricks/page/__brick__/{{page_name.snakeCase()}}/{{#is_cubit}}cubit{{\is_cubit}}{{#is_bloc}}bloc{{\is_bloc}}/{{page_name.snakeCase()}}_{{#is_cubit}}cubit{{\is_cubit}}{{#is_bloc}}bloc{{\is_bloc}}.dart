import 'package:flutter_bloc/flutter_bloc.dart';
{{#is_bloc}}import './{{page_name.snakeCase()}}_event.dart';{{/is_bloc}}
import './{{page_name.snakeCase()}}_state.dart';

{{#is_cubit}}
final class {{page_name.pascalCase()}}Cubit extends Cubit<{{page_name.pascalCase()}}State> {
  {{page_name.pascalCase()}}Cubit() : super(const {{page_name.pascalCase()}}State());
}
{{/is_cubit}}
{{#is_bloc}}
final class {{page_name.pascalCase()}}Bloc extends Bloc<{{page_name.pascalCase()}}Event, {{page_name.pascalCase()}}State> {
  {{page_name.pascalCase()}}Bloc() : super(const {{page_name.pascalCase()}}State()) {
    on<{{page_name.pascalCase()}}Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
{{/is_bloc}}