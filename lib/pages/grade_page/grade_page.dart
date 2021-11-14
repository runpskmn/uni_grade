import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_grade/models/person_item.dart';
import 'package:uni_grade/services/api.dart';

class GradePage extends StatefulWidget {
  final PersonItem userData;

  const GradePage({Key? key, required this.userData}) : super(key: key);

  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  late PersonItem? _userData;
  List _subList = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ภาคการเรียนที่ 1 ปีการศึกษา 2564',
                  textAlign: TextAlign.right,
                ),
              ),
              Table(
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))),
                      children: [
                        Container(
                            height: 40.0,
                            child: Center(
                                child: Text(
                              'ระดับผลการเรียน',
                              style: TextStyle(fontSize: 20.0),
                            ))),
                      ]),
                  for (int i = 0; i < _subList.length; ++i)
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 100.0,
                                    child: Column(
                                      children: [
                                        if(double.parse(_subList[i]['grade']) == 4.00)
                                        Center(
                                            child:
                                              Text(
                                          'A',
                                          style: TextStyle(fontSize: 50.0),
                                        )),
                                        if(double.parse(_subList[i]['grade']) == 3.50)
                                          Center(
                                              child:
                                              Text(
                                                'B+',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                        if(double.parse(_subList[i]['grade']) == 3.00)
                                          Center(
                                              child:
                                              Text(
                                                'B',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                        if(double.parse(_subList[i]['grade']) == 2.50)
                                          Center(
                                              child:
                                              Text(
                                                'C+',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                        if(double.parse(_subList[i]['grade']) == 2.00)
                                          Center(
                                              child:
                                              Text(
                                                'C',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                        if(double.parse(_subList[i]['grade']) == 1.50)
                                          Center(
                                              child:
                                              Text(
                                                'D+',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                        if(double.parse(_subList[i]['grade']) == 1.00)
                                          Center(
                                              child:
                                              Text(
                                                'D',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                        if(double.parse(_subList[i]['grade']) == 0.00)
                                          Center(
                                              child:
                                              Text(
                                                'F',
                                                style: TextStyle(fontSize: 50.0),
                                              )),
                                      ],
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${_subList[i]['subjectID']}"),
                                    Text("${_subList[i]['name']}")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ])
                ],
              ),
            ],
          ),
        ),
        if(_isLoading)
          SpinKitWave(
            color: Colors.red.withOpacity(0.85),
            size: 40.0,
          )
      ],
    );
  }

  void _getData() async {
    setState(() {
      _isLoading = true;
    });
    var data = await Api().fetch('grade', queryParams: {
      'year': '2564',
      'term': '1',
      'id': _userData!.id.toString()
    });

    setState(() {
      _subList = data;
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
