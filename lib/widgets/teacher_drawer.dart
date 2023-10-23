import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class TeacherDrawer extends StatelessWidget {
  final Teacher teacher;
  const TeacherDrawer({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
           UserAccountsDrawerHeader(
            accountName: Text(teacher.name ?? ""),
            accountEmail: Text(teacher.email ?? ""),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/teacher.png"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Course Content'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCourseContentScreen(type: "Course Content")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: const Text('Assignment'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCourseContentScreen(type: "Assignment")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Quiz'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCourseContentScreen(type: "Quiz")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Timetable'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageTimeTableScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageNotificationScreen()));
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
