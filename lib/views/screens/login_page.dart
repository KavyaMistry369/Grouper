import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/utils/routes.dart';

import '../../helpers/login_helper.dart';
import '../../modals/user_modals.dart';

class Login_Page extends StatefulWidget {
  Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  bool ishide = false;

  @override
  void initState() {
    super.initState();
    ishide = true;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email_controller = TextEditingController();
    TextEditingController password_controller = TextEditingController();


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Grouper",
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login now to see what they chat",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "lib/views/assets/1.png",
                                width: 360,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: email_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("E-mail"),
                            hintText: "mail",
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          obscureText: ishide,
                          controller: password_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("Password"),
                            hintText: "password",
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: Colors.deepPurple,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ishide = !ishide;
                                });
                              },
                              icon: Icon(ishide
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "OR",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              User_Modal account = (await Login_Helper
                                  .login_helper
                                  .signin_with_google());
                              if (account.mail != "") {
                                Navigator.of(context).pushReplacementNamed(MyRoutes.home,arguments: account);
                              }
                            },
                            child: Image.asset(
                              "lib/views/assets/3.png",
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Login_Helper.login_helper
                              .sign_in_with_password_username(
                                  email: email_controller.text,
                                  password: password_controller.text);
                           Navigator.of(context).pushNamed(MyRoutes.home);
                           email_controller.clear();
                           password_controller.clear();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(50)),
                          height: 50,
                          width: 400,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
