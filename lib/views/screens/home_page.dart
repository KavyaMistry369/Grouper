import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/helpers/login_helper.dart';
import 'package:untitled/modals/users_modals.dart';
import 'package:untitled/utils/routes.dart';
import 'package:untitled/views/screens/chating_page.dart';
import '../../controllers/emoji_controller.dart';
import '../../helpers/data_helper.dart';
import 'package:random_avatar/random_avatar.dart';

class Home_Page extends StatelessWidget {
   Home_Page({super.key});
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    Widget list_user({required DocumentSnapshot document}){
      Map<String,dynamic>data=document.data()! as Map<String,dynamic>;
      if(auth.currentUser!.email!=data['email']){
        return GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => Chat_Page(receiverUserEmail: data['email'], receiverUserID: data['uid']),));
          },
          child: Card(
            child: ListTile(
              title: Text("${data['email']}"),
            ),
          ),
        );
      }
      else{
        return Container();
      }
    }

    TextEditingController id_controller = TextEditingController();
    TextEditingController name_controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Login_Helper.login_helper.sign_out();
          Navigator.of(context).pop();
        }, icon: Icon(Icons.login_outlined)),
        actions: [
          IconButton(onPressed: (){
            Provider.of<Emoji_Controller>(context,listen: false).ChangeTheme();
          }, icon: Icon(Provider.of<Emoji_Controller>(context).isDark?Icons.dark_mode:Icons.sunny,color: Provider.of<Emoji_Controller>(context).isDark?Colors.black:Colors.white,))
        ],
        toolbarHeight: 70,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Home Page",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(padding: EdgeInsets.all(16),child: StreamBuilder(stream: FirebaseFirestore.instance.collection("users").snapshots(), builder:(context, snapshot) {
        if(snapshot.hasError){
          return Text("${snapshot.hasError}");
        }
        if(snapshot.hasData){
          return ListView(
            children: snapshot.data!.docs.map((doc) => list_user(document: doc)).toList(),
          );
        }
        return Center(child: CircularProgressIndicator(color: Colors.deepPurple,),);
      },),),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: "Add user",
            onPressed: () {
              Get.bottomSheet(Container(
                padding: EdgeInsets.all(16),
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add New User",
                        style: GoogleFonts.poppins(
                            color: Colors.deepPurple.shade700, fontSize: 18),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: TextField(
                          controller: id_controller,
                          decoration: InputDecoration(label: Text("Id")),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextField(
                          controller: name_controller,
                          decoration: InputDecoration(label: Text("Name")),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CupertinoButton(
                          color: Colors.deepPurple,
                          child: Text("Done"),
                          onPressed: () {
                            Users_Modals users_modals = Users_Modals(
                                users_id: int.parse(id_controller.text),
                                users_name: name_controller.text);
                            Data_Helper.data_helper
                                .add_user(users_modals: users_modals,id: 101);
                            id_controller.clear();
                            name_controller.clear();
                          })
                    ],
                  ),
                ),
              ));
            },
            child: Icon(Icons.person_add_alt),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
