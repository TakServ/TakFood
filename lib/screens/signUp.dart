import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:takfood/utility/my_constant.dart';
import 'package:takfood/utility/my_style.dart';
import 'package:takfood/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: [
          myLogo(),
          MyStyle().mySizeBox(),
          showAppName(),
          MyStyle().mySizeBox(),
          nameForm(),
          MyStyle().mySizeBox(),
          userForm(),
          MyStyle().mySizeBox(),
          passwordForm(),
          MyStyle().mySizeBox(),
          MyStyle().showTitleH2('ประเภทสมาชิก'),
          userRadio(),
          shopRadio(),
          riderRadio(),
          MyStyle().mySizeBox(),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250.0,
              child: RaisedButton(
                color: MyStyle().darkColor,
                onPressed: () {
                  print(
                      'name = $name, user = $user, password = $password, chooseType = $chooseType');
                  if (name == null ||
                      name.isEmpty ||
                      user == null ||
                      user.isEmpty ||
                      password == null ||
                      password.isEmpty) {
                    print('Have Space');
                    normalDialog(context, 'กรุณา กรอกข้อมูลให้ครบ');
                  } else if (chooseType == null) {
                    normalDialog(context, 'กรุณาเลือกประเภท ผู้สมัคร');
                  } else {
                    checkUser();
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      );
  Future<Null> checkUser() async {
    // String url =
    //     '${MyConstant().domain}/TakFood/getUserWhereUser.php?isAdd=true&Name=$name&User=$user';
      String url =
        '${MyConstant().domain}/TakFood/getUserWhereUser.php?isAdd=truec&User=$user';    
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(context, 'User : $user มีผู้ใช้แล้ว กรุณาเปลี่ยนชื่อใหม่');
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    String url =
        '${MyConstant().domain}/TakFood/addUser.php?isAdd=true&ChooseType=$chooseType&Name=$name&User=$user&Password=$password';

    try {
      Response response = await Dio().get(url);
      print('res = $response');
      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลงทะเบียนใหม่ คะ');
      }
    } catch (e) {}
  }

  Row userRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 'User',
          groupValue: chooseType,
          onChanged: (value) {
            setState(() {
              chooseType = value;
            });
          },
        ),
        Text(
          'ผู้สั่งอาหาร',
          style: TextStyle(color: MyStyle().darkColor),
        ),
      ],
    );
  }

  Row shopRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 'Shop',
          groupValue: chooseType,
          onChanged: (value) {
            setState(() {
              chooseType = value;
            });
          },
        ),
        Text(
          'ร้านอาหาร',
          style: TextStyle(color: MyStyle().darkColor),
        ),
      ],
    );
  }

  Row riderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 'Rider',
          groupValue: chooseType,
          onChanged: (value) {
            setState(() {
              chooseType = value;
            });
          },
        ),
        Text(
          'ผู้ส่งอาหาร',
          style: TextStyle(color: MyStyle().darkColor),
        ),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'User :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Password :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('Tak Food'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
}
