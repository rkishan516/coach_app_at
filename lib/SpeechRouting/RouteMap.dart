import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/languageDialog.dart';
import 'package:coach_app/Dialogs/replaceSubAdmin.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Drawer/my_institute.dart';
import 'package:coach_app/Drawer/privacyNPolicies.dart';
import 'package:coach_app/Events/Calender.dart';
import 'package:coach_app/FeeSection/CouponSection/CouponList.dart';
import 'package:coach_app/FeeSection/FeeReportPages/DueFeeReport.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:coach_app/Meeting/AllMeetingSession.dart';
import 'package:coach_app/Profile/subAdminProfile.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Student/course_page.dart';
import 'package:coach_app/adminCorner/noticeBoard.dart';
import 'package:coach_app/adminSection/studentRequest.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class RouteMap {
  Map<String, WidgetBuilder> createroute() {
    Map<String, WidgetBuilder> map = {
      '/privacy policy': (context) => PrivacyPolicy(),
      '/coupon list': (context) => CouponList(),
      '/my institute': (context) => MyInstitute(),
      '/all courses': (context) => AllCoursePage(
          ref: FirebaseDatabase.instance.ref().child(
              '/institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}')),
      '/my courses': (context) => CoursePage(),
      '/fees section': (context) => CoursePage(
            isFromDrawer: true,
          ),
      '/admin corner': (context) => NoticeBoard(
            totalNotice: GuruCoolDrawerState().totalNotice,
            totalPublicContent: GuruCoolDrawerState().totalPublicContent,
          ),
      '/onetime paid report': (context) => FeeReport(
            type: "OneTime Paid Report",
          ),
      '/paid report': (context) => FeeReport(
            type: "Paid Report",
          ),
      '/fine report': (context) => FeeReport(
            type: "Fine Report",
          ),
      '/discount report': (context) => FeeReport(
            type: "Discount Report",
          ),
      '/payment report': (context) => FeeReport(
            type: "Payment Report",
          ),
      '/due fee report': (context) => FeeReport(
            type: "Due Fee Report",
          ),
      '/student request': (context) => StudentsRequests(),
      '/arrange meeting': (context) => Calender(
            fromCourse: false,
          ),
      '/show meeting': (context) => AllMeetingSession(),
      '/all branches': (context) => BranchList(),
      '/show dialog change language': (context) => LanguageDialog(),
      '/show dialog sub admin profile': (context) => SubAdminProfile(),
      '/show dialog replace sub admin': (context) => ReplaceSubAdmin(),
    };

    return map;
  }
}
