import 'package:firebase_database/firebase_database.dart';

class Branch {
  String name;
  String address;
  String upiId;
  Map<String, Admin> admin;
  List<Courses> courses;

  Branch({this.name, this.courses, this.address, this.admin, this.upiId});

  Branch.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    address = json['address'];
    upiId = json['upiId'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['upiId'] = this.upiId;
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
  MidAdmin({this.name, this.email, this.tokenid, this.branches, this.district});

  MidAdmin.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    tokenid = json['tokenid'];
    branches = json['branches'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['tokenid'] = this.tokenid;
    data['branches'] = this.branches;
    data['district'] = this.district;
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

  Courses(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.date,
      this.medium,
      this.subjects});

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
    subjects = json['subjects']?.cast<String>();
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
  String name;
  String phoneNo;
  String photoURL;
  String rollNo;
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
      this.classs});

  Student.fromJson(Map<dynamic, dynamic> json) {
    address = json['address'];
    classs = json['class'];
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
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.classs;
    data['address'] = this.address;
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone No'] = this.phoneNo;
    data['photoURL'] = this.photoURL;
    data['rollNo'] = this.rollNo;
    data['status'] = this.status;
    return data;
  }
}

class Course {
  String academicYear;
  String courseID;
  String courseName;
  String paymentToken;

  Course({
    this.academicYear,
    this.courseID,
    this.courseName,
    this.paymentToken,
  });

  Course.fromJson(Map<dynamic, dynamic> json) {
    academicYear = json['Academic Year'];
    courseID = json['courseID'];
    courseName = json['courseName'];
    paymentToken = json['paymentToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Academic Year'] = this.academicYear;
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['paymentToken'] = this.paymentToken;
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
