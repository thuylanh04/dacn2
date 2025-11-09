import 'package:flutter/material.dart';
import 'dart:math';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _usernameErrorText = "Username invalid";
  var _passwordErrorText = "Password must be at least 6 characters";
  var _userInvalid = false;
  var _passwordInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffd8d8d8),
                ),
                child: FlutterLogo(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text(
                "Hello, Welcome back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: TextField(
                controller: _usernameController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Username",
                  errorText: _userInvalid ? _usernameErrorText : null,
                  labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: _passwordInvalid ? _passwordErrorText : null,
                      labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontSize: 15,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: onToggleShowPassword,
                    child: Text(
                      _showPassword ? "HIDE" : "SHOW",
                      style: TextStyle(
                        color: Color(0xff007aff),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff007aff), // ✅ màu nền
                    foregroundColor: Colors.white, // ✅ màu chữ
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // bo góc
                    ),
                  ),
                  onPressed: () {
                    onLoginClicked();
                  },
                  child: Text("Login"),
                ),
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New user? Sign up",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                  Text(
                    "Forgot password ",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onToggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void onLoginClicked() {
    setState(() {
      if (_usernameController.text.isEmpty ||
          !_usernameController.text.contains("@gmail.com")) {
        _userInvalid = true;
      } else {
        _userInvalid = false;
      }

      if (_passwordController.text.length < 6) {
        _passwordInvalid = true;
      } else {
        _passwordInvalid = false;
      }

      if (_userInvalid == false && _passwordInvalid == false) {
        // proceed to login
        // Navigator.push(context, MaterialPageRoute(builder: gotoHome()));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Home()),
        // );
      }
    });
  }

  // Widget gotoHome(BuildContext context) {
  //   return Home();
  // }
}
