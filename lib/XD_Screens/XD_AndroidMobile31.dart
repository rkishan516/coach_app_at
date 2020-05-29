import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_AndroidMobile31 extends StatelessWidget {
  XD_AndroidMobile31({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(320.0, 11.0),
            child:
                // Adobe XD layer: 'Icon awesome-search' (shape)
                SvgPicture.string(
              _shapeSVG_3805eedb222746ab9fc119086ac4bfba,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 13.0),
            child: PageLink(
              links: [
                PageLinkInfo(),
              ],
              child:
                  // Adobe XD layer: 'Icon material-menu' (shape)
                  SvgPicture.string(
                _shapeSVG_e97ce1fc75804533b5e4165fda2ed5ef,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(88.0, 70.0),
            child: SizedBox(
              width: 184.0,
              child: Text(
                'Add Event',
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
            offset: Offset(6.0, 253.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 387.5, 186),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 321,
                  height: 248,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 19,
                    crossAxisSpacing: 126,
                    crossAxisCount: 1,
                    childAspectRatio: 4.585714285714285,
                    children: [
                      {},
                      {
                        'text': 'Enter Title',
                      },
                      {
                        'text': 'Enter Description:',
                      },
                      {
                        'text': 'Name:',
                      },
                    ].map((map) {
                      final text = map['text'];
                      return Transform.translate(
                        offset: Offset(14.0, 81.5),
                        child: SvgPicture.string(
                          _shapeSVG_e12984d2630a47e580e403965b3f64d9,
                          allowDrawingOutsideViewBox: true,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(33.0, 569.0),
            child: Container(
              width: 295.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: const Color(0xffffb226),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 6),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(161.0, 586.0),
            child: Text(
              'Save',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 19,
                color: const Color(0xff434343),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(164.0, 125.0),
            child:
                // Adobe XD layer: 'Icon awesome-bell' (shape)
                SvgPicture.string(
              _shapeSVG_4d755cd531194074bba38fb577b89d43,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(134.0, -20.0),
            child:
                // Adobe XD layer: 'GC' (shape)
                Container(
              width: 92.0,
              height: 92.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _shapeSVG_3805eedb222746ab9fc119086ac4bfba =
    '<svg viewBox="320.0 11.0 26.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_e97ce1fc75804533b5e4165fda2ed5ef =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_e12984d2630a47e580e403965b3f64d9 =
    '<svg viewBox="14.0 81.5 320.0 178.0" ><g transform="translate(-32.0, -284.0)"><path transform="translate(46.0, 365.5)" d="M 0 0 L 291.2575378417969 0 L 320.00830078125 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g><g transform="translate(-32.0, -195.0)"><path transform="translate(46.0, 365.5)" d="M 0 0 L 291.2575378417969 0 L 320.00830078125 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g><g transform="translate(-32.0, -106.0)"><path transform="translate(46.0, 365.5)" d="M 0 0 L 291.2575378417969 0 L 320.00830078125 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></svg>';
const String _shapeSVG_4d755cd531194074bba38fb577b89d43 =
    '<svg viewBox="164.0 125.0 31.5 36.0" ><path transform="translate(164.0, 125.0)" d="M 15.75 36 C 18.23343658447266 36 20.24789047241211 33.98554611206055 20.24789047241211 31.5 L 11.25210952758789 31.5 C 11.25210952758789 33.98554611206055 13.26656246185303 36 15.75 36 Z M 30.89460945129395 25.47351455688477 C 29.53617095947266 24.01382637023926 26.99437522888184 21.81796836853027 26.99437522888184 14.62499904632568 C 26.99437522888184 9.161718368530273 23.16374969482422 4.788280487060547 17.99859428405762 3.715312004089355 L 17.99859428405762 2.25 C 17.99859428405762 1.007578134536743 16.99171829223633 0 15.75 0 C 14.50828170776367 0 13.50140571594238 1.007578134536743 13.50140571594238 2.25 L 13.50140571594238 3.715312480926514 C 8.336250305175781 4.788281440734863 4.505624771118164 9.161718368530273 4.505624771118164 14.625 C 4.505624771118164 21.81796836853027 1.963827848434448 24.01382827758789 0.6053903102874756 25.47351455688477 C 0.1835153102874756 25.92703056335449 -0.003515958786010742 26.46913909912109 -2.980232238769531e-07 26.99999809265137 C 0.007734077051281929 28.15312385559082 0.9126559495925903 29.24999809265137 2.257030963897705 29.24999809265137 L 29.24296760559082 29.24999809265137 C 30.58734321594238 29.24999809265137 31.49296760559082 28.15312385559082 31.49999809265137 26.99999809265137 C 31.50351333618164 26.46913909912109 31.31648254394531 25.92632675170898 30.89460754394531 25.47351455688477 Z" fill="#434343" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
