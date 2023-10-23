
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,),
                    SizedBox(
                        width: 180,
                        child: Image.asset("assets/images/reset.png")
                    ),
                    const SizedBox(
                      height: 20,),
                    reusableTextField(text: "Enter Email Id",icon: Icons.person_outline, isPasswordType:false,
                        controller: _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseButton(context, "Reset Password", (){
                     if(_emailTextController.text.isNotEmpty)
                       {
                         FirebaseUtility.sendResetPasswordEmail(email: _emailTextController.text, context: context);
                       }
                     else
                       {
                         Common.showSnackBar("Please enter register email", context);
                       }
                    })
                  ],
                ),
              ))),
    );
  }
}
