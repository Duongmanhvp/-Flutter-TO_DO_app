import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:todo/utils/strings.dart';
import 'package:todo/view/tasks/components/date_time_picker.dart';
import 'package:todo/view/tasks/components/text_form_field.dart';
import 'package:todo/view/tasks/widgets/task_app_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //delete
                      MaterialButton(
                        color: Colors.white.withOpacity(.9),
                        onPressed: () {},
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
                        onPressed: () {},
                        minWidth: 150,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              MyString.addTaskStr,
                              style: TextStyle(
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
          CustomTextField(controller: titleController),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: descriptionController,
            isDescription: true,
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
                  child: TimePickerWidget(),
                ),
              );
            },
            title: MyString.timeStr,
          ),
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                minDateTime: DateTime.now(),
                maxDateTime: DateTime(2100, 12, 31),
                onConfirm: (dateTime, _) {},
              );
            },
            title: MyString.dateStr,
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
            text: const TextSpan(
              text: "Add New ",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 40.0,
                color: Colors.black,
              ),
              children: [
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
