import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  PageController _pageController = PageController(initialPage: 0);
  List<String> dayList = ["จันทร์", "อังคาร", "พุธ", "พฤหัสบดี", "ศุกร์", "เสาร์", "อาทิตย์"];
  List<Color> colorList = [Colors.yellow.shade300, Colors.pink.shade300, Colors.green.shade300, Colors.orange.shade300, Colors.blue.shade300, Colors.purple.shade300, Colors.red.shade500];


  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 7,
      controller: _pageController,
      onPageChanged: (index){
        print(index);
      },
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            children: [
              TableRow(
                  decoration: BoxDecoration(
                      color: colorList[index],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
                  ),
                  children: [
                    Container(
                        height: 40.0,
                        child: Center(child: Text(dayList[index], style: TextStyle(fontSize: 20.0),))),
                  ]),
            ],
          ),
        );
      },
    );
  }
}
