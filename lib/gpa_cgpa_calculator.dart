import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Gpacgpacalculator extends StatefulWidget {
  const Gpacgpacalculator({Key? key}) : super(key: key);
  @override
  _GpacgpacalculatorState createState() => _GpacgpacalculatorState();
}

class _GpacgpacalculatorState extends State<Gpacgpacalculator> {
  // initial selected value
  String? dropdownvaluemain = '0';
  String? dropdownvaluemainC = '0';

  List<dynamic> dropDown = [];
  List<dynamic> textEdit = [];
  var dropdownvalue4, dropdownvalue1, dropdownvalue2, dropdownvalue3,
      dropdownvalue5, dropdownvalue6, dropdownvalue7, dropdownvalue8,
      dropdownvalue9, dropdownvalue10;

  // list of items in our dropdown menu
  var items = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var itemsSemester = ['0', '1', '2', '3', '4', '5', '6', '7', '8'];
  var marks = ['20', '40', '60', '80', '100'];

  void addGPAVariable() {
    dropdownvaluemain = '0';
    dropDown.add(dropdownvalue4);
    dropDown.add(dropdownvalue1);
    dropDown.add(dropdownvalue2);
    dropDown.add(dropdownvalue3);
    dropDown.add(dropdownvalue5);
    dropDown.add(dropdownvalue6);
    dropDown.add(dropdownvalue7);
    dropDown.add(dropdownvalue8);
    dropDown.add(dropdownvalue9);
    dropDown.add(dropdownvalue10);
  }

  @override
  void initState() {
    addGPAVariable();
    dropdownvaluemainC = '0';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GPA Calculator'),
          bottom: const TabBar(
            tabs: [
              Tab(text: ' GPA'),
              Tab(text: 'CGPA'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                //vertical align
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    //  Horizantal align
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No of subjects: '),
                      DropdownButton(
                        value: dropdownvaluemain,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvaluemain = newValue!;
                            print(dropdownvaluemain);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(20.0),
                        height: 25,
                        width: 85,
                        color: Colors.deepPurple,
                        child: const Text('Subject',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(15.0),
                        height: 25,
                        width: 85,
                        color: Colors.deepPurple,
                        child: const Text(
                            ''
                                'Total Marks',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(15.0),
                        height: 25,
                        width: 85,
                        color: Colors.deepPurple,
                        child: const Text('Obtain Marks',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: int.parse(dropdownvaluemain!),
                      itemBuilder: (BuildContext ctx, int index) {
                        return Row(
                          children: [
                            const SizedBox(width: 35),
                            Text('Subject ${index + 1} '),
                            // Spacer(),
                            const SizedBox(width: 60),
                            DropdownButton(
                              value: dropDown[index],
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: marks.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {
                                setState(() {
                                  dropDown[index] = newValue;
                                  print(dropDown[index]);
                                });
                              },
                            ),
                            // Spacer(),
                            const SizedBox(width: 80),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration.collapsed(
                                    hintText: '00'),
                              ),
                            )
                          ],
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Text("Calculate"),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Text("Clear"),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //   const Center(child: Text('CGPA')),// manage here
            SingleChildScrollView(
              child: Column(
                //vertical align
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    //  Horizontal align
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No of semesters: '),
                      DropdownButton(
                        value: dropdownvaluemainC,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsSemester.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvaluemainC = newValue!;
                            print(dropdownvaluemain);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(20.0),
                        height: 25,
                        width: 85,
                        color: Colors.deepPurple,
                        child: const Text('Semester',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(15.0),
                        height: 25,
                        width: 85,
                        color: Colors.deepPurple,
                        child: const Text(
                            ''
                                'Credit Hours',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(15.0),
                        height: 25,
                        width: 85,
                        color: Colors.deepPurple,
                        child: const Text('Quality Points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            )),
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: int.parse(dropdownvaluemainC!),
                      itemBuilder: (BuildContext ctx, int index) {
                        return Row(
                          children: [
                            const SizedBox(
                              width: 28,
                              height: 45,
                            ),
                            Text('Semester ${index + 1} '),
                            // Spacer(),

                            const SizedBox(
                              width: 70,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration.collapsed(
                                    hintText: '00'),
                              ),
                            ),

                            // Spacer(),
                            const SizedBox(width: 40),
                            const Expanded(
                              child: TextField(
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration:
                                InputDecoration.collapsed(hintText: '0.0'),
                              ),
                            )
                          ],
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 35,
                        width: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          child: const Text("Calculate"),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        width: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          child: const Text("Clear"),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}