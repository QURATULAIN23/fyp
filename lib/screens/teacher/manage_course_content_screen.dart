import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'package:path/path.dart' as path;

class ManageCourseContentScreen extends StatefulWidget {
  final String type;
  const ManageCourseContentScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<ManageCourseContentScreen> createState() => _ManageCourseContentScreenState();
}

class _ManageCourseContentScreenState extends State<ManageCourseContentScreen> {
  final _formKey = GlobalKey<FormState>();
  final degreeState = GlobalKey<FormFieldState>();
  final sessionState = GlobalKey<FormFieldState>();
  final semesterState = GlobalKey<FormFieldState>();
  final _courseController = TextEditingController();
  final _serialController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? studentId = "";
  String? degree;
  String? session;
  String? semester;
  String collection = "courseContent";
  List<String> degrees = [];
  List<String> sessions = [];
  List<String> semesters = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th'];
  bool serial = false;
  String fileNames = "No File Selected";
  List names = [];
  List<File>? files = [];
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
    _dateController.text = DateFormat.yMMMd().format(_selectedDate);
    if(widget.type == "Assignment")
    {
      setState((){
        collection = "Assignment";
        serial = true;
      });
    }
    else if(widget.type == "Quiz")
    {
      setState((){
        collection = "Quiz";
        serial = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = "Upload Course Content";
    if(widget.type == "Assignment")
      {
        title = "Upload Assignment";
        collection = "Assignment";
        serial = true;
      }
    else if(widget.type == "Quiz")
      {
        title = "Upload Quiz";
        collection = "Quiz";
        serial = true;
      }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      InputField(
                        controller: _courseController,
                        hintText: "Enter Course Name Here",
                        // labelText: 'Your Address',
                        icon: const Icon(Icons.book),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Enter Course Name";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      serial == true ? Column(
                        children: [
                          InputField(
                            controller: _serialController,
                            hintText: "Enter $collection # Here",
                            icon: const Icon(Icons.collections_bookmark),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d{1,2}?$')),
                            ],
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Enter $collection #";
                              }
                              return null;
                            },
                          ),
                          const Divider(thickness: 1,),
                          InputField(
                            controller: _dateController,
                            readOnly: true,
                            hintText: "Select Submission Date",
                            onTap: ()
                            {
                              Common.selectDate(
                                  context: context,
                                  initialDate: _selectedDate,
                                  selectedDate: (date)
                                  {
                                    setState(() {
                                      _selectedDate = date;
                                      _dateController.text = DateFormat.yMMMd().format(_selectedDate);
                                    });
                                  }
                              );
                            },
                            icon: const Icon(Icons.calendar_month),
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Select Submission Date";
                              }
                              return null;
                            },

                          ),
                        ],
                      ) : const SizedBox(),
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
                      child: const Text("Select File(s)")
                  ),
                  const SizedBox(width: 10,),

                ],
              ),
              Text(fileNames, maxLines: 2,),
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
               child: const Column(
                  children: [
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

          Common.showSnackBar("Files Uploaded Successfully", context);
          return urls;
        }

      }
    return null;
  }

  _saveData() async
  {
      int serial = 0;
      if(_courseController.text != "")
        {
          serial = int.parse(_serialController.text, onError: (e)
          {
            serial = 0;
            return 0;
          });
        }
      var content = CourseContent(
          degree: degree,
          session: session,
          semester: semester,
          course: _courseController.text,
          fileUrls: urls,
          serialNo: serial,
          submissionDate: _selectedDate,
          fileNames: names
      );
      var done = await content.saveData(context, collection);
      if(done)
        {
          Common.showSnackBar("Course Content Sent Successfully", context);
        }
    
  }
}
