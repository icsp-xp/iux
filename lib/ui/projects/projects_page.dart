import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:iux/ui/core/icons/icons.dart';
import 'package:iux/ui/core/ui/button/button.dart';
import 'package:iux/ui/core/ui/scaffold.dart';
import 'package:iux/ui/core/ui/text_input.dart';

@RoutePage()
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      header: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        height: 32.0,
      ),
      leftBar: Container(color: Color.fromARGB(255, 0, 0, 0)),
      leftBarWidth: 100.0,
      rightBar: Container(color: Color.fromARGB(255, 255, 0, 0)),
      rightBarWidth: 43.0,
      topBar: Container(color: Color.fromARGB(255, 0, 255, 0)),
      topBarHeight: 10.0,
      bottomBar: Container(color: Color.fromARGB(255, 0, 0, 255)),
      bottomBartHeight: 50.0,
      center: Column(
        children: [
          Row(
            spacing: 8.0,
            children: [
              Expanded(child: Text('Projects')), // TODO: localize
              Button.primary(
                child: Text('Add Project'),
                onPressed: () {},
              ), // TODO: localize
              Button.secondary(
                child: Text('Add Project'),
                onPressed: () {},
              ), // TODO: localize
              Button.error(
                leading: Icon(Icons.plus),
                child: Text('Add Project'),
                onPressed: () {},
              ), // TODO: localize
            ],
          ),
          TextInput('value'),
        ],
      ),
    );
  }
}
