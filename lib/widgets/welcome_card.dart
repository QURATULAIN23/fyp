import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String imageUrl;
  final String? username;
  final String bottomLine;
  const WelcomeCard({Key? key, required this.imageUrl, required this.username, required this.bottomLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome back!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  Text(username ?? "", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 20),),
                  const Spacer(),
                  Text(bottomLine, style: const TextStyle(fontSize: 18,),)
                ],
              ),
              SizedBox(
                width: 100,
                child: Image.asset(imageUrl),
              )
            ],
          ),
        ),
      ),
    );
  }
}
