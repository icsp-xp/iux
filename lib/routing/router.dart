import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:iux/ui/projects/projects_page.dart';
import 'package:iux/ui/workspace/workspace_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class IuxRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: ProjectsRoute.page, initial: true),
    AutoRoute(page: WorkspaceRoute.page),
  ];
}
