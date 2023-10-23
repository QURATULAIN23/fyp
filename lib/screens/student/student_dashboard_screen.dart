import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../../utils/colors_utils.dart';


class StudentDashboardScreen extends StatefulWidget{
  const StudentDashboardScreen ({Key? key}) : super(key: key);

  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State <StudentDashboardScreen> {
  var student = Student();

  @override
  initState()
  {
    super.initState();
    _loadData();
  }

  _loadData() async
  {
    student = await student.getStudentData();
    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentDrawer(student: student,),
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,

        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: student.getStudentData(),
            builder: (context,AsyncSnapshot<Student> snapshot) {
              if(!snapshot.hasData)
              {
                return SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: const Center(child: CircularProgressIndicator(color: Colors.white,)),
                );
              }
              if(snapshot.data != null)
              {
                student = snapshot.data!;
              }
              return Column(
                children:  [
                     WelcomeCard(imageUrl: "assets/images/user.png",username: student.name, bottomLine: "Its time to achieve goals",),
                    StudentProfileCard(student : student),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}