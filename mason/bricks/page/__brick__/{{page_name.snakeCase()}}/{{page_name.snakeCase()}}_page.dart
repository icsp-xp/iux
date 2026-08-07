import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

{{#is_cubit}}
import './cubit/{{page_name.snakeCase()}}_cubit.dart';
{{/is_cubit}}
{{#is_bloc}}
import './bloc/{{page_name.snakeCase()}}_bloc.dart';
{{/is_bloc}}

@RoutePage()
class {{page_name.pascalCase()}}Page extends StatelessWidget {
  const {{page_name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{#is_cubit}}{{page_name.pascalCase()}}Cubit(){{/is_cubit}}{{#is_bloc}}{{page_name.pascalCase()}}Bloc(){{/is_bloc}},
      child: const {{page_name.pascalCase()}}View()
    );
  }
}

class {{page_name.pascalCase()}}View extends StatelessWidget {
  const {{page_name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}