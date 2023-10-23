import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ManageNotificationScreen extends StatefulWidget {
  const ManageNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ManageNotificationScreen> createState() => _ManageNotificationScreenState();
}

class _ManageNotificationScreenState extends State<ManageNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Notifications "),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.0),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage("assets/images/teacher.png", ),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10,),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      InputField(
                        controller: _titleController,
                        hintText: "Enter Notification Title Here",
                        // labelText: 'Your Name',
                        icon: const Icon(Icons.title),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Enter Notification Title";
                          }
                          return null;
                        },
                      ),
                      const Divider(thickness: 1,),
                      SizedBox(
                        height: 100,
                        child: InputField(
                          controller: _messageController,
                          hintText: "Enter Notification Message Here",
                          icon: const Icon(Icons.email_outlined),
                          maxLines: 2,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "Enter Notification Message";
                            }
                            return null;
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()
                  {
                    if (_formKey.currentState!.validate()) {
                      _sendNotification();
                    }
                  },
                  child:  const Text("Send Notification"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _sendNotification() async
  {
    var notification = NotificationModel(
      title: _titleController.text,
      message: _messageController.text,
    );
   var done =  await notification.saveData(context);
   if(done) {
      Common.showSnackBar("Notification Sent", context);
    }
  }
}
