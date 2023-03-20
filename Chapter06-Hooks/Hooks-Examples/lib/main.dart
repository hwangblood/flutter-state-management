import 'package:flutter/material.dart';
import 'package:testingflutterhooks_course/routes.dart';
import 'package:testingflutterhooks_course/widgets/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Hooks Example'),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: categoryEntities.length,
        itemBuilder: (context, index) {
          final entity = categoryEntities[index];
          if (entity.runtimeType == RouteEntity) {
            entity as RouteEntity;
            return RouteEntityTile(routeEntity: entity);
          } else if (entity.runtimeType == ExpansionEntity) {
            entity as ExpansionEntity;
            return Expanded(
              // https://github.com/flutter/flutter/issues/67459#issuecomment-704642883
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  onExpansionChanged: (isOpen) {},
                  title: Text(entity.title),
                  subtitle: EntitySubtitle(routeEntity: entity),
                  children: [
                    // ...generateEntityList(entity.entities),
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: EntityList(entities: entity.entities),
                        ),
                      ],
                    ),
                    // Text(entity.subtitle),
                  ],
                ),
              ),
            );
          }
          return null;
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
