import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class Student extends ChangeNotifier
{
  final String? id;
  final String? name;
  final String? degree;
  final String? regNo;
  final String? semester;
  final String? session;
  final String? rollNo;
  final String? email;
  static final _user = FirebaseAuth.instance.currentUser;
  Student({this.id, this.name, this.degree, this.regNo, this.semester, this.session, this.rollNo, this.email});
  
  factory Student.fromSnapshot(DocumentSnapshot snapshot)
  {
    return Student(
      id: snapshot.id,
      name: snapshot.get("name"),
      degree: snapshot.get("degree"),
      regNo: snapshot.get("regNo"),
      semester: snapshot.get("semester"),
      session: snapshot.get("session"),
      rollNo: snapshot.get("rollNo"),
      email: snapshot.get("email")
    );
  }

  toSnapshot()
  {
    return {
      "name":name,
      "degree": degree,
      "regNo": regNo,
      "semester": semester,
      "session": session,
      "rollNo": rollNo,
      "email" : email
    };
  }

  Future<bool> saveData(BuildContext context) async
  {
    var exist = await FirebaseUtility.exists(collection: "students", where1: "email", where1Value: email ?? "");
    print(exist);
    if(exist == 0)
    {
      print("hello");
      bool done = await FirebaseUtility.add(
          doc: toSnapshot(), collectionPath: "students", context: context);
      notifyListeners();
      return done;
    }
    return false;
  }

  Future<bool> updateData(BuildContext context) async
  {
    var exist = await FirebaseUtility.exists(collection: "students", where1: "email", where1Value: _user!.email!);
    if(exist != 0)
    {
      bool done = await FirebaseUtility.update(doc: toSnapshot(), collectionPath: "students", docId: id!, context: context);
      notifyListeners();
      return done;
    }
    return false;
  }

  Future<bool> deleteData(BuildContext context) async
  {
    bool done = await FirebaseUtility.delete(collectionPath: "students", docId: id!, context: context);
    notifyListeners();
    return done;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStudentSnapshots()
  {
    return FirebaseUtility.getSnapshots(collectionPath: "students");
  }

  Future<Student> getStudentData() async
  {
    var sEmail = _user!.email;
    print(sEmail);
    var data = await FirebaseUtility.getOneDoc(collection: "students", where: "email", whereValue: sEmail);
    notifyListeners();
    return Student.fromSnapshot(data);
  }
  
}