import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:iot_project/constaints.dart';
import 'package:iot_project/homeApp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iot_project/pages/dashboardPage.dart';
import 'package:iot_project/pages/httpRequest.dart';
import 'package:iot_project/pages/lockPage.dart';
import 'package:iot_project/pages/usersPage.dart';
import 'package:iot_project/theme/colors.dart';
import 'package:http/http.dart' as http;

final storage = new FlutterSecureStorage();
final authProvider = new AuthenticationProvider();


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
  TextEditingController _email =
  TextEditingController(text: "Username@gmail.com");
  TextEditingController password = TextEditingController(text: "abcdef123456");



  void showPassword() {
    setState(() {
      print('test');
      passwordVisible = !passwordVisible;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        TextField(
                          controller: _email,
                          cursorColor: black,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: black),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              prefixIconColor: black,
                              hintText: "Email",
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        TextField(
                          obscureText: passwordVisible,
                          controller: password,
                          cursorColor: black,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: black),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              prefixIconColor: Colors.black,
                              suffixIcon:
                              IconBadge(
                                icon: Icon(Icons.remove_red_eye_outlined),
                              itemCount: 0,
                              hideZero: true,
                              top: -1,
                              onTap: () => {
                                  showPassword()
                              },
                              ),
                              suffixIconColor: Colors.black,
                              hintText: "Password",
                              border: InputBorder.none),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {

                    authProvider.login(_email.text, password.text).then((value) => {
                      if (value != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeApp(),
                            ))
                      } else {
                        //TODO: when password is wrong
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeApp(),
                            ))
                      }
                    });
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(

                      color:buttoncolor, borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

            ],
          ),
        ));
  }
}