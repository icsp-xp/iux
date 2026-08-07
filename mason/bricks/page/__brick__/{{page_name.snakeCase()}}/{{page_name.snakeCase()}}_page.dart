import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

import './bloc/{{page_name.snakeCase()}}_bloc.dart';

@RoutePage()
class {{page_name.pascalCase()}}Page extends StatelessWidget {
  const {{page_name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{page_name.pascalCase()}}Bloc(), 
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