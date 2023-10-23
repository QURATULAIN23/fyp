import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class Teacher extends ChangeNotifier
{
  final String? id;
  final String? name;
  final String? mobile;
  final String? designation;
  final String? email;
  static final _user = FirebaseAuth.instance.currentUser;
  Teacher({this.id, this.name, this.mobile, this.designation, this.email});

  factory Teacher.fromSnapshot(DocumentSnapshot snapshot)
  {
    return Teacher(
      id: snapshot.id,
      name: snapshot.get("name"),
      mobile: snapshot.get("mobile"),
      designation: snapshot.get("designation"),
      email: snapshot.get("email")
    );
  }

  toSnapshot()
  {
    return {
      "name": name,
      "mobile": mobile,
      "designation": designation,
      "email":email
    };
  }

  Future<bool> saveData(BuildContext context) async
  {
    var check = await FirebaseUtility.exists(collection: "teachers", where1: "email", where1Value: email!);
    if(check == 0) {
      bool done = await FirebaseUtility.add(doc: toSnapshot(), collectionPath: "teachers", context: context);
      notifyListeners();
      return done;
    }
    return false;
  }

  Future<bool> updateData(BuildContext context) async
  {
    bool done = await FirebaseUtility.update(doc: toSnapshot(), collectionPath: "teachers", docId: id!, context: context);
    notifyListeners();
    return done;

  }

  Future<bool> deleteData(BuildContext context) async
  {
    bool done = await FirebaseUtility.delete(collectionPath: "teachers", docId: id!, context: context);
    notifyListeners();
    return done;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTeacherSnapshots()
  {
    return FirebaseUtility.getSnapshots(collectionPath: "teachers");
  }

  Future<Teacher> getTeacherData() async
  {
    var data = await FirebaseUtility.getOneDoc(collection: "teachers", where: "email", whereValue: email);
    notifyListeners();
    return Teacher.fromSnapshot(data);
  }


}