import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stayconnected/models/models.dart';
import '../utils/utils.dart';

class CourseContent extends ChangeNotifier
{
  final String? id;
  final String? semester;
  final String? degree;
  final String? session;
  final List? fileUrls;
  final List? fileNames;
  final String? course;
  final int? serialNo;
  final DateTime? creationDate;
  final DateTime? submissionDate;


  CourseContent({this.id, this.semester, this.degree, this.session, this.fileUrls, this.fileNames, this.course, this.serialNo, this.creationDate, this.submissionDate});

  factory CourseContent.fromSnapshot(DocumentSnapshot snapshot)
  {
    return CourseContent(
      id: snapshot.id,
      semester: snapshot.get("semester"),
      degree: snapshot.get("degree"),
      session: snapshot.get("session"),
      fileUrls: snapshot.get("fileUrls") ,
      fileNames: snapshot.get("fileNames") ,
      course: snapshot.get("course"),
      serialNo: snapshot.get("serialNo"),
      creationDate: DateTime.fromMillisecondsSinceEpoch(snapshot.get("creationDate")),
      submissionDate: DateTime.fromMillisecondsSinceEpoch(snapshot.get("submissionDate"))
    );
  }

  toSnapshot()
  {
    return {
      "semester": semester,
      "degree": degree,
      "session": session,
      "fileUrls": fileUrls,
      "course": course,
      "serialNo": serialNo,
      "fileNames" : fileNames,
      "creationDate": DateTime.now().millisecondsSinceEpoch,
      "submissionDate": submissionDate?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch
    };
  }

  Future<bool> saveData(BuildContext context, String collection) async
  {
    bool done = await FirebaseUtility.add(doc: toSnapshot(), collectionPath: collection, context: context);
    notifyListeners();
    return done;
  }

  Future<bool> updateData(BuildContext context, String collection) async
  {
      bool done = await FirebaseUtility.update(doc: toSnapshot(), collectionPath: collection, docId: id!, context: context);
      notifyListeners();
      return done;
  }

  Future<bool> deleteData(BuildContext context, String collection) async
  {
    bool done = await FirebaseUtility.delete(collectionPath: collection, docId: id!, context: context);
    notifyListeners();
    return done;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getContentSnapshots({required String collection})
  {
    return FirebaseFirestore.instance.collection(collection).where("degree", isEqualTo: degree,).where("semester", isEqualTo: semester).where("session", isEqualTo: session).snapshots();
  }


  Future<CourseContent?> getContentData({required collection}) async
  {
    var data = await FirebaseFirestore.instance.collection(collection).where("degree", isEqualTo: degree,).where("semester", isEqualTo: semester).where("session", isEqualTo: session).get();
    notifyListeners();
    if(data.size > 0){
      return CourseContent.fromSnapshot(data.docs[0]);
    }
    return  null;
  }

}