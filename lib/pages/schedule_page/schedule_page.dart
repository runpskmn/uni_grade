import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_grade/models/person_item.dart';
import 'package:uni_grade/models/subject_item.dart';
import 'package:uni_grade/services/api.dart';

class SchedulePage extends StatefulWidget {
  final PersonItem userData;

  const SchedulePage({Key? key, required this.userData}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<String> dayList = ["จันทร์", "อังคาร", "พุธ", "พฤหัสบดี", "ศุกร์", "เสาร์", "อาทิตย์"];
  List<Color> colorList = [Colors.yellow.shade300, Colors.pink.shade300, Colors.green.shade300, Colors.orange.shade300, Colors.blue.shade300, Colors.purple.shade300, Colors.red.shade500];
  late PersonItem ?_userData;
  List<SubjectItem> _subList = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 7,
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
                  for(int i=0;i<_subList.length;++i)
                    if(_subList[i].day == index)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80.0,
                                  child:  Text('${_subList[i].subjectID}'),
                                ),
                                Text('${_subList[i].name}'),
                                Expanded(child: SizedBox.shrink()),
                                Text('${_subList[i].time}')
                              ],
                            ),
                          )
                        ]
                      )
                ],
              ),
            );
          },
        ),
        if(_isLoading)
          SpinKitWave(
            color: Colors.red.withOpacity(0.85),
            size: 40.0,
          )
      ],
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme
              .of(context)
              .textTheme
              .bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    var data = await Api().fetch('reg_subject', queryParams: {
      'year': '2564',
      'term': '1',
      'id': _userData!.id.toString()
    }) as List;

    setState(() {
      for(int i=0;i<data.length;++i) {
        _subList.add(SubjectItem.fromMap(data[i]));
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _userData = widget.userData;
    _getData();
  }
}
