import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/modals/chat_modal.dart';

import '../modals/users_modals.dart';

class Data_Helper {
  Data_Helper._();

  static final data_helper = Data_Helper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  String collection = 'Users';
  String counter = 'user_counter';
  String user_id = 'id';
  String user_name = 'name';
  String user_password = 'password';
  String user_contacts = 'contacts';
  String user_sent_messages = 'sent';
  String user_recieved_messages = 'recieved';

  Stream<DocumentSnapshot> get_all_users({required int id}) {
    return firebaseFirestore
        .collection(collection)
        .doc(id.toString())
        .snapshots();
  }

  get_users_credentials({required int id}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection(collection).doc(id.toString()).get();
    Map userData = snapshot.data() as Map;
    return userData['password'];
  }

  Future<Map<String, dynamic>> get_user_contacts({required int id}) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection(collection).doc(id.toString()).get();
    Map<String, dynamic> contact =
        documentSnapshot.data() as Map<String, dynamic>;
    log("${contact}");
    return contact;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get_user_stream(
      {required int user_id}) {
    return firebaseFirestore
        .collection(collection)
        .doc(user_id.toString())
        .snapshots();
  }

  Future<void>sendMessage(String receiverId,String message)async {
    final String currentuserID = auth.currentUser!.uid;
    final String currentEmail = auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Chat_Modal chat_modal = Chat_Modal(timestamp: timestamp, message: message, receiverId: receiverId, senderEmail: currentEmail, senderId: currentuserID);


    List<String>ids=[currentuserID,receiverId];
    ids.sort();
    String chatroomID=ids.join("_");

    await firebaseFirestore.collection('chat_rooms').doc(chatroomID).collection('messages').add(chat_modal.toMap());
  }

  Stream<QuerySnapshot>getMessages(String userID,String otheruserID){
    List<String>ids=[userID,otheruserID];
    ids.sort();
    String chatroomID=ids.join("_");
    return firebaseFirestore.collection('chat_rooms').doc(chatroomID).collection('messages').orderBy('timestamp',descending: true).snapshots();
  }

  //
  // getChats({required int senderId, required int receiverId}) async {
  //   Map sender = await get_user_contacts(id: senderId);
  //   Map receiver = await get_user_contacts(id: receiverId);
  //
  //   Map sender_chat = sender['sent']['$senderId'];
  //   Map receiver_chat = receiver['received']['$receiverId'];
  //
  //   Map chats = {
  //     'sent': sender_chat,
  //     'received': receiver_chat,
  //   };
  //
  //   return chats;
  // }
  //
  // Future<List> recevied_chats({required receiverId}) async {
  //   DocumentSnapshot documentSnapshot = await firebaseFirestore
  //       .collection(collection)
  //       .doc(receiverId.toString())
  //       .get();
  //
  //   Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //
  //   Map<String, dynamic> data2 = data['received'];
  //
  //   Map<String, dynamic> data3 = data2['101'];
  //
  //   List data4 = data3['message'];
  //
  //   log("${data4}");
  //
  //   return data4;
  // }
  //
  // Future<List> sent_chats({required senderId}) async {
  //   DocumentSnapshot documentSnapshot = await firebaseFirestore
  //       .collection(collection)
  //       .doc(senderId.toString())
  //       .get();
  //
  //   Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //
  //   Map<String, dynamic> data2 = data['sent'];
  //
  //   Map<String, dynamic> data3 = data2['101'];
  //
  //   List data4 = data3['message'];
  //
  //   log("${data4}");
  //
  //   return data4;
  // }
  //
  add_user({required Users_Modals users_modals,required int id}) async {
    Map<String, dynamic> userMap = {
      user_id: "${users_modals.users_id}",
      user_name: "${users_modals.users_name}",
    };
    firebaseFirestore.collection(collection).doc(id.toString()).snapshots();
  }

  //
  // Stream<QuerySnapshot<Map<String, dynamic>>> get_all_user_data() {
  //   return firebaseFirestore.collection(collection).snapshots();
  // }

  // Future<int> getcounter() async {
  //   QuerySnapshot data = await firebaseFirestore.collection(counter).get();
  //
  //   List<QueryDocumentSnapshot> doc = data.docs;
  //
  //   Map<String, dynamic> count = doc[0].data() as Map<String, dynamic>;
  //
  //   int id_count = count['val'];
  //
  //   log("$id_count");
  //
  //   return id_count;
  // }
  //
  // increment_id() async {
  //   int id = await getcounter();
  //
  //   Map<String, dynamic> data = {
  //     'val': ++id,
  //   };
  //
  //   firebaseFirestore.collection(counter).doc('101').set(data);
  // }
}
