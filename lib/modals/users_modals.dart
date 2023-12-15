import 'dart:developer';

class Users_Modals {
  int users_id;
  String users_name;


  Users_Modals(
      {required this.users_id,
      required this.users_name,
    }) {}

  factory Users_Modals.fromMap({required Map data}) {
    log("${data['name']} converted...");

    return Users_Modals(
        users_id: data['id'],
        users_name: data['name'],);
  }


}
