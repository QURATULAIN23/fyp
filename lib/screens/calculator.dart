import 'package:flutter/material.dart';

import '../tabs/cgpa.dart';
import '../tabs/gpa.dart';

class Calculator extends StatefulWidget {
  createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  Widget build(context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text(
                  'GPA Calculator',
                  style: TextStyle(fontSize: 24),
                ),
                backgroundColor: Colors.deepPurple,
                centerTitle: true,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  indicatorColor: Colors.deepPurple[400],
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.deepPurple[200],
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                  tabs: const [Tab(text: 'GPA'), Tab(text: 'CGPA')],
                ),
              ),
            ];
          },
          body: TabBarView(children: [Gpa(), CGPA()]),
        ),
      ),
    );
  }
}
