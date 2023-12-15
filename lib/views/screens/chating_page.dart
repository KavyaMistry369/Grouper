import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled/controllers/emoji_controller.dart';
import 'package:untitled/helpers/data_helper.dart';


class Chat_Page extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const Chat_Page({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {

  TextEditingController message_controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void SendMessages() async {
    if(message_controller.text.isNotEmpty){
      await Data_Helper.data_helper.sendMessage(widget.receiverUserID,message_controller.text);
      message_controller.clear();
    }
  }

  Widget buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic>data=document.data() as Map<String,dynamic>;
    var alignment = (data['senderId']==auth.currentUser!.uid)?Alignment.centerRight:Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: (data['senderId']==auth.currentUser!.uid)?CrossAxisAlignment.end:CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId']==auth.currentUser!.uid)?MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
          color: (data['senderId']==auth.currentUser!.uid)?CupertinoColors.activeBlue:CupertinoColors.systemPurple,
              ),
              child:Column(
                children: [
                  Text(data['senderEmail'],style: GoogleFonts.poppins(),),
                  Text(data['message'],style: GoogleFonts.poppins(),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList(){
    return StreamBuilder(stream: Data_Helper.data_helper.getMessages(widget.receiverUserID, auth.currentUser!.uid), builder: (context, snapshot) {
      if(snapshot.hasError){
        return Text("${snapshot.hasError}");
      }
      if(snapshot.hasData){
        log('message get');
        return ListView(
          children: snapshot.data!.docs.map((document) => buildMessageItem(document)).toList(),
        );;
      }
      return Center(child: CircularProgressIndicator(color: Colors.deepPurple,),);
    },);
  }

  Widget input_message(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            controller: message_controller,
            onTap: (){
              Provider.of<Emoji_Controller>(context,listen: false).OffKeyBoard();
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(onPressed: (){
                FocusManager.instance.primaryFocus!.unfocus();
                Provider.of<Emoji_Controller>(context,listen: false).ChangeKeyBoard();
              }, icon: Icon(Icons.emoji_emotions_outlined)),
              hintText: "message",
              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.image)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
        SizedBox(width: 20,),
        CircleAvatar(radius:20,child: IconButton(onPressed: () {
          SendMessages();
        }, icon: Icon(Icons.send))),
        SizedBox(height: 10,),
        Consumer<Emoji_Controller>(
            builder: (context,pro,_) {
              return Visibility(
                  visible: pro.isKeyboardEnable,
                  child: SizedBox(
                    height: 250,
                    width: 450,
                    child: EmojiPicker(
                      onEmojiSelected: (category,emoji){
                        log("EMOJI : $emoji,$category");
                      },
                      config: Config(
                      ),
                    ),
                  ));
            }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.receiverUserEmail}"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
          ],
        ),
        body: Column(
          children: [
            Expanded(child: buildMessageList()),
            input_message(),
          ],
        ),
      ),
    );
  }
}
