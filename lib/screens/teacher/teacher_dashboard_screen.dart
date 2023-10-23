import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stayconnected/models/models.dart';
import 'package:stayconnected/widgets/teacher_drawer.dart';
import 'package:stayconnected/utils/colors_utils.dart';

import '../../widgets/widgets.dart';


class TeacherDashboardScreen extends StatefulWidget{
  final String email;
  const TeacherDashboardScreen ({Key? key, required this.email}) : super(key: key);

  @override
  _TeacherDashboardScreenState createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State <TeacherDashboardScreen> {
  var teacher = Teacher();
  var content = CourseContent();
  var _user = FirebaseAuth.instance.currentUser;
  @override
  initState()
  {
    super.initState();
    _loadData();
    _user!.reload();
  }

  _loadData() async
  {
    teacher = Teacher(
      email: widget.email
    );
    teacher = await teacher.getTeacherData();
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  TeacherDrawer(teacher: teacher,),
      appBar: AppBar(
        title: const Text('Teacher Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4"),],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter
              )
          ),
          child: FutureBuilder(
            future: teacher.getTeacherData(),
            builder: (context,AsyncSnapshot<Teacher> snapshot) {
              if(!snapshot.hasData)
                {
                  return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                }
              if(snapshot.data != null)
                {
                  teacher = snapshot.data!;
                }
              return Column(
                children:  [
                  WelcomeCard(imageUrl: "assets/images/user.png", username: teacher.name, bottomLine: "Its time to deliver the world",),
                  TeacherProfileCard(teacher: teacher),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}