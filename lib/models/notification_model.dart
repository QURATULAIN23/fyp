import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/utils.dart';

class NotificationModel extends ChangeNotifier
{
  final String? id;
  final String? title;
  final String? message;
  final DateTime? dateTime;

  NotificationModel({this.id, this.title, this.message, this.dateTime});
  
  factory NotificationModel.fromSnapshot(DocumentSnapshot snapshot)
  {
    return NotificationModel(
      id: snapshot.id,
      title: snapshot.get("title"),
      message: snapshot.get("message"),
      dateTime: DateTime.fromMillisecondsSinceEpoch(snapshot.get("dateTime"))
    );
  }

  toSnapshot()
  {
    var date = DateTime.now().millisecondsSinceEpoch;
    return
      {
        "title" : title,
        "message" : message,
        "dateTime": date
      };
  }

  Future<bool> saveData(BuildContext context) async
  {
    bool done = await FirebaseUtility.add(doc: toSnapshot(), collectionPath: "notifications", context: context);
    notifyListeners();
    return done;
  }


  Future<bool> deleteData(BuildContext context) async
  {
    bool done = await FirebaseUtility.delete(collectionPath: "notifications", docId: id!, context: context);
    notifyListeners();
    return done;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotificationSnapshots()
  {
    return FirebaseFirestore.instance.collection("notifications").orderBy("dateTime",descending: true).snapshots();
  }
  
}