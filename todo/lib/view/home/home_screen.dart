import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:todo/view/home/components/home_app_bar.dart';
import 'package:todo/view/home/components/slider_drawer.dart';
import 'package:todo/view/home/widget/fab.dart';
import 'package:todo/view/home/widget/main_home_screen.dart';
import 'package:todo/view/home/widget/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  final List<int> testing = [];
  @override
  Widget build(BuildContext context) {
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
        child: MainHomeScreen(),
      ),
    );
  }
}
