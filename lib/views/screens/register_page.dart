import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/helpers/data_helper.dart';
import 'package:untitled/utils/routes.dart';

import '../../helpers/login_helper.dart';

class Register_Page extends StatefulWidget {
  const Register_Page({super.key});

  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  bool ishide = false;

  @override
  void initState() {
    super.initState();
    ishide = true;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController username_controller = TextEditingController();
    TextEditingController password_controller = TextEditingController();
    TextEditingController confirm_password_controller = TextEditingController();

    var psw = "";

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                "Register to chat with your friends",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Image.asset(
                  "lib/views/assets/2.png",
                  width: 350,
                ),
              ),
              Container(
                child: TextField(
                  controller: username_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text("Username"),
                    hintText: "username",
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
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
                      icon: Icon(
                          ishide ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: TextField(
                  obscureText: ishide,
                  controller: confirm_password_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text("Confirm Password"),
                    hintText: "confirm password",
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: ()async{
                  if(password_controller.text!=confirm_password_controller.text){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: CupertinoColors.destructiveRed,
                          content: Text("Password Doesn't Match",style: GoogleFonts.poppins(color: Colors.white),)),
                    );
                  }
                  else{
                    Login_Helper.login_helper.sign_up_with_password_username(email: username_controller.text, password: password_controller.text);
                    Navigator.of(context).pushNamed(MyRoutes.home);
                    username_controller.clear();
                    password_controller.clear();
                    confirm_password_controller.clear();
                  }
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
                      "Register",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
