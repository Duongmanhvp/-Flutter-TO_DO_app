import 'package:flutter/material.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                ),
              )),
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150);
}
