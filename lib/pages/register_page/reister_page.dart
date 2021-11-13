import 'package:flutter/material.dart';
import 'package:uni_grade/pages/register_page/reister_info_page.dart';
import 'package:uni_grade/services/api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "reg";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/images/register/main.jpg'),
                    const Text(
                      "สร้างบัญชี",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    buildRoundedTextField( TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          labelText: "รหัสนักศึกษา/อีเมลสำหรับอาจารย์",
                          border: InputBorder.none
                      ),
                    )
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                        child: Text("ถัดไป",
                            style: TextStyle(fontSize: 16)),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.red),
                            padding:
                            MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(10)),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(
                                Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                        onPressed: () {
                          if(_controller.text != '') {
                            clickSearchButton();
                          }else {
                            _showMaterialDialog("ERROR!", "กรุณากรอกข้อมูล");
                          }
                        }
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
          ),
        ),
      ),
    );
  }

  void clickSearchButton() async {
    var data = await _searchUser();

    if (data == null) return;

    Navigator.pushNamed(
      context,
      RegisterInfoPage.routeName,
      arguments: data,
    );
  }

  Future<List<dynamic>?> _searchUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var data = (await Api().submit('register', {'stdID': _controller.text}));
      return data;
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
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

  Container buildRoundedTextField(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.3),
          borderRadius: BorderRadius.circular(29.0)),
      child: child,
    );
  }
}
