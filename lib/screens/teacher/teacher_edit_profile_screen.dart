import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class TeacherEditProfileScreen extends StatefulWidget {
  final Teacher teacher;
  const TeacherEditProfileScreen({Key? key, required this.teacher,}) : super(key: key);

  @override
  State<TeacherEditProfileScreen> createState() => _TeacherEditProfileScreenState();
}

class _TeacherEditProfileScreenState extends State<TeacherEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _designationController = TextEditingController();
  String? verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  String _teacherId = "";


  @override
  initState()
  {
    super.initState();
    _loadTeacherData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ) ,
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
               const Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage("assets/images/teacher.png", ),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10,),
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
                        // labelText: 'Your Name',
                        icon: const Icon(Icons.person),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Enter Your Name";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      InputField(
                        controller: _designationController,
                        hintText: "Enter Your Designation Here",
                        icon: const Icon(Icons.card_travel_sharp),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Enter Your Designation";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      InputField(
                        controller: _contactController,
                        hintText: "Enter Your Mobile Here",
                        // labelText: 'Your Mobile #',
                        // preText: "+92",
                        icon: const Icon(Icons.phone),
                        keyboardType: TextInputType.phone,
                        validator: (value)
                        {
                          if(value!.isNotEmpty)
                          {
                            if(value.length >= 2){
                              String x = value.substring(0, 2);
                              if(x != "03")
                              {
                                return "Mobile Should be start with 03";
                              }
                            }
                          }

                          if(value.isEmpty)
                          {
                            return "Enter Mobile #";
                          }
                          else if(value.length <= 10 || value.length > 11)
                          {
                            return "Enter Correct Mobile #";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      InputField(
                        controller: _emailController,
                        hintText: "Enter Your Email Here",
                        icon: const Icon(Icons.location_on),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Enter Email Address";
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
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()
                  {
                    if (_formKey.currentState!.validate()) {
                      _saveData();
                    }
                  },
                  child:  const Text("Save Data"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  _loadTeacherData()
  {
    var phone = "";
    if(widget.teacher.mobile != null)
      {
        phone = widget.teacher.mobile!.substring(3,widget.teacher.mobile!.length);
      }
    _nameController.text = widget.teacher.name ?? "";
    _contactController.text = "0$phone";
    _designationController.text = widget.teacher.designation ?? "";
    _emailController.text = widget.teacher.email ?? "";
    setState((){
      _teacherId = widget.teacher.id!;
    });
  }

  _saveData() async
  {
    final phoneNo = "+92${_contactController.text.substring(1, _contactController.text.length)}";
    var teacher = Teacher(
      id: _teacherId,
      name: _nameController.text,
      designation: _designationController.text,
      mobile: phoneNo,
      email: _emailController.text
    );
    var done = await teacher.updateData(context);
    if(done)
      {
        Common.showSnackBar("Profile Update Successfully", context);
      }
  }


  _clear()
  {
    _nameController.clear();
    _contactController.clear();
    _emailController.clear();
    _designationController.clear();
  }


}
