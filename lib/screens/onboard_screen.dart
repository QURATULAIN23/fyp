
import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import '../utils/utils.dart';
import 'screens.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {

  @override
  initState()
  {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.6,
              child: Image.asset("assets/images/logo1.jpg", fit: BoxFit.fill,)
          ),

          Container(
            height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 2.6),
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.grey.shade600,
                gradient: LinearGradient(colors: [
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")],
                    begin: Alignment.topCenter, end: Alignment.bottomCenter)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child:  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Text("Stay Connected", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold, ), textAlign: TextAlign.center,),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const Text("Welcome!", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 10,),
                  const Text("Now it is easier for the students to collaborate with their teachers and easy access to academic content.", style: TextStyle(color: Colors.white, fontSize: 18,),),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () async
                            {

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const StudentLogInScreen()));

                            },
                            child: const Text("Student"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                              foregroundColor: MaterialStateProperty.all(Colors.deepPurple)
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TeacherLogInScreen()));
                            },
                            child: const Text("Teacher"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              foregroundColor: MaterialStateProperty.all(Colors.deepPurple)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
