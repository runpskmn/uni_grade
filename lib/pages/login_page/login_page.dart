import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_grade/models/person_item.dart';
import 'package:uni_grade/pages/home_page/home_page.dart';
import 'package:uni_grade/pages/register_page/reister_page.dart';
import 'package:uni_grade/services/api.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _pwController = TextEditingController();
  bool _isLoading = false;
  PersonItem ?_userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/login/main.png'),
                      const Text(
                        "WELCOME TO UNI GRADE",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildRoundedTextField(TextField(
                                controller: _userController,
                                decoration: const InputDecoration(
                                  icon: Icon(
                                      Icons.person,
                                      color: Colors.red,
                                  ),
                                  hintText: "ชื่อผู้ใช้งาน",
                                  border: InputBorder.none
                                ),
                              )
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            buildRoundedTextField(TextField(
                              controller: _pwController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.red,
                                  ),
                                  hintText: "รหัสผ่าน",
                                  border: InputBorder.none
                              ),
                            )
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                                child: Text("เข้าสู่ระบบ".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
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
                                  clickLoginButton();
                                }),
                            Row(children: const [
                              Expanded(child: Divider(thickness: 1.0)),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child:
                                    Text("หรือ", style: TextStyle(fontSize: 14)),
                              ),
                              Expanded(child: Divider(thickness: 1.0)),
                            ]),
                            TextButton(
                                child: Text("สร้างบัญชี".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(10)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.red)))),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RegisterPage.routeName,
                                  );

                                }
                                )
                          ],
                        ),
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
      ),
    );
  }

  void clickLoginButton() async {
    var data = await _checkLoginApi();

    if (data == null) return;

      _userData = PersonItem(id: int.parse(data[0]['stdID']),
          firstName: data[0]['firstName'],
          lastName: data[0]['lastName'],
          email: data[0]['email'],
          phoneNo: data[0]['phoneNo'],
          birthday: data[0]['birthday'],
          status: 'std'
      );

    Navigator.pushNamed(
      context,
      HomePage.routeName,
      arguments: _userData,
    );
  }

  Future<List<dynamic>?> _checkLoginApi() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var data = (await Api().submit('login', {'username': _userController.text, 'password' : _pwController.text}));
      print(data.toString());
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
