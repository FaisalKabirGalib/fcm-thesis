import 'package:flutter/material.dart';

import '/components/color.dart';
import '/components/my_drawer.dart';
import '/screens/blog_screen.dart';
import '/screens/papers_screen.dart';
import '/screens/profile_screen.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  var _selectIndex = 0;

  final List<Widget> _list = [
    const PapersScreen(),
    const BlogScreen(),
    const ProfileScreen(),
  ];

  void _onTaped(int i) {
    setState(() {
      _selectIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // appbar
      appBar: AppBar(
        backgroundColor: CustomColor.BLUEGREY,
      ),

      // drawer
      drawer: const MyDrawer(),

      // bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColor.BLUEGREY,
        selectedItemColor: Colors.green.shade300,
        unselectedItemColor: Colors.white,
        currentIndex: _selectIndex,
        onTap: _onTaped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.web_rounded),
            label: 'Thesis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),

      // body
      body: _list[_selectIndex],

      // floatingActionButton
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: CustomColor.BLUEGREY,
      //   onPressed: () {
      //     Get.to(const SubmissionScreen());
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
