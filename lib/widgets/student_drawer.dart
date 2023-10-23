import 'package:flutter/material.dart';
import 'package:stayconnected/screens/calculator.dart';
import '../utils/utils.dart';
import '../screens/screens.dart';
import '../models/models.dart';

class StudentDrawer extends StatefulWidget {
  final Student student;
  const StudentDrawer({Key? key,required this.student}) : super(key: key);

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}


class _StudentDrawerState extends State<StudentDrawer> {
  var student = Student();
  var  content = CourseContent();
  double progress = 0;
  
  @override
  initState()
  {
    super.initState();
    student = widget.student;
    _loadData();
  }
  _loadData() async
  {
    student = await student.getStudentData();
    content = CourseContent(
      degree: student.degree,
      session: student.session,
      semester: student.semester
    );
    content = (await content.getContentData(collection: "timeTable"))!;
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
           UserAccountsDrawerHeader(
            accountName: Text(student.name ?? ""),
            accountEmail: Text(student.email ?? ""),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          ),


          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Course Content'),
            onTap: () {
              if(student.rollNo == null || student.session == null || student.semester == null ||student.degree == null)
              {
                Navigator.pop(context);
                Common.showSnackBar("Incomplete Profile! Please Complete Your Profile First", context);
              }
              else
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  StudentCourseContentScreen(type: "courseContent", student: student,)));
              }
              },
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: const Text('Assignment'),
            onTap: (){
              if(student.rollNo == null || student.session == null || student.semester == null ||student.degree == null)
              {
                Navigator.pop(context);
                Common.showSnackBar("Incomplete Profile! Please Complete Your Profile First", context);
              }
              else {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    StudentCourseContentScreen(type: "Assignment", student: student,)));
              }
              },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Quiz'),
            onTap: () {
              if (student.rollNo == null || student.session == null || student.semester == null || student.degree == null)
              {
                Navigator.pop(context);
                Common.showSnackBar("Incomplete Profile! Please Complete Your Profile First",context);
              }
              else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCourseContentScreen( type: "Quiz", student: student,)));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Download Timetable'),
            subtitle: progress > 0 && progress <=1 ? LinearProgressIndicator(
              value: progress,
              color: Colors.deepPurple,
            ) : const SizedBox.shrink()
              ,
            onTap: () async{
              if(content != null)
                {
              await Common.downloadFile(
                context: context,
                  url: content.fileUrls![0],
                  fileName: content.fileNames![0],
                  index: 0,
                  progressCallBack: (value)
                  {
                    setState((){
                      progress = value;
                    });
                  }
              );
              Navigator.pop(context);
              if(progress == 1){
                Common.showSnackBar("File Downloaded", context);
              }
                }
              else
                {
                  Navigator.pop(context);
                  Common.showSnackBar("No Time Table Found", context);
                }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                const StudentNotificationScreen()));
              },
          ),

          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('GPA/CGPA Calculator'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Calculator()));
            },
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const OnboardScreen()));
            },
          ),
          const Spacer(),
          const Text("© 2022 Stay Connected"),
          const SizedBox(height: 15,)


        ],
      ),
    );
  }
}
