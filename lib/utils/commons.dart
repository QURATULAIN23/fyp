import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class Common {
  static showSnackBar(String message, BuildContext context, [Color? color]) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 static Future<List<File>?> pickFiles({required allowMultiple}) async
 {
   FilePickerResult? result = await FilePicker.platform.pickFiles(
     type: FileType.custom,
     allowedExtensions: ['jpg', 'pdf', 'doc'],
       allowMultiple: allowMultiple
   );
   if (result != null) {
     List<File> files = result.paths.map((path) => File(path!)).toList();
     return files;
   } else {
     return null;
   }
 }



  static showAlertDialog({required String title, required String message, required List<Widget> actions ,required BuildContext context}) async
  {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(title),
            content: Text(title),
            actions: actions
        );
      },
    );
  }

  static selectDate({required BuildContext context, required DateTime initialDate, required Function(DateTime) selectedDate}) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (newSelectedDate != null) {
      selectedDate(newSelectedDate);
    }
  }

  static downloadFile({required BuildContext context, required String url, required String fileName, required int index, required Function(double) progressCallBack}) async
  {
    // final temDir = await getTemporaryDirectory();
    // final path = "${temDir.path}/$fileName";
    final path = "/storage/emulated/0/Download/$fileName";
    await Dio().download(
        url,
        path,
        onReceiveProgress: (received, total)
        {
          double progress = received / total;
          progressCallBack(progress);
          if(progress == 1)
            {
              showSnackBar("File Downloaded ", context);
            }
        }
    );

  }


  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}
