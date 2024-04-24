import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person,
    CupertinoIcons.settings,
    CupertinoIcons.info,
  ];

  final List<String> texts = ["Home", "Profile", "Settings", "Details"];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 70),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/91706477?v=4"),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            "Duong Manh",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const Text(
            "FullStack Software Engineer",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    log("${texts[index]} Tapped !");
                  },
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      title: Text(
                        texts[index],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
