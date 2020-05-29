class Institute {
  String name;
  List<Courses> courses;

  Institute({this.name, this.courses});

  Institute.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    if (json['courses'] != null) {
      courses = new List<Courses>();
      json['courses'].forEach((k,v) {
        courses.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
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
  List<String> batch;
  List<Subjects> subjects;

  Courses(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.date,
      this.medium,
      this.batch,
      this.subjects});

  Courses.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    date = json['date'];
    medium = json['medium'];
    batch = json['batch'].cast<String>();
    if (json['subjects'] != null) {
      subjects = new List<Subjects>();
      json['subjects'].forEach((v) {
        subjects.add(new Subjects.fromJson(v));
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
    data['batch'] = this.batch;
    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String name;
  List<String> mentor;
  List<Chapters> chapters;

  Subjects({this.name, this.mentor, this.chapters});

  Subjects.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    mentor = json['mentor']?.cast<String>();
    if (json['chapters'] != null) {
      chapters = new List<Chapters>();
      json['chapters']?.forEach((v) {
        chapters.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mentor'] = this.mentor;
    if (this.chapters != null) {
      data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  String name;
  String description;
  List<Content> content;

  Chapters({this.name, this.description, this.content});

  Chapters.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String kind;
  String link;
  String yid;
  String title;
  String description;
  QuizModel quizModel;

  Content(
      {this.yid,
      this.kind,
      this.link,
      this.title,
      this.description,
      this.quizModel});

  Content.fromJson(Map<dynamic, dynamic> json) {
    yid = json['yid'];
    kind = json['kind'];
    link = json['link'];
    title = json['title'];
    description = json['description'];
    quizModel = json['quizModel'] != null
        ? QuizModel.fromJson(json['quizModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yid'] = this.yid;
    data['kind'] = this.kind;
    data['link'] = this.link;
    data['title'] = this.title;
    data['description'] = this.description;
    data['quizModel'] = this.quizModel?.toJson();
    return data;
  }
}

class Teacher {
  List<TCourses> courses;
  String email;
  String name;

  Teacher({this.courses, this.email, this.name});

  Teacher.fromJson(Map<dynamic, dynamic> json) {
    if (json['courses'] != null) {
      courses = new List<TCourses>();
      json['courses'].forEach((v) {
        courses.add(new TCourses.fromJson(v));
      });
    }
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}

class TCourses {
  String id;
  List<int> subjects;

  TCourses({this.id, this.subjects});

  TCourses.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    subjects = json['subjects']?.cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjects'] = this.subjects;
    return data;
  }
}

class Student {
  GuardianDetails guardianDetails;
  String address;
  List<Course> course;
  String email;
  String name;
  String phoneNo;
  String photoURL;
  String rollNo;
  String status;

  Student(
      {this.guardianDetails,
      this.address,
      this.course,
      this.email,
      this.name,
      this.phoneNo,
      this.photoURL,
      this.rollNo,this.status});

  Student.fromJson(Map<dynamic, dynamic> json) {
    guardianDetails = json['Guardian Details'] != null
        ? new GuardianDetails.fromJson(json['Guardian Details'])
        : null;
    address = json['address'];
    if (json['course'] != null) {
      course = new List<Course>();
      json['course'].forEach((k,v) {
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
    if (this.guardianDetails != null) {
      data['Guardian Details'] = this.guardianDetails.toJson();
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
    data['status'] = this.status;
    return data;
  }
}

class GuardianDetails {
  String email;
  String name;
  String phoneNo;

  GuardianDetails({this.email, this.name, this.phoneNo});

  GuardianDetails.fromJson(Map<dynamic, dynamic> json) {
    email = json['Email'];
    name = json['Name'];
    phoneNo = json['Phone no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['Name'] = this.name;
    data['Phone no'] = this.phoneNo;
    return data;
  }
}

class Course {
  String academicYear;
  String batch;
  int attendence;
  String courseID;
  String courseName;
  String paymentToken;
  int score;

  Course(
      {this.academicYear,
      this.batch,
      this.attendence,
      this.courseID,
      this.courseName,
      this.paymentToken,
      this.score});

  Course.fromJson(Map<dynamic, dynamic> json) {
    academicYear = json['Academic Year'];
    batch = json['Batch'];
    attendence = json['attendence'];
    courseID = json['courseID'];
    courseName = json['courseName'];
    paymentToken = json['paymentToken'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Academic Year'] = this.academicYear;
    data['Batch'] = this.batch;
    data['attendence'] = this.attendence;
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['paymentToken'] = this.paymentToken;
    data['score'] = this.score;
    return data;
  }
}

class QuizModel {
  String title;
  String description;
  Duration testTime;
  List<QuestionModel> questions;

  QuizModel({this.title, this.description, this.questions, this.testTime});

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
    data['testTime'] = this.testTime?.toString();
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
