import 'dart:developer';

class Student {
  String Name;
  String Course;
  int Age;

  Student({required this.Name, required this.Course, required this.Age}) {}

  factory Student.fromMap({required Map data}) {
    log("${data['name']} converted...");

    return Student(
        Name: data["name"], Course: data["course"], Age: data["age"]);
  }
}
