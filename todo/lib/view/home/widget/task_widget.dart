import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/view/tasks/task_screen.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerSubTitle = TextEditingController();

  @override
  void initState() {
    textEditingControllerTitle.text = widget.task.title;
    textEditingControllerSubTitle.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerTitle.dispose();
    textEditingControllerSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskScreen(
              titleController: textEditingControllerTitle,
              descriptionController: textEditingControllerSubTitle,
              task: widget.task,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: widget.task.isCompleted ? Colors.blue[200] : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ],
        ),
        duration: const Duration(microseconds: 600),
        child: ListTile(
          // Check tasks
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: widget.task.isCompleted ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          // Task title
          title: Text(
            textEditingControllerTitle.text,
            style: TextStyle(
              color: widget.task.isCompleted ? Colors.blue : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
              decoration:
                  widget.task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),

          // Describe task
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerSubTitle.text,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w300,
                ),
              ),

              // Date of task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdDate),
                        style: TextStyle(
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdDate),
                        style: TextStyle(
                          color: widget.task.isCompleted
                              ? Colors.white
                              : Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
