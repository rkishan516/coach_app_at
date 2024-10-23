import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Branch {
  late String name;
  late String address;
  late String upiId;
  late AccountDetails accountDetails;
  late String accountId;
  late Map<String, Admin> admin;
  late Map<String, Student> students;
  late Map<String, Teacher> teachers;
  late List<Courses>? courses;

  Branch({
    required this.name,
    required this.courses,
    required this.address,
    required this.admin,
    required this.upiId,
    required this.accountDetails,
    required this.accountId,
  });

  Branch.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    address = json['address'];
    upiId = json['upiId'];
    accountId = json["accountId"];
    if (json['AccountDetails'] != null) {
      accountDetails = AccountDetails.fromJson(json['AccountDetails']);
    }
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((k, v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    if (json['admin'] != null) {
      admin = Map<String, Admin>();
      json['admin'].forEach((k, v) {
        admin[k] = Admin.fromJson(v);
      });
    }
    if (json['students'] != null) {
      students = Map<String, Student>();
      json['students'].forEach((k, v) {
        students[k] = Student.fromJson(v);
      });
    }
    if (json['teachers'] != null) {
      teachers = Map<String, Teacher>();
      json['teachers'].forEach((k, v) {
        teachers[k] = Teacher.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['upiId'] = this.upiId;
    data["accountId"] = this.accountId;
    data['AccountDetails'] = this.accountDetails.toJson();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    data['admin'] =
        this.admin.map((key, value) => MapEntry(key, value.toJson()));
    return data;
  }
}

class AccountDetails {
  late String accountHolderName;
  late String accountNo;
  late String accountIFSC;

  AccountDetails({
    required this.accountHolderName,
    required this.accountNo,
    required this.accountIFSC,
  });

  AccountDetails.fromJson(Map<dynamic, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    accountNo = json['accountNo'];
    accountIFSC = json['accountIFSC'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['accountNo'] = this.accountNo;
    data['accountIFSC'] = this.accountIFSC;
    return data;
  }
}

class Admin {
  late String name;
  late String email;
  String? tokenid;
  Admin({
    required this.name,
    required this.email,
    this.tokenid,
  });

  Admin.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    tokenid = json['tokenid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['tokenid'] = this.tokenid;
    return data;
  }
}

class MidAdmin {
  late String name;
  late String email;
  String? tokenid;
  late String district;
  late String branches;
  String? photoUrl;
  MidAdmin({
    required this.name,
    required this.email,
    this.tokenid,
    required this.branches,
    required this.district,
    this.photoUrl,
  });

  MidAdmin.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    tokenid = json['tokenid'];
    branches = json['branches'];
    district = json['district'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['tokenid'] = this.tokenid;
    data['branches'] = this.branches;
    data['district'] = this.district;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}

class Courses {
  late String id;
  late String name;
  late String description;
  late int price;
  late String date;
  late String medium;
  late Map<String, Subjects>? subjects;
  late Fees? fees;
  late TimeTable? timeTable;

  Courses(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.date,
      required this.medium,
      this.subjects,
      this.fees,
      this.timeTable});

  Courses.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    date = json['date'];
    medium = json['medium'];
    if (json['subjects'] != null) {
      subjects = new Map<String, Subjects>();
      json['subjects'].forEach((k, v) {
        subjects![k] = Subjects.fromJson(v);
      });
    }
    if (json['fees'] != null) {
      fees = Fees.fromJson(json['fees']);
    }
    if (json['TimeTable'] != null) {
      timeTable = TimeTable.fromJson(json['TimeTable']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['date'] = this.date;
    data['medium'] = this.medium;
    if (this.subjects != null) {
      data['subjects'] = this.subjects?.map((k, v) => MapEntry(k, v.toJson()));
    }
    data['fees'] = this.fees?.toJson();
    return data;
  }
}

class TimeTable {
  late List<TimeTableClass> monday;
  late List<TimeTableClass> tuesday;
  late List<TimeTableClass> wednesday;
  late List<TimeTableClass> thursday;
  late List<TimeTableClass> friday;
  late List<TimeTableClass> saturday;

  TimeTable({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  TimeTable.fromJson(Map<dynamic, dynamic> json) {
    monday = <TimeTableClass>[];
    tuesday = <TimeTableClass>[];
    wednesday = <TimeTableClass>[];
    thursday = <TimeTableClass>[];
    friday = <TimeTableClass>[];
    saturday = <TimeTableClass>[];

    if (json['monday'] != null) {
      json['monday'].forEach((v) {
        monday.add(TimeTableClass.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      json['tuesday'].forEach((v) {
        tuesday.add(TimeTableClass.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      json['wednesday'].forEach((v) {
        wednesday.add(TimeTableClass.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      json['thursday'].forEach((v) {
        thursday.add(TimeTableClass.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      json['friday'].forEach((v) {
        friday.add(TimeTableClass.fromJson(v));
      });
    }
    if (json['saturday'] != null) {
      json['saturday'].forEach((v) {
        saturday.add(TimeTableClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monday'] = this.monday.map((v) => v.toJson()).toList();
    data['tuesday'] = this.tuesday.map((v) => v.toJson()).toList();
    data['wednesday'] = this.wednesday.map((v) => v.toJson()).toList();
    data['thursday'] = this.thursday.map((v) => v.toJson()).toList();
    data['friday'] = this.friday.map((v) => v.toJson()).toList();
    data['saturday'] = this.saturday.map((v) => v.toJson()).toList();
    return data;
  }
}

TimeOfDay stringToTod(String val) {
  List<String> hs =
      val.replaceAll("TimeOfDay(", "").replaceAll(")", "").split(":");
  if (hs.length != 2) {
    return TimeOfDay.now();
  }
  return TimeOfDay(hour: int.parse(hs[0]), minute: int.parse(hs[1]));
}

class TimeTableClass {
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late String subjectName;
  late String subjectKey;
  late String teacherName;
  late String teacherKey;
  late String classType;
  TimeTableClass({
    required this.subjectKey,
    required this.subjectName,
    required this.classType,
    required this.teacherKey,
    required this.teacherName,
    required this.startTime,
    required this.endTime,
  });
  TimeTableClass.fromJson(Map<dynamic, dynamic> json) {
    subjectName = json['subjectName'];
    subjectKey = json['subjectKey'];
    teacherName = json['teacherName'];
    teacherKey = json['teacherKey'];
    classType = json['classType'];
    if (json['startTime'] != null) {
      startTime = stringToTod(json['startTime']);
    }
    if (json['endTime'] != null) {
      endTime = stringToTod(json['endTime']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectName'] = subjectName;
    data['subjectKey'] = subjectKey;
    data['teacherName'] = teacherName;
    data['teacherKey'] = teacherKey;
    data['classType'] = classType;
    data['startTime'] = startTime.toString();
    data['endTime'] = endTime.toString();
    return data;
  }
}

class Fees {
  late FeeSection feeSection;
  late MaxInstallment maxInstallment;
  late OneTime oneTime;
  late Fine fine;

  Fees({
    required this.feeSection,
    required this.maxInstallment,
    required this.oneTime,
    required this.fine,
  });

  Fees.fromJson(Map<dynamic, dynamic> json) {
    if (json['FeeSection'] != null) {
      feeSection = FeeSection.fromJson(json['FeeSection']);
    }
    if (json['MaxInstallment'] != null) {
      maxInstallment = MaxInstallment.fromJson(json['MaxInstallment']);
    }
    if (json['OneTime'] != null) {
      oneTime = OneTime.fromJson(json['OneTime']);
    }
    if (json['SetFine'] != null) {
      fine = Fine.fromJson(json['SetFine']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeeSection'] = feeSection.toJson();
    data['MaxInstallment'] = maxInstallment.toJson();
    data['OneTime'] = oneTime.toJson();
    data['SetFine'] = fine.toJson();
    return data;
  }
}

class MaxInstallment {
  late String maxAllowedInstallment;
  late bool isMaxAllowed;
  late Map<String, Installment> installment;

  MaxInstallment({
    required this.installment,
    required this.isMaxAllowed,
    required this.maxAllowedInstallment,
  });

  MaxInstallment.fromJson(Map<dynamic, dynamic> json) {
    maxAllowedInstallment = json['MaxAllowedInstallment'];
    isMaxAllowed = json['IsMaxAllowed'];
    if (json['Installments'] != null) {
      installment = Map<String, Installment>();
      json['Installments'].forEach((k, v) {
        installment[k] = Installment.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaxAllowedInstallment'] = this.maxAllowedInstallment;
    data['IsMaxAllowed'] = this.isMaxAllowed;
    data['Installments'] =
        this.installment.map((k, v) => MapEntry(k, v.toJson()));
    return data;
  }
}

class Installment {
  late String duration;
  late String amount;

  Installment({
    required this.duration,
    required this.amount,
  });

  Installment.fromJson(Map<dynamic, dynamic> json) {
    duration = json['Duration'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Duration'] = this.duration;
    data['Amount'] = this.amount;
    return data;
  }
}

class OneTime {
  late String duration;
  late bool isOneTimeAllowed;

  OneTime({
    required this.duration,
    required this.isOneTimeAllowed,
  });

  OneTime.fromJson(Map<dynamic, dynamic> json) {
    duration = json['Duration'];
    isOneTimeAllowed = json['IsOneTimeAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Duration'] = this.duration;
    data['IsOneTimeAllowed'] = this.isOneTimeAllowed;
    return data;
  }
}

class Fine {
  late String duration;
  late String fineAmount;
  late bool isFineAllowed;
  Fine({
    required this.duration,
    required this.isFineAllowed,
    required this.fineAmount,
  });

  Fine.fromJson(Map<dynamic, dynamic> json) {
    duration = json['Duration'];
    fineAmount = json['FineAmount'];
    isFineAllowed = json['IsFineAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Duration'] = this.duration;
    data['FineAmount'] = this.fineAmount;
    data['IsFineAllowed'] = this.isFineAllowed;
    return data;
  }
}

class FeeSection {
  late String admissionFees;
  late String extraFees;
  late String labFees;
  late String libraryFees;
  late String tutionFees;
  late String totalFees;

  FeeSection({
    required this.totalFees,
    required this.tutionFees,
    required this.libraryFees,
    required this.labFees,
    required this.extraFees,
    required this.admissionFees,
  });

  FeeSection.fromJson(Map<dynamic, dynamic> json) {
    admissionFees = json['AdmissionFees'];
    extraFees = json['ExtraFees'];
    labFees = json['LabFees'];
    libraryFees = json['LibraryFees'];
    tutionFees = json['TutionFees'];
    totalFees = json['TotalFees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdmissionFees'] = this.admissionFees;
    data['ExtraFees'] = this.extraFees;
    data['LabFees'] = this.labFees;
    data['LibraryFees'] = this.libraryFees;
    data['TutionFees'] = this.tutionFees;
    data['TotalFees'] = this.totalFees;
    return data;
  }
}

class Subjects {
  late String name;
  late Map<dynamic, dynamic>? mentor;
  late Map<String, Chapters>? chapters;

  Subjects({required this.name, this.mentor, this.chapters});

  Subjects.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    mentor = json['mentor'];
    if (json['chapters'] != null) {
      chapters = new Map<String, Chapters>();
      json['chapters']?.forEach((k, v) {
        chapters![k] = Chapters.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mentor'] = this.mentor;
    data['chapters'] = this.chapters?.map((k, v) => MapEntry(k, v.toJson()));
    return data;
  }
}

class Chapters {
  late String name;
  late String description;
  late Map<String, Content>? content;

  Chapters({
    required this.name,
    required this.description,
    required this.content,
  });

  Chapters.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['content'] != null) {
      content = new Map<String, Content>();
      json['content'].forEach((k, v) {
        content![k] = Content.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['content'] = this.content?.map((k, v) => MapEntry(k, v.toJson()));
    return data;
  }
}

class Content {
  late String kind;
  late String link;
  late String ylink;
  late String title;
  late String time;
  late String description;
  late QuizModel? quizModel;

  Content({
    required this.ylink,
    required this.kind,
    required this.link,
    required this.title,
    required this.time,
    required this.description,
    required this.quizModel,
  });

  Content.fromJson(Map<dynamic, dynamic> json) {
    ylink = json['ylink'];
    kind = json['kind'];
    link = json['link'];
    title = json['title'];
    time = json['time'];
    description = json['description'];
    quizModel = json['quizModel'] != null
        ? QuizModel.fromJson(json['quizModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ylink'] = this.ylink;
    data['kind'] = this.kind;
    data['link'] = this.link;
    data['title'] = this.title;
    data['description'] = this.description;
    data['time'] = this.time;
    data['quizModel'] = this.quizModel?.toJson();
    return data;
  }
}

class Teacher {
  late List<TCourses>? courses;
  late String email;
  late String name;
  late int experience;
  late String qualification;
  late String photoURL;
  late String phoneNo;

  Teacher({
    required this.courses,
    required this.email,
    required this.name,
    required this.experience,
    required this.qualification,
    required this.phoneNo,
  });

  Teacher.fromJson(Map<dynamic, dynamic> json) {
    if (json['courses'] != null) {
      courses = <TCourses>[];
      json['courses'].forEach((v) {
        courses!.add(new TCourses.fromJson(v));
      });
    }
    experience = json['experience'];
    qualification = json['qualification'];
    email = json['email'];
    name = json['name'];
    photoURL = json['photoUrl'];
    phoneNo = json['phoneNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses'] = this.courses?.map((v) => v.toJson()).toList();
    data['email'] = this.email;
    data['name'] = this.name;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['photoURL'] = this.photoURL;
    data['phoneNo'] = this.phoneNo;
    return data;
  }
}

class TCourses {
  late String id;
  late List<String>? subjects;

  TCourses({
    required this.id,
    required this.subjects,
  });

  TCourses.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    if (json['subjects'] != null)
      subjects = List<String>.from(json['subjects']?.cast<String>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjects'] = this.subjects;
    return data;
  }
}

class Student {
  late String name;
  late String address;
  late String phoneNo;
  late String photoURL;
  late String email;
  late String status;

  late String? classs;
  late RequestedCourseFee? requestedCourseFee;
  late Map<String, Course>? course;
  late String? rollNo;
  late String? fatherName;

  Student({
    required this.address,
    required this.email,
    required this.name,
    required this.phoneNo,
    required this.photoURL,
    required this.status,
    this.requestedCourseFee,
    this.fatherName,
    this.rollNo,
    this.classs,
    this.course,
  });

  Student.fromJson(Map<dynamic, dynamic> json) {
    address = json['address'];
    classs = json['class'];
    if (json['requestedCourseFee'] != null) {
      requestedCourseFee =
          RequestedCourseFee.fromJson(json['requestedCourseFee']);
    }
    if (json['course'] != null) {
      course = new Map<String, Course>();
      json['course'].forEach((k, v) {
        course![k] = new Course.fromJson(v);
      });
    }

    email = json['email'];
    name = json['name'];
    phoneNo = json['phone No'];
    photoURL = json['photoURL'];
    rollNo = json['rollNo'];
    fatherName = json['fatherName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.classs;
    data['requestedCourseFee'] = this.requestedCourseFee?.toJson();
    data['address'] = this.address;
    data['course'] =
        this.course?.map((key, value) => MapEntry(key, value.toJson()));
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone No'] = this.phoneNo;
    data['photoURL'] = this.photoURL;
    data['rollNo'] = this.rollNo;
    data['fatherName'] = this.fatherName;
    data['status'] = this.status;
    return data;
  }
}

class RequestedCourseFee {
  late bool isPaidOneTime;
  late List<bool>? installments;

  RequestedCourseFee({
    required this.isPaidOneTime,
    required this.installments,
  });

  RequestedCourseFee.fromJson(Map<dynamic, dynamic> json) {
    isPaidOneTime = json['isPaidOneTime'];
    if (json['installments'] != null) {
      installments = <bool>[];
      json['installments'].forEach((v) {
        installments!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPaidOneTime'] = this.isPaidOneTime;
    if (this.isPaidOneTime == false) {
      data['installments'] = installments;
    }
    return data;
  }
}

class Course {
  late String academicYear;
  late String courseID;
  late String courseName;
  late String paymentToken;
  String? paymentType;

  Course({
    required this.academicYear,
    required this.courseID,
    required this.courseName,
    required this.paymentToken,
    this.paymentType,
  });

  Course.fromJson(Map<dynamic, dynamic> json) {
    academicYear = json['Academic Year'];
    courseID = json['courseID'];
    courseName = json['courseName'];
    paymentToken = json['paymentToken'];
    paymentType = json['paymentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Academic Year'] = this.academicYear;
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['paymentToken'] = this.paymentToken;
    data['paymentType'] = this.paymentType;
    return data;
  }
}

class QuizModel {
  late String title;
  late String description;
  late DateTime startTime;
  late Duration testTime;
  late List<QuestionModel>? questions;

  QuizModel({
    required this.title,
    required this.description,
    required this.questions,
    required this.testTime,
    required this.startTime,
  });

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  QuizModel.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    description = json['description'];
    testTime = parseDuration(json['testTime']);
    startTime = DateTime.parse(json['startTime'] ?? DateTime.now().toString());
    questions = <QuestionModel>[];
    if (json['questions'] != null) {
      json['questions'].forEach((v) {
        questions!.add(new QuestionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['startTime'] = this.startTime.toString();
    data['testTime'] = this.testTime.toString();
    data['questions'] = this.questions?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Response {
  String uid;
  String name;
  int score;
  Map<String, String> responses;

  Response(this.uid, this.name, this.responses, this.score);
}

class QuestionModel {
  late String type;
  late String question;
  late List<String> choices;
  String? answer;

  QuestionModel({
    required this.type,
    required this.question,
    required this.choices,
    this.answer,
  });

  QuestionModel.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    question = json['labelText'];
    answer = json['answer'];
    choices = <String>[];
    if (json['choices'] != null) {
      json['choices'].forEach((v) {
        choices.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['labelText'] = this.question;
    data['choices'] = this.choices;
    data['answer'] = this.answer;
    return data;
  }
}

class PrivacyModal {
  final String key;
  final String heading;
  final String subtitile;

  PrivacyModal(this.key, this.heading, this.subtitile);
}

class Messages {
  late String key;
  late String textMsg;
  late String uid;
  late String time;
  late String changetime;
  late String type;

  Messages(this.key, this.textMsg, this.uid, this.time, this.type);

  Messages.fromSnapshot(DataSnapshot snapshot) {
    key = snapshot.key!;
    final dataMap = snapshot.value as Map<String, String>;
    textMsg = dataMap["textMsg"]!;
    uid = dataMap["selfId"]!;
    time = dataMap["time"]!;
    changetime = changeTime(time);
    type = dataMap["type"]!;
  }

  String changeTime(String time) {
    String midtime = '';
    int hh = int.parse(time.split(" ")[1].split(":")[0]);
    if (time.split(" ")[2] == "PM") {
      midtime = (hh + 12).toString();
    } else if (time.split(" ")[2] == "AM") {
      if (hh.toString().length == 1)
        midtime = "0" + hh.toString();
      else {
        midtime = hh.toString();
        if (midtime == "12") {
          midtime = "00";
        }
      }
    }
    return time.split(" ")[0] +
        "T" +
        midtime +
        ":" +
        time.split(" ")[1].split(":")[1] +
        ":" +
        time.split(" ")[1].split(":")[2];
  }
}

class Section {
  late String name;
  Map<String, Content>? content;
  Section({required this.name, this.content});

  Section.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    if (json['content'] != null) {
      content = Map<String, Content>();
      json['content'].forEach((k, v) {
        content![k] = Content.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.content != null) {
      data['content'] =
          this.content!.map((key, value) => MapEntry(key, value.toJson()));
    }
    return data;
  }
}

class EventsModal {
  late String meetingkey;
  late String title;
  late String description;
  late String eventKey;
  late String time;
  late String courseid;
  late String teacheruid;
  late String subject;
  late int isStarted;
  EventsModal({
    required this.title,
    required this.description,
    required this.time,
    required this.eventKey,
    required this.isStarted,
    required this.courseid,
    required this.teacheruid,
    required this.subject,
  });

  EventsModal.fromJson(String key, Map<dynamic, dynamic> json) {
    meetingkey = key;
    title = json['title'];
    description = json['description'];
    eventKey = json['eventKey'];
    time = json['time'];
    isStarted = json['isStarted'];
    courseid = json['courseid'];
    subject = json['subject'];
    teacheruid = json['teacheruid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['eventKey'] = this.eventKey;
    data['time'] = this.time;
    data['teacheruid'] = this.teacheruid;
    data['isStarted'] = this.isStarted;
    data['courseid'] = this.courseid;
    data['subject'] = this.subject;

    return data;
  }
}

class GeneralEventsModal {
  late String meetingkey;
  late String title;
  late String description;
  late String eventKey;
  late String time;
  late String hostuid;
  late String type;
  late int isStarted;
  late int hostPrevilage;
  late String hostname;

  GeneralEventsModal({
    required this.meetingkey,
    required this.title,
    required this.description,
    required this.time,
    required this.eventKey,
    required this.isStarted,
    required this.hostuid,
    required this.type,
    required this.hostPrevilage,
    required this.hostname,
  });

  GeneralEventsModal.fromJson(String key, Map<dynamic, dynamic> json) {
    meetingkey = key;
    title = json['title'];
    description = json['description'];
    eventKey = json['eventKey'];
    time = json['time'];
    isStarted = json['isStarted'];
    hostuid = json['hostuid'];
    type = json['type'];
    hostPrevilage = json['hostprevilage'];
    hostname = json['hostname'];
  }
}
