import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';

class StudentModel {
  String uid;
  String address;
  String acaedmicYear;
  String courseName;
  String discount;
  String name;
  String phoneNo;
  String email;
  String photoURL;
  String totalFees;
  String courseID;
  String paymentType;
  bool isinstallmentAllowed;
  List<NoInstallments> listInstallment;
  Map map;
  String lastpaidInstallment;
  String allowedthrough;
  String totalfees;
  StudentModel(
      this.uid,
      this.address,
      this.acaedmicYear,
      this.courseName,
      this.discount,
      this.name,
      this.phoneNo,
      this.email,
      this.photoURL,
      this.courseID,
      this.lastpaidInstallment,
      this.totalfees);

  StudentModel.fromJSON(String key, Map value, Map fineMap, String courseID) {
    uid = key;
    address = value["address"];
    acaedmicYear = value["course"][courseID]["Academic Year"];
    courseName = value["course"][courseID]["courseName"];
    discount = value["course"][courseID]["discount"];
    paymentType = (value["course"][courseID]["paymentType"] == "Online")
        ? "Online"
        : "Offline";
    name = value["name"];
    phoneNo = value["phone No"];
    email = value["email"];
    photoURL = value["photoURL"];
    this.courseID = courseID;
    lastpaidInstallment = value["course"][courseID]["fees"]["Installments"]
        ["LastPaidInstallment"];
    allowedthrough =
        value["course"][courseID]["fees"]["Installments"]["AllowedThrough"];
    totalFees = fineMap["FeeSection"]["TotalFees"];
    map = value["course"][courseID]["fees"]["Installments"];
    isinstallmentAllowed = fineMap["MaxInstallment"]["IsMaxAllowed"];

    listInstallment =
        _createInstallmentmodel(map, [], fineMap, discount, key, courseID);
  }
}

class NoInstallments {
  final String sequence;
  final String amount;
  final String duration;
  final String fine;
  final String status;
  final String paidTime;
  String totalfees;
  NoInstallments(this.sequence, this.amount, this.duration, this.fine,
      this.status, this.paidTime);

  NoInstallments.fromJSON(DataSnapshot snapshot)
      : sequence = snapshot.key,
        amount = snapshot.value["Amount"],
        duration = snapshot.value["Duration"],
        fine = snapshot.value["Fine"],
        status = snapshot.value["Status"],
        paidTime = snapshot.value["PaidTime"];
}

List<NoInstallments> _createInstallmentmodel(
    Map installments,
    List<NoInstallments> _listInstallment,
    Map fineMap,
    String discount,
    String keyS,
    String courseID) {
  double minusValue = 0.0;
  final dbref = FirebaseDatabase.instance;
  DateTime dateTime = DateTime.now();
  int dd = int.parse(dateTime.day.toString().length == 1
      ? "0" + dateTime.day.toString()
      : dateTime.day.toString());
  int mm = int.parse(dateTime.month.toString().length == 1
      ? "0" + dateTime.month.toString()
      : dateTime.month.toString());
  int yyyy = int.parse(dateTime.year.toString());
  double fees = double.parse(fineMap["FeeSection"]["TotalFees"]);

  int count = 0;
  double unpaidSum = 0.0;
  double minusSum = 0.0;
  installments.forEach((key, value) {
    if (key != "AllowedThrough" &&
        key != "LastPaidInstallment" &&
        key != "OneTime") {
      if (value["Status"].toString() != "Paid") {
        count = count + 1;
      } else
        unpaidSum += double.parse(value["Amount"].toString()) -
            double.parse(fineMap["MaxInstallment"]["Installments"][key]
                    ["Amount"]
                .toString());
    }
  });
  if (discount != null && count != 0)
    minusValue = double.parse(
        ((fees * (double.parse(discount == "none" ? "0" : discount) / 100)) /
                count)
            .toStringAsFixed(2));

  if (count != 0) {
    int postivecount = 0;
    minusSum = unpaidSum / count;
    installments.forEach((key, value) {
      if (key != "AllowedThrough" &&
          key != "LastPaidInstallment" &&
          value["Status"] != "Paid") {
        if ((double.parse(
                    fineMap["MaxInstallment"]["Installments"][key]["Amount"]) -
                minusSum) <
            0) postivecount++;
      }
    });
    if (postivecount != 0) minusSum = unpaidSum / postivecount;
  }

  installments.forEach((key, value) {
    if (key != "AllowedThrough" && key != "LastPaidInstallment") {
      if (value["Status"] == "Paid") {
        _listInstallment.add(
          NoInstallments(
            key,
            value["Amount"].toString(),
            value["Duration"].toString(),
            value["Fine"].toString(),
            value["Status"].toString(),
            value["PaidTime"].toString(),
          ),
        );
      } else {
        String status = "Due";
        String fine = "";
        int enddd = int.parse(fineMap["MaxInstallment"]["Installments"][key]
                ["Duration"]
            .toString()
            .split(" ")[0]);
        int endmm = int.parse(fineMap["MaxInstallment"]["Installments"][key]
                ["Duration"]
            .toString()
            .split(" ")[1]);
        int endyyyy = int.parse(fineMap["MaxInstallment"]["Installments"][key]
                ["Duration"]
            .toString()
            .split(" ")[2]);
        if (dd <= enddd && mm <= endmm && yyyy <= endyyyy) {
          status = value["Status"];
          fine = "";
        } else {
          final difference = DateTime(yyyy, mm, dd)
              .difference(DateTime(endyyyy, endmm, enddd))
              .inDays;
          print("Difference is $difference");

          int count = int.parse(
              fineMap["SetFine"]["Duration"].toString().split(" ")[0]);
          String period =
              fineMap["SetFine"]["Duration"].toString().split(" ")[1];

          int durationinDays = period == "Day(s)"
              ? count
              : period == "Month(s)" ? count * 30 : count * 365;

          if (durationinDays != 0) {
            double val = double.parse(((difference / durationinDays).ceil() *
                    double.parse(fineMap["SetFine"]["FineAmount"]))
                .toStringAsFixed(2));
            fine = val.toString();
            if (val != 0.00) {
              status = "Fine";
            }
          }

          dbref
              .reference()
              .child(
                  "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$keyS/course/$courseID/fees/Installments/$key")
              .update({"Fine": fine});
        }
        String amountPass = (double.parse(
                    fineMap["MaxInstallment"]["Installments"][key]["Amount"]) -
                minusValue -
                minusSum)
            .toStringAsFixed(2);
        amountPass = amountPass.contains("-") ? "0.0" : amountPass;

        _listInstallment.add(NoInstallments(key, amountPass, value["Duration"],
            fine, status, value["PaidTime"]));
      }
    }
  });

  _listInstallment.sort((a, b) =>
      int.parse(a.sequence.replaceAll("Installment", ""))
          .compareTo(int.parse(b.sequence.replaceAll("Installment", ""))));
  return _listInstallment;
}
