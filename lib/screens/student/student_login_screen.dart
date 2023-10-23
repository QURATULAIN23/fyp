
import 'package:flutter/material.dart';
import '../screens.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class StudentLogInScreen extends StatefulWidget {
  const StudentLogInScreen({Key? key}) : super(key: key);

  @override
  _StudentLogInScreenState createState() => _StudentLogInScreenState();
}

class _StudentLogInScreenState extends State<StudentLogInScreen>{
  final _passwordTextController = TextEditingController();
   final _emailTextController = TextEditingController();
   bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Student Sign In",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 180,
                      child: Image.asset("assets/images/user.png")),
                  const SizedBox(
                    height: 30,
                  ),
                  reusableTextField(text:"Enter Email", icon:Icons.person_outline,isPasswordType :false,
                      controller:_emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(text:"Enter Password", icon:Icons.lock_outline, isPasswordType : !showPassword,
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

                  const SizedBox(
                    height: 7,
                  ),
                  forgetPassword(context),
                  firebaseButton(context, "Sign in", ()async
                  {

                      if (_emailTextController.text.isNotEmpty &&
                          _passwordTextController.text.isNotEmpty) {
                        var res = await FirebaseUtility.signInWithEmailPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                            context: context);

                        if(res != false && res != null)
                          {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StudentDashboardScreen()));
                          }
                      }
                      else {
                        Common.showSnackBar("Please Fill All Fields", context);
                      }

                  }),
                  signUpOption()
                ],
              )
          ),
        ),
      ),
    );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const StudentSignUpScreen()));
    },
        child: const Text(
          " Sign Up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
    )
      ],
    );
  }
  Widget forgetPassword(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
       child: const Text(
        "Forget Password?",
         style: TextStyle(color: Colors.white),
         textAlign: TextAlign.right,
       ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}

