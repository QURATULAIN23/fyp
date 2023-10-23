import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class StudentCourseContentScreen extends StatefulWidget {
  final String type;
  final Student student;
  const StudentCourseContentScreen({Key? key, required this.student, required this.type}) : super(key: key);

  @override
  State<StudentCourseContentScreen> createState() => _StudentCourseContentScreenState();
}

class _StudentCourseContentScreenState extends State<StudentCourseContentScreen> {
  var content = CourseContent();
  String collection = "courseContent";
  String title = "Course Contents";

  @override
  initState()
  {
    super.initState();
    content = CourseContent(
      degree: widget.student.degree,
      session: widget.student.session,
      semester: widget.student.semester
    );
    if(widget.type == "Assignment")
    {
      setState((){
        collection = "Assignment";
        title = "Assignments";
      });
    }
    else if(widget.type == "Quiz")
    {
      setState((){
        collection = "Quiz";
        title = "Quizzes";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: content.getContentSnapshots(collection: collection),
          builder: (context, snapshot)
          {
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty)
              {
                return const Center(child: Text("No Data Found"),);
              }
            if(snapshot.hasError)
            {
              return const Center(child: Text("Something went wrong"),);
            }
            List<CourseContent> contents = snapshot.data!.docs.map((e) => CourseContent.fromSnapshot(e)).toList();
            return ListView.builder(
                itemCount: contents.length,
                itemBuilder: (context, index)
                    {
                        return ContentCard(content: contents[index], type: collection,);
                    }
            );
          },
        ),
      ),
    );
  }
}
