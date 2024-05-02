import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/hive_data_store.dart';
import 'package:todo/models/task.dart';
import 'package:todo/view/home/home_screen.dart';
import 'package:todo/view/tasks/task_screen.dart';

Future<void> main() async {
  // init hive db
  await Hive.initFlutter();

  // register hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  // open a box
  Box box = await Hive.openBox<Task>(HiveDataStore.boxName);

  runApp(BaseWidget(child: MainApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);

  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError("Nonono");
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
