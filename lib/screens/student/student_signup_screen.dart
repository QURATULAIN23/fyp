import 'package:flutter/material.dart';
import '../../screens/screens.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({Key? key}) : super(key: key);

  @override
  _StudentSignUpScreenState createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _userNameTextController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registration",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
        body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
        hexStringToColor("9546C4"),
        hexStringToColor("5E61F4")],
        begin: Alignment.topCenter, end: Alignment.bottomCenter)),
         child: SingleChildScrollView(
          child: Padding(
           padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
             child: Column(
               children: <Widget>[
                 SizedBox(
                     width: 180,
                     child: Image.asset("assets/images/user.png")
                 ),
                const SizedBox(
                 height: 20,),
                 reusableTextField(text: "Enter UserName", icon: Icons.person_outline, isPasswordType: false,
                     controller: _userNameTextController),
                 const SizedBox(
                   height: 20,
                 ),
                 reusableTextField(text: "Enter Email Id",icon: Icons.person_outline, isPasswordType:false,
                     controller: _emailTextController),
                 const SizedBox(
                   height: 20,
                 ),
                 reusableTextField(text: "Enter Password", icon: Icons.lock_outlined, isPasswordType: !showPassword,
                     controller: _passwordTextController,
                     suffixIcon: IconButton(
                       onPressed: (){
                         setState((){
                           if(showPassword)
                           {
                             showPassword = false;
                           }
                           else
                           {
                             showPassword = true;
                           }
                         });
                       },
                       icon: showPassword == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                       splashRadius: 20,
                     )
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                 firebaseButton(context, "Sign Up", () async
                 {
                   if(_emailTextController.text.isNotEmpty && _passwordTextController.text.isNotEmpty && _userNameTextController.text.isNotEmpty)
                     {
                       var created = await FirebaseUtility.signUpWithEmailPassword(email: _emailTextController.text, password: _passwordTextController.text, context: context);
                       if(created != null && created != false) {
                         var student = Student(
                             name: _userNameTextController.text,
                             email: _emailTextController.text);
                         var done = await student.saveData(context);
                         if (done) {
                           Common.showSnackBar(
                               "Account Created Successfully", context);
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) => const StudentDashboardScreen()));
                         }
                       }
                     }
                   else
                     {
                       Common.showSnackBar("Please Fill All Fields", context);
                     }
                 })
     ],
    ),
    ))),
    );
  }
}
