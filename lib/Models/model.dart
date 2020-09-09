import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Branch {
  String name;
  String address;
  String upiId;
  AccountDetails accountDetails;
  String accountId;
  Map<String, Admin> admin;
  Map<String, Student> students;
  Map<String, Teacher> teachers;
  List<Courses> courses;

  Branch(
      {this.name,
      this.courses,
      this.address,
      this.admin,
      this.upiId,
      this.accountDetails,
      this.accountId});

  Branch.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    address = json['address'];
    upiId = json['upiId'];
    accountId = json["accountId"];
    if (json['AccountDetails'] != null) {
      accountDetails = AccountDetails.fromJson(json['AccountDetails']);
    }
    if (json['courses'] != null) {
      courses = new List<Courses>();
      json['courses'].forEach((k, v) {
        courses.add(new Courses.fromJson(v));
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
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    if (this.admin != null) {
      data['admin'] =
          this.admin.map((key, value) => MapEntry(key, value.toJson()));
    }
    return data;
  }
}

class AccountDetails {
  String accountHolderName;
  String accountNo;
  String accountIFSC;

  AccountDetails({
    this.accountHolderName,
    this.accountNo,
    this.accountIFSC,
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
  String name;
  String email;
  String tokenid;
  Admin({this.name, this.email, this.tokenid});

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
  String name;
  String email;
  String tokenid;
  String district;
  String branches;
  String photoUrl;
  MidAdmin(
      {this.name,
      this.email,
      this.tokenid,
      this.branches,
      this.district,
      this.photoUrl});

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
  String id;
  String name;
  String description;
  int price;
  String date;
  String medium;
  Map<String, Subjects> subjects;
  Fees fees;
  TimeTable timeTable;

  Courses(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.date,
      this.medium,
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
        subjects[k] = Subjects.fromJson(v);
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
      data['subjects'] = this.subjects.map((k, v) => MapEntry(k, v.toJson()));
    }
    data['fees'] = this.fees.toJson();
    return data;
  }
}

class TimeTable {
  List<TimeTableClass> monday;
  List<TimeTableClass> tuesday;
  List<TimeTableClass> wednesday;
  List<TimeTableClass> thursday;
  List<TimeTableClass> friday;
  List<TimeTableClass> saturday;

  TimeTable({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  TimeTable.fromJson(Map<dynamic, dynamic> json) {
    monday = List<TimeTableClass>();
    tuesday = List<TimeTableClass>();
    wednesday = List<TimeTableClass>();
    thursday = List<TimeTableClass>();
    friday = List<TimeTableClass>();
    saturday = List<TimeTableClass>();

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
    if (this.monday != null) {
      data['monday'] = this.monday.map((v) => v.toJson()).toList();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday.map((v) => v.toJson()).toList();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday.map((v) => v.toJson()).toList();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday.map((v) => v.toJson()).toList();
    }
    if (this.friday != null) {
      data['friday'] = this.friday.map((v) => v.toJson()).toList();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday.map((v) => v.toJson()).toList();
    }
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
  TimeOfDay startTime;
  TimeOfDay endTime;
  String subjectName;
  String subjectKey;
  String teacherName;
  String teacherKey;
  String classType;
  TimeTableClass(
      {this.subjectKey,
      this.subjectName,
      this.classType,
      this.teacherKey,
      this.teacherName,
      this.startTime,
      this.endTime});
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
  FeeSection feeSection;
  MaxInstallment maxInstallment;
  OneTime oneTime;
  Fine fine;

  Fees({
    this.feeSection,
    this.maxInstallment,
    this.oneTime,
    this.fine,
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
  String maxAllowedInstallment;
  bool isMaxAllowed;
  Map<String, Installment> installment;

  MaxInstallment({
    this.installment,
    this.isMaxAllowed,
    this.maxAllowedInstallment,
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
        this.installment?.map((k, v) => MapEntry(k, v.toJson()));
    return data;
  }
}

class Installment {
  String duration;
  String amount;

  Installment({
    this.duration,
    this.amount,
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
  String duration;
  bool isOneTimeAllowed;

  OneTime({this.duration, this.isOneTimeAllowed});

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
  String duration;
  String fineAmount;
  bool isFineAllowed;
  Fine({
    this.duration,
    this.isFineAllowed,
    this.fineAmount,
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
  String admissionFees;
  String extraFees;
  String labFees;
  String libraryFees;
  String tutionFees;
  String totalFees;

  FeeSection({
    this.totalFees,
    this.tutionFees,
    this.libraryFees,
    this.labFees,
    this.extraFees,
    this.admissionFees,
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
  String name;
  Map<dynamic, dynamic> mentor;
  Map<String, Chapters> chapters;

  Subjects({this.name, this.mentor, this.chapters});

  Subjects.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    mentor = json['mentor'];
    if (json['chapters'] != null) {
      chapters = new Map<String, Chapters>();
      json['chapters']?.forEach((k, v) {
        chapters[k] = Chapters.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mentor'] = this.mentor;
    if (this.chapters != null) {
      data['chapters'] = this.chapters.map((k, v) => MapEntry(k, v.toJson()));
    }
    return data;
  }
}

class Chapters {
  String name;
  String description;
  Map<String, Content> content;

  Chapters({this.name, this.description, this.content});

  Chapters.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['content'] != null) {
      content = new Map<String, Content>();
      json['content'].forEach((k, v) {
        content[k] = Content.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.content != null) {
      data['content'] = this.content.map((k, v) => MapEntry(k, v.toJson()));
    }
    return data;
  }
}

class Content {
  String kind;
  String link;
  String ylink;
  String title;
  String time;
  String description;
  QuizModel quizModel;

  Content(
      {this.ylink,
      this.kind,
      this.link,
      this.title,
      this.time,
      this.description,
      this.quizModel});

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
  List<TCourses> courses;
  String email;
  String name;
  int experience;
  String qualification;
  String photoURL;
  String phoneNo;

  Teacher(
      {this.courses,
      this.email,
      this.name,
      this.experience,
      this.qualification,
      this.phoneNo});

  Teacher.fromJson(Map<dynamic, dynamic> json) {
    if (json['courses'] != null) {
      courses = new List<TCourses>();
      json['courses'].forEach((v) {
        courses.add(new TCourses.fromJson(v));
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
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
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
  String id;
  List<String> subjects;

  TCourses({this.id, this.subjects});

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
  String address;
  List<Course> course;
  String email;
  String classs;
  RequestedCourseFee requestedCourseFee;
  String name;
  String phoneNo;
  String photoURL;
  String rollNo;
  String fatherName;
  String status;

  Student(
      {this.address,
      this.course,
      this.email,
      this.name,
      this.phoneNo,
      this.photoURL,
      this.rollNo,
      this.status,
      this.requestedCourseFee,
      this.fatherName,
      this.classs});

  Student.fromJson(Map<dynamic, dynamic> json) {
    address = json['address'];
    classs = json['class'];
    if (json['requestedCourseFee'] != null) {
      requestedCourseFee =
          RequestedCourseFee.fromJson(json['requestedCourseFee']);
    }
    if (json['course'] != null) {
      course = new List<Course>();
      json['course'].forEach((k, v) {
        course.add(new Course.fromJson(v));
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
    if (this.requestedCourseFee != null) {
      data['requestedCourseFee'] = this.requestedCourseFee.toJson();
    }
    data['address'] = this.address;
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
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
  bool isPaidOneTime;
  List<bool> installments;

  RequestedCourseFee({this.isPaidOneTime, this.installments});

  RequestedCourseFee.fromJson(Map<dynamic, dynamic> json) {
    isPaidOneTime = json['isPaidOneTime'];
    if (json['installments'] != null) {
      installments = List<bool>();
      json['installments'].forEach((v) {
        installments.add(v);
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
  String academicYear;
  String courseID;
  String courseName;
  String paymentToken;
  String paymentType;

  Course({
    this.academicYear,
    this.courseID,
    this.courseName,
    this.paymentToken,
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
  String title;
  String description;
  DateTime startTime;
  Duration testTime;
  List<QuestionModel> questions;

  QuizModel({
    this.title,
    this.description,
    this.questions,
    this.testTime,
    this.startTime,
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
    questions = List<QuestionModel>();
    if (json['questions'] != null) {
      json['questions'].forEach((v) {
        questions.add(new QuestionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['startTime'] = this.startTime.toString();
    data['testTime'] = this.testTime?.toString();
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
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
  String type;
  String question;
  List<String> choices;
  String answer;

  QuestionModel({this.type, this.question, this.choices, this.answer});

  QuestionModel.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    question = json['labelText'];
    answer = json['answer'];
    choices = List<String>();
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
    if (this.choices != null) {
      data['choices'] = this.choices;
    }
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
  String key;
  String textMsg;
  String uid;
  String time;
  Messages(this.key, this.textMsg, this.uid, this.time);

  Messages.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        textMsg = snapshot.value["textMsg"],
        uid = snapshot.value["selfId"],
        time = snapshot.value["time"];
}

class Section {
  String name;
  Map<String, Content> content;
  Section({this.name, this.content});

  Section.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    if (json['content'] != null) {
      content = Map<String, Content>();
      json['content'].forEach((k, v) {
        content[k] = Content.fromJson(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.content != null) {
      data['content'] =
          this.content.map((key, value) => MapEntry(key, value.toJson()));
    }
    return data;
  }
}

class EventsModal {
  String meetingkey;
  String title;
  String description;
  String eventKey;
  String time;
  String courseid;
  String teacheruid;
  String subject;
  int isStarted;
  EventsModal(
      {this.title,
      this.description,
      this.time,
      this.eventKey,
      this.isStarted,
      this.courseid,
      this.teacheruid,
      this.subject});

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
  String meetingkey;
  String title;
  String description;
  String eventKey;
  String time;
  String hostuid;
  String type;
  int isStarted;
  int hostPrevilage;
  String hostname;

  GeneralEventsModal(
      this.meetingkey,
      this.title,
      this.description,
      this.time,
      this.eventKey,
      this.isStarted,
      this.hostuid,
      this.type,
      this.hostPrevilage,
      this.hostname);

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
