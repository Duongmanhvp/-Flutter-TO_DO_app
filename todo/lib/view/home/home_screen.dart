import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/view/home/components/home_app_bar.dart';
import 'package:todo/view/home/components/slider_drawer.dart';
import 'package:todo/view/home/widget/fab.dart';
import 'package:todo/view/home/widget/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();
          tasks.sort((a, b) => a.createdDate.compareTo(b.createdDate));
          return Scaffold(
            backgroundColor: Colors.white,
            //FAB
            floatingActionButton: const FAB(),
            // BODY
            body: SliderDrawer(
              key: drawerKey,
              isDraggable: false,
              animationDuration: 500,
              slider: CustomDrawer(),
              appBar: HomeAppBar(
                drawerKey: drawerKey,
              ),
              child: _buildMainBody(base, tasks),
            ),
          );
        });
  }

  Widget _buildMainBody(
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // App Bar
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            width: double.infinity,
            height: 100,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress indicator
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation(
                      Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      "${checkDoneTask(tasks)} of ${tasks.length} tasks",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Divider
          const Divider(
            thickness: 2.0,
            indent: 120,
          ),

          //
          SizedBox(
            width: double.infinity,
            height: 600,
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Dismissible(
                          key: Key(
                            task.id,
                          ),
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            //remove task from DB
                            base.dataStore.deleteTask(task: task);
                          },
                          background: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Task was deleted ",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          child: TaskWidget(
                            task: task,
                          ));
                    })
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Lottie.asset(
                            "assets/lottie/done.json",
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 50,
                        child: const Text(
                          "All your tasks was done !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
