import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'commons.dart';

class FirebaseUtility {

  static final _auth = FirebaseAuth.instance;
  static void signInWithPhoneAuthCredential(
      {required PhoneAuthCredential phoneAuthCredential,
      required FirebaseAuth auth,
      required BuildContext context,
      required Function() goTo}) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        goTo();
      }
    } on FirebaseAuthException catch (e) {
      Common.showSnackBar(e.message ?? '', context);
    }
  }

  static verifyPhoneNumber(
      {required Function(String) verifyId,
      required String phoneNo,
      required FirebaseAuth auth,
      required BuildContext context}) {
    auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) async {
          Common.showSnackBar(verificationFailed.message ?? '', context);
        },
        codeSent: (verificationId, resendingToken) async {
          verifyId(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }


  static  signInWithEmailPassword({required String email, required String password, required BuildContext context}) async
  {
    try {
      // var user = _auth.currentUser;
      // if (user!.emailVerified) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        Common.showSnackBar('User successfully Sign In', context);
        return userCredential;
      // }
      // else
      // {
      //   Common.showSnackBar('Your Email is not verified. Please verify your email', context);
      //   sendVerificationEmail(email: email, context: context);
      // }
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code == 'user-disabled')
      {
        Common.showSnackBar('Given email has been disabled', context);
      }
      else if(e.code == 'wrong-password')
      {
        Common.showSnackBar('Wrong Password', context);
      }
      else if(e.code == 'invalid-email')
      {
        Common.showSnackBar('Invalid Email', context);
      }
      else if(e.code == 'user-not-found')
      {
        Common.showSnackBar('No Account Registered against this email. Please Sign Up First', context);
      }
      return false;
    }
  }
  static signUpWithEmailPassword({required String email, required String password, required BuildContext context}) async
  {
    try
    {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Common.showSnackBar('User successfully Sign Up', context);
      return userCredential;
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code == 'email-already-in-use')
      {
        Common.showSnackBar('Email Already Registered Please Login', context);
      }
      else if(e.code == 'weak-password')
      {
        Common.showSnackBar('Password is too weak', context);
      }
      else if(e.code == 'invalid-email')
      {
        Common.showSnackBar('Invalid Email', context);
      }
      else if(e.code == 'operation-not-allowed')
      {
        Common.showSnackBar('email/password accounts are not enabled', context);
      }
      return false;
    }
  }

  static sendVerificationEmail({required String? email,required BuildContext context}) async
  {
    var user =  _auth.currentUser;
    if(user != null && user.emailVerified == false)
    {
      await user.sendEmailVerification();
      Common.showSnackBar('A Verification email sent! please check your inbox', context);
    }
  }

  static sendResetPasswordEmail({required String email, required BuildContext context}) async
  {
    try
    {
      await _auth.sendPasswordResetEmail(email: email);
      Common.showSnackBar('Password Reset Email has been sent', context);
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code == 'auth/invalid-email')
      {
        Common.showSnackBar('Invalid Email', context);
      }
      else if(e.code == 'auth/user-not-found')
      {
        Common.showSnackBar('User Not Found', context);
      }

    }
  }


  static Future<bool> add(
      {required Map<String, dynamic> doc,
      required String collectionPath,
      required BuildContext context}) async {
      bool done = false;
      try {
        await FirebaseFirestore.instance.collection(collectionPath).add(doc);
        Common.showSnackBar("Data Successfully Saved", context);
        done = true;
      }
      on FirebaseException catch(ex)
    {
      Common.showSnackBar(ex.message!, context);
      done = false;
    }
    return done;
  }

  static Future<bool>  update(
      {required Map<String, dynamic> doc,
      required String collectionPath,
      required String docId, required BuildContext context}) async {
    bool done = false;
    try {
      await FirebaseFirestore.instance.collection(collectionPath).doc(docId).update(doc);
      Common.showSnackBar("Data Successfully Updated", context);
      done = true;
    }
    on FirebaseException catch(ex)
    {
      Common.showSnackBar(ex.message!, context);
      done = false;
    }
    return done;


  }

  static Future<bool>  delete({required String collectionPath, required String docId,required BuildContext context}) async {
    bool done = false;
    try {
      await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(docId)
          .delete();
      Common.showSnackBar("Data Successfully Delete", context);
      done = true;
    }
    on FirebaseException catch(ex)
    {
      Common.showSnackBar(ex.message!, context);
      done = false;
    }
    return done;

  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshots(
      {required String collectionPath,
      String? query,
      String? field,
      bool shouldExclude = false}) {
    if (query != null && field != null) {
      return shouldExclude
          ? FirebaseFirestore.instance
              .collection(collectionPath)
              .where(field, isNotEqualTo: query)
              .snapshots()
          : FirebaseFirestore.instance
              .collection(collectionPath)
              .where(field, isEqualTo: query)
              .snapshots();
    }
    return FirebaseFirestore.instance.collection(collectionPath).snapshots();
  }

  static Future<String?> uploadFile({required File file, required BuildContext context}) async {
    if (!file.existsSync()) {
      return null;
    }
    String imageUrl = '';
    String fileName = path.basename(file.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    taskSnapshot.state.toString();
    await firebaseStorageRef.getDownloadURL().then((fileUrl) {
      imageUrl = fileUrl;
    });

    return imageUrl;
  }

  static Future<QueryDocumentSnapshot<Map<String, dynamic>>> getOneDoc({required String collection,required String where, required whereValue, String where2 = "", String where2Value = ""}) async
  {
    final data = await FirebaseFirestore.instance.collection(collection).where(where, isEqualTo: whereValue).get();
    return data.docs[0];
  }


  static Future<DocumentSnapshot<Map<String, dynamic>>> getOneDocById({required collection,required String docId,}) async
  {
    final data = await FirebaseFirestore.instance.collection(collection).doc(docId).get();
    return data;
  }

  static Future<int> exists({required String collection ,required String where1, required String where1Value, String? where2, String? where2Value, String? where3, String? where3Value}) async
  {
    final data = await FirebaseFirestore.instance.collection(collection).where(where1, isEqualTo: where1Value).get();
    return data.docs.length;
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getDocuments({required String collection}) async
  {
    final querySnapshot = await FirebaseFirestore.instance.collection(collection).get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    return docs;
  }
}
