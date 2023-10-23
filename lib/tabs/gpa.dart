import '../blocs/bloc.dart';
import '../calculations/calculations.dart';
import '../fontsColorsETC.dart';
import 'package:flutter/material.dart';
import '../screens/PopUp.dart';
import '../Widgets/listHeader.dart';

int subjectCount = 1;
MyCalculation calculation = MyCalculation();

late bool enableCalculateButton;

class Gpa extends StatefulWidget {
  createState() => _GpaState();
}

class _GpaState extends State<Gpa> with AutomaticKeepAliveClientMixin<Gpa> {
  bool get wantKeepAlive => true;

  @override
  Widget build(context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: (calculation.numberOfSubjects > 0)
                  ? const Text('press clear to enter again')
                  : const Text('No of subjects:  '),
              padding: const EdgeInsets.only(right: 10),
            ),
            myDropDownButton(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        listHeader('Subject', 'Total #', 'Obtain #'),
        Expanded(
            child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.deepPurple,
          ),
          itemCount: calculation.numberOfSubjects,
          addAutomaticKeepAlives: wantKeepAlive,
          cacheExtent: 600,
          itemBuilder: (context, index) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 40,
                  color: Colors.deepPurple[100],
                  child: row(calculation.subjectList[index]),
                  padding: const EdgeInsets.all(4),
                ));
          },
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder(
              stream: calculation.marksListValidation,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: (calculation.numberOfSubjects == 0)
                      ? null
                      : (snapshot.hasData && enableCalculateButton == true)
                          ? () {
                              calculation.calculateSumPer();
                              calculation.calculateGpa();
                              showPopUp(context, _showResult(), "GPA Result");
                            }
                          : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Text('Calculate'),
                );
              }),
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: 0,
          ),
          ElevatedButton(
            child: const Text('Clear'),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
            ),
            onPressed: () {
              setState(() {
                calculation = new MyCalculation();
                calculation.setSubjectNo(0);
                enableCalculateButton = false;
              });
            },
          )
        ])
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _showResult() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _rowForResullt(
              'Credit Hours   :', calculation.creditHours.toString()),
          _rowForResullt(
              'Quality Points :', calculation.qualityPoints.toString()),
          _rowForResullt(
              'Obtain Marks  :', calculation.obtainNumbers.toString()),
          _rowForResullt(
              'Total Marks    :', calculation.totalNumbers.toString()),
          _rowForResullt(' Percentage    :', calculation.percentageStr + " %"),
          _rowForResullt('GPA              :', calculation.gpaStr)
        ],
      ),
    );
  }

  Widget _rowForResullt(String name, String value) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 5, top: 10, right: 5),
        padding: const EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.deepPurple.shade200,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
            border: Border.all(
              width: 3,
              color: listLineColor,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  value,
                  style: TextStyle(
                      fontFamily: numberFont, color: numberColor, fontSize: 15),
                ),
              ],
            )
          ],
        ));
  }

  Widget myDropDownButton() {
    return DropdownButton<int>(
      value: calculation.numberOfSubjects,
      style: TextStyle(fontFamily: numberFont, color: numberColor),
      onChanged: (value) {
        setState(() {
          subjectCount = 1;
          calculation = MyCalculation();
          calculation.setSubjectNo(value!);
        });
      },
      items: (calculation.numberOfSubjects > 0)
          ? null
          : <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
              .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                child: Text(value.toString()),
                value: value,
              );
            }).toList(),
    );
  }

  Widget row(bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Center(child: Text('Subject ${subjectCount++}')),
            width: 100,
            height: 35,
            foregroundDecoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: listLineColor,
                  width: 5,
                ),
              ),
            )),
        Container(
            child: Center(child: dropDownList(bloc)),
            width: 100,
            height: 35,
            foregroundDecoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: listLineColor,
                    width: 5,
                  ),
                  left: BorderSide(
                    color: listLineColor,
                    width: 5,
                  ),
                  right: BorderSide(
                    color: listLineColor,
                    width: 5,
                  )),
            )),
        Container(
            child: Center(child: numberField(bloc)),
            width: 100,
            height: 35,
            foregroundDecoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: listLineColor,
                  width: 5,
                ),
              ),
            ))
      ],
    );
  }

  Widget dropDownList(bloc) {
    return StreamBuilder(
      stream: bloc.totalMarks,
      builder: (context, snapshot) {
        return DropdownButton<int>(
          value: (snapshot.hasData || snapshot.hasError)
              ? snapshot.data as int
              : 100,
          style: TextStyle(fontFamily: numberFont, color: numberColor),
          onChanged: bloc.changeTotalMarks,
          items: <int>[20, 40, 60, 80, 100]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem(
              child: Text(value.toString()),
              value: value,
            );
          }).toList(),
        );
      },
    );
  }

  Widget numberField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.obtainMarks,
      builder: (context, snapshot) {
        return Container(
          width: 50,
          child: Center(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '00',
                hintStyle:
                    const TextStyle(fontFamily: numberFont, color: Colors.grey),
              ),
              onChanged: (value) {
                bloc.changeObtainMarks(value);
                enableCalculateButton = true;
              },
              autofocus: false,
              style: TextStyle(
                  fontFamily: numberFont,
                  color: snapshot.hasError ? Colors.red : numberColor),
              keyboardType: TextInputType.phone,
            ),
          ),
        );
      },
    );
  }
}
