import 'package:auto_route/auto_route.dart';
import 'package:iux/ui/test_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class IuxRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TestRoute.page, initial: true)
  ];
}
