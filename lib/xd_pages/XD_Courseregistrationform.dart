import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import './XD_Studentregistrationform.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_Courseregistrationform extends StatelessWidget {
  XD_Courseregistrationform({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(151.0, 59.0),
            child: Text(
              'xyz',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 34,
                color: const Color(0xff434343),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: 360.0,
            height: 250.0,
            decoration: BoxDecoration(
              color: const Color(0xff4a4a4a),
            ),
          ),
          Transform.translate(
            offset: Offset(35.0, 59.0),
            child: Text(
              'CS-601',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 24,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 97.0),
            child: Text(
              'hello there. fnkda lena hai lo nahi to \ntime waste mat karo.hello there.\n fnkda lena hai lo nahi to \ntime waste mat karo.hello there. \nfnkda lena hai lo nahi to \ntime waste mat karo',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 13,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(10.17, 12.0),
            child:
                // Adobe XD layer: 'Icon ionic-md-arrow…' (shape)
                SvgPicture.string(
              _svg_xw90rq,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(46.0, 8.0),
            child: Text(
              'Course Description',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 21,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(15.0, 226.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => XD_Studentregistrationform(),
                ),
              ],
              child: Container(
                width: 330.0,
                height: 63.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xffffa500),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 347.0),
            child: Container(
              width: 360.0,
              height: 201.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(137.0, 246.0),
            child: Text(
              'BUY NOW',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 18,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(1.0, 34.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(-12.0, 335.0),
                  child: SpecificRectClip(
                    rect: Rect.fromLTWH(0, 0, 390, 384),
                    child: UnconstrainedBox(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 378,
                        height: 438,
                        child: GridView.count(
                          primary: false,
                          padding: EdgeInsets.all(0),
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 32,
                          crossAxisCount: 1,
                          childAspectRatio: 1.726,
                          children: [
                            {},
                            {},
                          ].map((map) {
                            return Transform.translate(
                              offset: Offset(12.0, -335.0),
                              child: Stack(
                                children: <Widget>[
                                  Transform.translate(
                                    offset: Offset(4.0, -44.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Transform.translate(
                                          offset: Offset(-4.0, 323.0),
                                          child: Container(
                                            width: 360.0,
                                            height: 201.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      const Color(0x29000000),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 6,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(57.0, 307.0),
            child: Text(
              'ADD TO CART',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 11,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(229.0, 306.0),
            child: Text(
              'ADD TO WISHLIST',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 11,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(18.0, 516.0),
            child: Text(
              'Mentors',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(18.0, 548.0),
            child: Text(
              '.hello there. \n.hello there\n.hi he\n.hehe\n.hehe\n.hehe',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(18.0, 366.0),
            child:
                // Adobe XD layer: 'Icon material-ondem…' (shape)
                SvgPicture.string(
              _svg_rtzjyr,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(13.0, 315.0),
            child: Text(
              'This Course Includes',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(73.0, 366.0),
            child: Text(
              '24 total hours on-demand video',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(81.0, 413.0),
            child: Text(
              'Quizzes',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(73.0, 470.0),
            child: Text(
              'Lifetime access',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_xw90rq =
    '<svg viewBox="10.2 12.0 20.0 20.0" ><path transform="translate(4.19, 6.02)" d="M 25.98974418640137 14.73233032226563 L 10.79236602783203 14.73233032226563 L 17.79709625244141 7.727598667144775 L 15.983154296875 5.976562976837158 L 5.976562976837158 15.983154296875 L 15.983154296875 25.98974418640137 L 17.734130859375 24.23864936828613 L 10.79236602783203 17.23397827148438 L 25.98974418640137 17.23397827148438 L 25.98974418640137 14.73233032226563 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rtzjyr =
    '<svg viewBox="18.0 366.0 38.0 122.5" ><path transform="translate(20.5, 361.5)" d="M 31.5 4.5 L 4.5 4.5 C 2.835000038146973 4.5 1.5 5.835000038146973 1.5 7.5 L 1.5 25.5 C 1.5 27.14999961853027 2.835000038146973 28.5 4.5 28.5 L 12 28.5 L 12 31.5 L 24 31.5 L 24 28.5 L 31.5 28.5 C 33.15000152587891 28.5 34.48500061035156 27.14999961853027 34.48500061035156 25.5 L 34.5 7.5 C 34.5 5.835000038146973 33.15000152587891 4.5 31.5 4.5 Z M 31.5 25.5 L 4.5 25.5 L 4.5 7.5 L 31.5 7.5 L 31.5 25.5 Z M 24 16.5 L 13.5 22.5 L 13.5 10.5 L 24 16.5 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(22.0, 409.0)" d="M 31.5 9 L 28.5 9 L 28.5 22.5 L 9 22.5 L 9 25.5 C 9 26.32500076293945 9.675000190734863 27 10.5 27 L 27 27 L 33 33 L 33 10.5 C 33 9.675000190734863 32.32500076293945 9 31.5 9 Z M 25.5 18 L 25.5 4.5 C 25.5 3.674999952316284 24.82500076293945 3 24 3 L 4.5 3 C 3.674999952316284 3 3 3.674999952316284 3 4.5 L 3 25.5 L 9 19.5 L 24 19.5 C 24.82500076293945 19.5 25.5 18.82500076293945 25.5 18 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(18.0, 462.75)" d="M 27.97156143188477 6.75 C 24.046875 6.75 20.97718811035156 9.202187538146973 19 11.4168758392334 C 17.02281379699707 9.202187538146973 13.953125 6.75 10.02843761444092 6.75 C 4.500625133514404 6.75 0 11.0131254196167 0 16.25 C 0 21.48687553405762 4.500625133514404 25.75 10.02843761444092 25.75 C 13.953125 25.75 17.02281188964844 23.29781150817871 19 21.0831241607666 C 20.97718811035156 23.29781150817871 24.046875 25.75 27.97156143188477 25.75 C 33.49937438964844 25.75 38 21.48687553405762 38 16.25 C 38 11.0131254196167 33.49937438964844 6.75 27.97156143188477 6.75 Z M 10.02843761444092 20.04999923706055 C 7.641562938690186 20.04999923706055 5.700000286102295 18.3459358215332 5.700000286102295 16.25 C 5.700000286102295 14.15406322479248 7.641562938690186 12.45000076293945 10.02843761444092 12.45000076293945 C 12.29656219482422 12.45000076293945 14.38656234741211 14.59343719482422 15.6096887588501 16.25 C 14.3984375 17.88874816894531 12.29062557220459 20.04999923706055 10.02843856811523 20.04999923706055 Z M 27.97156143188477 20.04999923706055 C 25.70343589782715 20.04999923706055 23.61343574523926 17.90656280517578 22.39031219482422 16.25 C 23.6015625 14.61125087738037 25.70937538146973 12.45000076293945 27.97156143188477 12.45000076293945 C 30.35843658447266 12.45000076293945 32.29999923706055 14.15406322479248 32.29999923706055 16.25 C 32.29999923706055 18.3459358215332 30.35843849182129 20.04999923706055 27.97156143188477 20.04999923706055 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
