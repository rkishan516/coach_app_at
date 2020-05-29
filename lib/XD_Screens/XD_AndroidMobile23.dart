import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';
import 'package:adobe_xd/gradient_xd_transform.dart';

class XD_AndroidMobile23 extends StatelessWidget {
  XD_AndroidMobile23({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(102.0, 6.0),
            child: Container(
              width: 157.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(160.0, 6.0),
            child: Text(
              'logo',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(320.0, 11.0),
            child:
                // Adobe XD layer: 'Icon awesome-search' (shape)
                SvgPicture.string(
              _shapeSVG_3d955394f39c4fe3b86850d272b3fb01,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(102.0, 6.0),
            child: Container(
              width: 157.0,
              height: 34.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(160.0, 6.0),
            child: Text(
              'logo',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(64.0, 70.0),
            child: SizedBox(
              width: 232.0,
              child: Text(
                'Your Courses',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 34,
                  color: const Color(0xff434343),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 13.0),
            child:
                // Adobe XD layer: 'Icon material-menu' (shape)
                SvgPicture.string(
              _shapeSVG_dcd962eb647c406884d498f3165046c2,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(2.0, 41.13),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(35.0, 127.87),
                  child: SpecificRectClip(
                    rect: Rect.fromLTWH(0, 0, 302, 554),
                    child: UnconstrainedBox(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 291,
                        height: 547,
                        child: GridView.count(
                          primary: false,
                          padding: EdgeInsets.all(0),
                          mainAxisSpacing: 49,
                          crossAxisSpacing: 36,
                          crossAxisCount: 3,
                          childAspectRatio: 0.73,
                          children: [
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                            {
                              'fill': const Color(0xff000000),
                            },
                          ].map((map) {
                            final fill = map['fill'];
                            return Transform.translate(
                              offset: Offset(-20.0, -110.0),
                              child: Stack(
                                children: <Widget>[
                                  Transform.translate(
                                    offset: Offset(20.0, 110.0),
                                    child:
                                        // Adobe XD layer: 'interesting-workspa…' (shape)
                                        Container(
                                      width: 73.0,
                                      height: 78.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        image: DecorationImage(
                                          image: null,
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                            width: 1.0,
                                            color: const Color(0xff707070)),
                                      ),
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(43.0, 196.0),
                                    child: Text(
                                      'NAME',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 10,
                                        color: const Color(0xff000000),
                                      ),
                                      textAlign: TextAlign.left,
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
                Transform.translate(
                  offset: Offset(-42.5, 110.37),
                  child: SvgPicture.string(
                    _shapeSVG_0b5573a56383429d82a7160f7ee64c0e,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 360.0,
            height: 640.0,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, 0.0),
                radius: 0.5,
                colors: [const Color(0xbd747474), const Color(0xbd3a3a3a)],
                stops: [0.0, 1.0],
                transform: GradientXDTransform(
                    1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(36.0, 116.0),
            child: Container(
              width: 288.0,
              height: 459.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: const Color(0x00ffffff),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(3, 3),
                      blurRadius: 10)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(47.0, 138.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 242, 388),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 242,
                  height: 378,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 38,
                    crossAxisSpacing: 20,
                    crossAxisCount: 1,
                    childAspectRatio: 3.6666666666666665,
                    children: [
                      {
                        'text': 'Course Description',
                      },
                      {
                        'text': 'Medium',
                      },
                      {
                        'text': 'Fee',
                      },
                      {
                        'text': 'Batches',
                      },
                    ].map((map) {
                      final text = map['text'];
                      return Transform.translate(
                        offset: Offset(-54.0, -153.0),
                        child: Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(54.0, 153.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(54.0, 177.0),
                              child: Container(
                                width: 242.0,
                                height: 41.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: const Color(0xffb8b8b8),
                                ),
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
          Transform.translate(
            offset: Offset(226.0, 537.0),
            child: Container(
              width: 63.0,
              height: 23.0,
              decoration: BoxDecoration(
                color: const Color(0xff000000),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _shapeSVG_3d955394f39c4fe3b86850d272b3fb01 =
    '<svg viewBox="320.0 11.0 26.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_dcd962eb647c406884d498f3165046c2 =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_0b5573a56383429d82a7160f7ee64c0e =
    '<svg viewBox="-42.5 110.4 442.0 1.0" ><path transform="translate(-42.5, 110.37)" d="M 0 0 L 442 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
