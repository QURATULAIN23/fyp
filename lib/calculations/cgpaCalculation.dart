import 'package:rxdart/rxdart.dart';

import '../blocs/cgpaBloc.dart';

class CGPACalculation {
  int numberOfSmesters = 0;
  List<CgpaBloc> smesterList = [];
  int totalCreditHours = 0;
  double totalQualityPoints = 0;
  late double cgpa;

  Stream<bool> get _s0 => smesterList[0].smesterValid;
  Stream<bool> get _s1 => smesterList[1].smesterValid;
  Stream<bool> get _s2 => smesterList[2].smesterValid;
  Stream<bool> get _s3 => smesterList[3].smesterValid;
  Stream<bool> get _s4 => smesterList[4].smesterValid;
  Stream<bool> get _s5 => smesterList[5].smesterValid;
  Stream<bool> get _s6 => smesterList[6].smesterValid;
  Stream<bool> get _s7 => smesterList[7].smesterValid;
  Stream<bool> get _s8 => smesterList[8].smesterValid;
  Stream<bool> get _s9 => smesterList[9].smesterValid;

  String get cgpaValue => (cgpa.toString().length > 6)
      ? cgpa.toString().substring(0, 6)
      : cgpa.toString();

  List<Stream> _getsmesterValidationList() {
    switch (numberOfSmesters) {
      case 1:
        return [_s0];
      case 2:
        return [_s0, _s1];
      case 3:
        return [_s0, _s1, _s2];
      case 4:
        return [_s0, _s1, _s2, _s3];
      case 5:
        return [_s0, _s1, _s2, _s3, _s4];
      case 6:
        return [_s0, _s1, _s2, _s3, _s4, _s5];
      case 7:
        return [_s0, _s1, _s2, _s3, _s4, _s5, _s6];
      case 8:
        return [_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7];
      case 9:
        return [_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7, _s8];
      case 10:
        return [_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7, _s8, _s9];
      default:
        return [];
    }
  }

  Stream<bool> get validSmesters =>
      Rx.combineLatest(_getsmesterValidationList(), (value) => true);
  void setNoOfSmesters(int number) {
    numberOfSmesters = number;
    for (int i = 0; i < number; i++) {
      smesterList.add(new CgpaBloc());
    }
  }

  void calculateCgpa() {
    cgpa = 0;
    totalCreditHours = 0;
    totalQualityPoints = 0;
    for (int i = 0; i < numberOfSmesters; i++) {
      totalCreditHours += smesterList[i].creditHrValue;
      totalQualityPoints += smesterList[i].qualityPtValue;
    }
    cgpa = totalQualityPoints / totalCreditHours;
  }
}
