import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:untitled/controllers/emoji_controller.dart';
import 'package:untitled/utils/routes.dart';
import 'package:untitled/views/screens/chating_page.dart';
import 'package:untitled/views/screens/home_page.dart';
import 'package:untitled/views/screens/login/register_page.dart';
import 'package:untitled/views/screens/login_page.dart';
import 'package:untitled/views/screens/register_page.dart';
import 'package:untitled/views/screens/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
   MultiProvider(providers: [ChangeNotifierProvider(create: (context) => Emoji_Controller(),)],child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Provider.of<Emoji_Controller>(context).isDark? Brightness.light:Brightness.dark,
        colorSchemeSeed: Provider.of<Emoji_Controller>(context).isDark?Colors.deepPurple.shade900:Colors.deepPurple,
        useMaterial3: true,
      ),
      routes: {
        '/':(context) => Splash_Screen(),
        MyRoutes.LR:(context) => Login_Register_Page(),
        MyRoutes.home:(context) => Home_Page(),
        MyRoutes.login:(context) => Login_Page(),
        MyRoutes.register:(context) => Register_Page(),
      },
    );
  }
}

// getPages: [
// //   GetPage(name: "/", page: () => Login_Register_Page()),
// //   GetPage(
// //     name: "/home",
// //     page: () => Home_Page(),
// //   ),
// //   GetPage(
// //     name: "/chat",
// //     page: () => Chat_Page(),
// //   ),
// // ],
