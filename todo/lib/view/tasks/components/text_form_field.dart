import 'package:flutter/material.dart';
import 'package:todo/utils/strings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.isDescription = false,
  });

  final TextEditingController controller;
  final bool isDescription;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        maxLines: isDescription ? null : 6,
        cursorHeight: isDescription ? null : 40,
        decoration: InputDecoration(
          hintText: isDescription ? MyString.addNote : null,
          prefixIcon: isDescription ? const Icon(Icons.bookmark_border) : null,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        onFieldSubmitted: (value) {},
        onChanged: (value) {},
      ),
    );
  }
}
