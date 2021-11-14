import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_grade/models/person_item.dart';
import 'package:uni_grade/models/subject_item.dart';
import 'package:uni_grade/services/api.dart';

class StudentMainPage extends StatefulWidget {
  final PersonItem userData;

  const StudentMainPage({Key? key, required this.userData}) : super(key: key);

  @override
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  late PersonItem ?_userData;
  List<SubjectItem> _subList = [];
  int _credit = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 10.0,
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Image.asset(
                            "assets/images/user.png",
                            height: 140,),
                          SizedBox(width: 10.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("นาย ${_userData!.firstName } ${_userData!
                                  .lastName }"),
                              Text("รหัสนักศึกษา ${_userData!.id }",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black54),),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(_subList.length > 0)
                              Text('$_credit', style: TextStyle(fontSize: 24.0)),
                            if(_subList.isEmpty)
                              SpinKitThreeBounce(
                                color: Colors.red.withOpacity(0.85),
                                size: 20.0,
                              ),
                            Text("หน่วยกิตเทอมนี้", style: TextStyle(
                                fontSize: 12.0, color: Colors.black54),),
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(_subList.length > 0)
                              Text('${_subList.length}', style: TextStyle(fontSize: 24.0)),
                            if(_subList.isEmpty)
                              SpinKitThreeBounce(
                                color: Colors.red.withOpacity(0.85),
                                size: 20.0,
                              ),
                            Text("วิชาที่ลง", style: TextStyle(
                                fontSize: 12.0, color: Colors.black54),),
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("2564", style: TextStyle(fontSize: 24.0)),
                            Text("ปีการศึกษา", style: TextStyle(
                                fontSize: 12.0, color: Colors.black54),),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                Expanded(child: SizedBox.shrink()),
                Image.asset("assets/images/news.png", height: 300,),
                Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _getData() async {
      var data = await Api().fetch('reg_subject', queryParams: {
        'year': '2564',
        'term': '1',
        'id': _userData!.id.toString()
      }) as List;

  setState(() {
    for(int i=0;i<data.length;++i) {
      _subList.add(SubjectItem.fromMap(data[i]));
      _credit += _subList[i].credit;
    }
  });
}

@override
void initState() {
  super.initState();
  _userData = widget.userData;
  _getData();
}
}
