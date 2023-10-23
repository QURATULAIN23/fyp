import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stayconnected/models/models.dart';

class StudentNotificationScreen extends StatefulWidget {
  const StudentNotificationScreen({Key? key}) : super(key: key);

  @override
  State<StudentNotificationScreen> createState() => _StudentNotificationScreenState();
}

class _StudentNotificationScreenState extends State<StudentNotificationScreen> {
  var notification = NotificationModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: notification.getNotificationSnapshots(),
          builder: (context, snapshot)
          {
            if(!snapshot.hasData)
              {
                return const CircularProgressIndicator();
              }
            if(snapshot.hasError)
              {
                return const Text("Something Went Wrong");
              }
            List<NotificationModel> notifications = snapshot.data!.docs.map((e) => NotificationModel.fromSnapshot(e)).toList();
            return ListView.builder(
              itemCount: notifications.length,
                itemBuilder: (context, index)
                    {
                      var date = DateFormat("dd-MMM-yyyy hh:mm a").format(notifications[index].dateTime!);
                      return Card(
                        elevation: 8,
                        child: ListTile(
                          title: Text(notifications[index].title ?? ""),
                          // subtitle: Text(notifications[index].message ?? ""),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notifications[index].message ?? ""),
                              Text(date),
                            ],
                          ),
                          // trailing: IconButton(
                          //   onPressed: (){
                          //     // notifications[index].deleteData(context);
                          //   },
                          //   icon: const Icon(Icons.delete, color: Colors.red,),
                          //   splashRadius: 20,
                          // ),
                        ),
                      );
                    }
            );
          },
        ),
      ),
    );
  }
}
