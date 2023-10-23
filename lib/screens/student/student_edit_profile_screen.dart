import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class StudentEditProfileScreen extends StatefulWidget {
  final Student student;
  const StudentEditProfileScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<StudentEditProfileScreen> createState() => _StudentEditProfileScreenState();
}

class _StudentEditProfileScreenState extends State<StudentEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final degreeState = GlobalKey<FormFieldState>();
  final sessionState = GlobalKey<FormFieldState>();
  final semesterState = GlobalKey<FormFieldState>();
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _regController = TextEditingController();
  final _emailController = TextEditingController();
  String? studentId = "";

  String? degree;
  String? session;
  String? semester;
  List<String> degrees = [];
  List<String> sessions = [];
  List<String> semesters = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th'
  ];

  getDegrees() async
  {
    degrees.clear();
    var data = await FirebaseUtility.getDocuments(collection: "degrees");
    for (int i = 0; i < data.length; i++) {
      degrees.add(data[i].get("degree"));
    }
    degrees.sort();
    setState(() {});
  }

  getSessions() async
  {
    sessions.clear();
    var data = await FirebaseUtility.getDocuments(collection: "sessions");
    for (int i = 0; i < data.length; i++) {
      sessions.add(data[i].get("session"));
    }
    sessions.sort();
    setState(() {});
  }

  @override
  initState() {
    getSessions();
    getDegrees();
    _loadData(widget.student);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
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
                      InputField(
                        controller: _nameController,
                        hintText: "Enter Your Name Here",
                        icon: const Icon(Icons.person),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Name";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      // InputField(
                      //   controller: _rollController,
                      //   hintText: "Enter Your Roll # Here",
                      //   icon: const Icon(Icons.credit_card),
                      //   keyboardType: TextInputType.number,
                      //   // inputFormatters: [
                      //   //   FilteringTextInputFormatter.allow(RegExp(r'^\d{1,2}(?:-\d{0,4})?$')),
                      //   // ],
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return "Enter Your Roll # i.e. 18-ARID-2398";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const Divider(thickness: 1,),
                      InputField(
                        controller: _regController,
                        hintText: "Enter Your Reg. # Here",
                        // preText: "+92",
                        icon: const Icon(Icons.how_to_reg),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Reg. #";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        key: degreeState,
                        value: degree,
                        items: degrees.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                        onTap: () {
                          getDegrees();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Select Degree";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        key: sessionState,
                        value: session,
                        items: sessions.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                        onTap: () {
                          getSessions();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Select Session";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        key: semesterState,
                        value: semester,
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
                        onTap: () {
                          getSessions();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Select Semester";
                          }
                          return null;
                        },
                      ),
                      InputField(
                        controller: _emailController,
                        hintText: "Enter Your Email Here ",
                        // labelText: 'Your Address',
                        icon: const Icon(Icons.email),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email Name";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveData();
                        Common.showSnackBar("Data Successfully Saved", context);
                      }
                    },
                    child: const Text("Save Data")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveData() async
  {
    var student = Student(
        id: studentId,
        name: _nameController.text,
        degree: degree,
        session: session,
        semester: semester,
        rollNo: _rollController.text,
        regNo: _regController.text,
        email: _emailController.text
    );
    await student.updateData(context);
  }

  _loadData(Student student) {

    Future.delayed(const Duration(microseconds: 10), () {

      _nameController.text = student.name ?? "";
      _rollController.text = student.rollNo ?? "";
      _regController.text = student.regNo ?? "";
      _emailController.text = student.email ?? "";
      setState(() {
        studentId = student.id;
      });
      degrees.clear();
      sessions.clear();
      sessionState.currentState!.didChange(student.session);
      semesterState.currentState!.didChange(student.semester);
      degreeState.currentState!.didChange(student.degree);
    }
    );
  }
}
