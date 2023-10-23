import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stayconnected/models/models.dart';
import '../../utils/utils.dart';
import 'package:path/path.dart' as path;

class ManageTimeTableScreen extends StatefulWidget {
  const ManageTimeTableScreen({Key? key,}) : super(key: key);

  @override
  State<ManageTimeTableScreen> createState() => _ManageTimeTableScreenState();
}

class _ManageTimeTableScreenState extends State<ManageTimeTableScreen> {
  final _formKey = GlobalKey<FormState>();
  final degreeState = GlobalKey<FormFieldState>();
  final sessionState = GlobalKey<FormFieldState>();
  final semesterState = GlobalKey<FormFieldState>();

  String? studentId = "";
  String? degree;
  String? session;
  String? semester;
  List<String> degrees = [];
  List<String> sessions = [];
  List<String> semesters = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  List<File>? files = [];
  List names = [];
  String fileNames = "No File Selected";
  List<String?>? urls = [];
  bool uploading = false;


  getDegrees() async
  {
    degrees.clear();
    var data = await FirebaseUtility.getDocuments(collection: "degrees");
    for(int i = 0; i < data.length; i++)
    {
      degrees.add(data[i].get("degree"));
    }
    degrees.sort();
    setState((){});
  }

  getSessions() async
  {
    sessions.clear();
    var data = await FirebaseUtility.getDocuments(collection: "sessions");
    for(int i = 0; i < data.length; i++)
    {
      sessions.add(data[i].get("session"));
    }
    sessions.sort();
    setState((){});
  }

  @override
  initState()
  {
    getDegrees();
    getSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Time Table"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [

                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        key : degreeState ,
                        value:  degree ,
                        items: degrees.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value ),
                          );
                        }).toList(),
                        onChanged: (value) async
                        {
                          setState(() {
                            degree = value;
                          });
                        },
                        isExpanded: true,
                        hint: const Text("Select Degree"),
                        onTap: (){
                          getDegrees();
                        },
                        validator: (value)
                        {
                          if(value == null)
                          {
                            return "Select Degree";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        key : sessionState ,
                        value:  session ,
                        items: sessions.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value ),
                          );
                        }).toList(),
                        onChanged: (value) async
                        {
                          setState(() {
                            session = value;
                          });
                        },
                        isExpanded: true,
                        hint: const Text("Select Session"),
                        onTap: (){
                          getSessions();
                        },
                        validator: (value)
                        {
                          if(value == null)
                          {
                            return "Select Session";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        key : semesterState ,
                        value:  semester ,
                        items: semesters.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) async
                        {
                          setState(() {
                            semester = value;
                          });
                        },
                        isExpanded: true,
                        hint: const Text("Select Semester"),
                        onTap: (){
                          getSessions();
                        },
                        validator: (value)
                        {
                          if(value == null)
                          {
                            return "Select Semester";
                          }
                          return null;
                        },
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  TextButton(
                      onPressed: () async
                      {
                        files =  await Common.pickFiles(allowMultiple: true);

                        if(files!.isNotEmpty)
                        {
                          fileNames = "";
                          for(int i = 0; i< files!.length; i++ )
                          {
                            fileNames += path.basename(files![i].path) +", ";
                            names.add(path.basename(files![i].path));
                          }
                        }
                        setState((){});
                      },
                      child: const Text("Select File")
                  ),
                  const SizedBox(width: 10,),

                ],
              ),
              Text(fileNames),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async
                    {
                      if (_formKey.currentState!.validate()) {
                        getDegrees();
                        getSessions();
                        urls!.clear();
                        urls = await _uploadFiles(files);
                        await _saveData();
                      }
                    },
                    child:  const Text("Save Data")
                ),
              ),
              const SizedBox(height: 15,),
              uploading == true ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: const [
                    Text("Please Wait until files are uploading"),
                    CircularProgressIndicator(),
                  ],
                ),
              ) : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String?>?> _uploadFiles(List<File>? files) async
  {
    if(files!.isNotEmpty)
    {
      setState((){
        uploading = true;
      });
      List<String?> urls = [];
      urls = await Future.wait(files.map((file) => FirebaseUtility.uploadFile(file: file, context: context)));
      if(files.length == urls.length)
      {
        setState((){
          uploading = false;
        });
        Common.showSnackBar("File Uploaded Successfully", context);
        return urls;
      }
    }
    return null;
  }

   _saveData() async
   {
     var content = CourseContent(
       degree: degree,
       session: session,
       semester: semester,
       fileUrls: urls,
       fileNames: names
     );
       var done = await content.saveData(context, "timeTable");
       if(done)
         {
           Common.showSnackBar("Time Table Successfully Saved", context);
         }

   }
}
