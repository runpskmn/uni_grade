import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uni_grade/pages/login_page/login_page.dart';
import 'package:uni_grade/services/api.dart';

class RegisterInfoPage extends StatefulWidget {
  static const routeName = '/regInfo';
  const RegisterInfoPage({Key? key}) : super(key: key);

  @override
  _RegisterInfoPageState createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();
  final _userController = TextEditingController();
  final _pwController = TextEditingController();
  final _conpwController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;
  String _stdID = '';
  String _status = 'std';


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    _nameController.text = '${args[0]['firstName']} ${args[0]['lastName']}';
    _emailController.text = args[0]['email'];
    _telController.text = args[0]['phoneNo'];
    _addressController.text = args[0]['address'];


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                        controller: _nameController,
                        enabled: false,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.account_box_rounded,
                              color: Colors.red,
                            ),
                            labelText: 'ชื่อ - นามสกุล',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildRoundedTextField( TextField(
                        controller: _emailController,
                        enabled: false,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.red,
                            ),
                            labelText: 'อีเมล',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildRoundedTextField( TextField(
                        controller: _telController,
                        enabled: false,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.phone_iphone,
                              color: Colors.red,
                            ),
                            labelText: 'เบอร์มือถือ',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildRoundedTextField( TextField(
                        controller: _addressController,
                        enabled: false,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.place,
                              color: Colors.red,
                            ),
                            labelText: 'ที่อยู่',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildRoundedTextField( TextField(
                        controller: _userController,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.red,
                            ),
                            labelText: 'ชื่อผู้ใช้งาน',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildRoundedTextField( TextField(
                        controller: _pwController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            labelText: 'รหัสผ่าน',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      buildRoundedTextField( TextField(
                        controller: _conpwController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            labelText: 'ยืนยันรหัสผ่าน',
                            border: InputBorder.none
                        ),
                      )
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          child: Text("สร้างบัญชี",
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
                              if(_pwController.text == '' && _conpwController.text == ''){
                                _showMaterialDialog("Error", "กรุณากรอกข้อมูลให้ครบถ้วน");
                              }else if(_pwController.text != _conpwController.text){
                                _showMaterialDialog("Error", "รหัสผ่านไม่ตรงกัน");
                              }else{
                                clickRegButton();
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
      ),
    );
  }

  void clickRegButton() async {
    var data = await _register();

    if (data == null) return;

    _showMaterialDialogSuccess("สำเร็จ", 'สร้างบัญชีเรียบร้อยแล้ว');
  }

  Future<List<dynamic>?> _register() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var data = (await Api().submit('register', {
        'stdID': _stdID,
        'username': _userController.text,
        'password' : _pwController.text,
        'status' : _status
        }
      ));
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

  void _showMaterialDialogSuccess(String title, String msg) {
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
                Navigator.pushReplacementNamed(
                  context,
                  LoginPage.routeName,
                );
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
