import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class TeacherProfileCard extends StatefulWidget {
  final Teacher teacher;
  const TeacherProfileCard({Key? key, required this.teacher}) : super(key: key);

  @override
  State<TeacherProfileCard> createState() => _TeacherProfileCardState();
}

class _TeacherProfileCardState extends State<TeacherProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                  width: 150,
                  child: Image.asset("assets/images/teacher.png")),
            ),
            const SizedBox(height: 10),
            const Center(child: Text("Teacher Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
            const Divider(thickness: 1,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name : ${widget.teacher.name}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Designation : ${widget.teacher.designation}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Mobile : ${widget.teacher.mobile}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Email : ${widget.teacher.email}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  TeacherEditProfileScreen(teacher: widget.teacher,)));
                        setState((){});
                      },
                      child: const Text("Edit Profile"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
