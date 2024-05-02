import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/tasks/task_screen.dart';

class FAB extends StatelessWidget {
  const FAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => const TaskScreen(
                      titleController: null,
                      descriptionController: null,
                      task: null,
                    )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 10.0,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
