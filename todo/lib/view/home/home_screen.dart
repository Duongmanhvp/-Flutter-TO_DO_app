import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/view/home/widget/fab.dart';
import 'package:todo/view/home/widget/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> testing = [1, 2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const FAB(),
      body: SizedBox(
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Progress indicator
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      value: 1 / 3,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Tasks",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        "1 of 3 task",
                        style: TextStyle(
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
              height: 700.0,
              child: testing.isNotEmpty
                  ? ListView.builder(
                      itemCount: testing.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: Key(
                              index.toString(),
                            ),
                            direction: DismissDirection.horizontal,
                            onDismissed: (_) {
                              //remove task from DB
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
                            child: const TaskWidget());
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
                              animate: testing.isEmpty ? false : true,
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
      ),
    );
  }
}
