import 'package:flutter/material.dart';
import 'package:untitled/views/screens/login_page.dart';
import 'package:untitled/views/screens/register_page.dart';

class Login_Register_Page extends StatelessWidget {
  const Login_Register_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Login_Page(),
          Register_Page(),
        ],
      ),
    );
  }
}
