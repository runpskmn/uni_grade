import 'package:flutter/material.dart';
import 'package:uni_grade/models/person_item.dart';
import 'package:uni_grade/pages/home_page/std_main_page.dart';
import 'package:uni_grade/pages/schedule_page/schedule_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "home";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _subPageIndex = 0;


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PersonItem;
    var pageList = [StudentMainPage(userData: args), SchedulePage(), StudentMainPage(userData: args)];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white.withOpacity(0.25),
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_week_outlined),
            label: 'ตารางเรียน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'ผลการเรียน',
          ),
        ],
        currentIndex: _subPageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height-160,
        color: Colors.white,
        child: SafeArea(
          child: pageList[_subPageIndex]
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _subPageIndex = index;
    });
  }
}
