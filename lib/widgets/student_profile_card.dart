import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../screens/screens.dart';

class StudentProfileCard extends StatelessWidget {
  final Student student;
  const StudentProfileCard({Key? key, required this.student}) : super(key: key);

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
                  child: Image.asset("assets/images/student.png")),
            ),
            const SizedBox(height: 10),
            const Center(child: Text("Student Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
            const Divider(thickness: 1,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name : ${student.name}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  // Text("Roll # : ${student.rollNo}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  // const Divider(thickness: 1,),
                  Text("Reg. # : ${student.regNo}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Session : ${student.session}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Degree : ${student.degree}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Semester : ${student.semester}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  Text("Email : ${student.email}",  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const Divider(thickness: 1,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  StudentEditProfileScreen(student: student,)));
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
