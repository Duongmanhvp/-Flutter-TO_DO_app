import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/utils/strings.dart';
import 'package:todo/view/tasks/components/date_time_picker.dart';
import 'package:todo/view/tasks/components/text_form_field.dart';
import 'package:todo/view/tasks/widgets/task_app_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.task,
  });

  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final Task? task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var title;
  var subTitle;
  DateTime? date;
  DateTime? time;

  String showTime(DateTime? time) {
    if (widget.task?.createdTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a').format(widget.task!.createdTime).toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdDate).toString();
    }
  }

  bool isTaskAlreadyExist() {
    if (widget.titleController?.text == null &&
        widget.descriptionController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskUpdate() {
    if (widget.titleController?.text != null &&
        widget.descriptionController?.text != null) {
      try {
        widget.titleController?.text != title;
        widget.descriptionController?.text != subTitle;

        widget.task?.save();
        Navigator.pop(context);
      } catch (e) {
        onUpdateTask(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title,
          subTitle: subTitle,
          createdTime: time,
          createdDate: date,
        );

        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const TaskAppBar(),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //top
                  _topTask(),

                  // body
                  _bodyTask(context),

                  // bottom
                  // delete current task
                  Row(
                    mainAxisAlignment: isTaskAlreadyExist()
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceAround,
                    children: [
                      //delete
                      isTaskAlreadyExist()
                          ? Container()
                          : MaterialButton(
                              color: Colors.white.withOpacity(.9),
                              onPressed: () {
                                deleteTask();
                                Navigator.pop(context);
                              },
                              minWidth: 150,
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.delete_outline),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    MyString.deleteStr,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      //add
                      MaterialButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          isTaskUpdate();
                        },
                        minWidth: 150,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              isTaskAlreadyExist()
                                  ? MyString.addTaskStr
                                  : MyString.updateTaskStr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _bodyTask(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "What do you mean ?",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          // task tile
          CustomTextField(
            controller: widget.titleController,
            onFieldSubmitted: (String _title) {
              title = _title;
            },
            onChanged: (String _title) {
              title = _title;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          // task subtitle
          CustomTextField(
            controller: widget.descriptionController,
            isDescription: true,
            onFieldSubmitted: (String _subTitle) {
              subTitle = _subTitle;
            },
            onChanged: (String _subTitle) {
              subTitle = _subTitle;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    dateFormat: "HH:mm",
                    onChange: (_, __) {},
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if (widget.task?.createdTime == null) {
                          time = dateTime;
                        } else {
                          widget.task!.createdTime = dateTime;
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: MyString.timeStr,
            time: showTime(time),
            isDate: false,
          ),
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                minDateTime: DateTime.now(),
                maxDateTime: DateTime(2100, 12, 31),
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.task?.createdDate == null) {
                      date = dateTime;
                    } else {
                      widget.task!.createdDate = dateTime;
                    }
                  });
                },
              );
            },
            title: MyString.dateStr,
            time: showDate(date),
          ),
        ],
      ),
    );
  }

  Widget _topTask() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: isTaskAlreadyExist() ? "Add New " : "Update ",
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 40.0,
                color: Colors.black,
              ),
              children: const [
                TextSpan(
                    text: "Task",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
