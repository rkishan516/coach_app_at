import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_Subjectpage extends StatelessWidget {
  XD_Subjectpage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(117.0, 70.0),
            child: SizedBox(
              width: 126.0,
              child: Text(
                'Subjects',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 29,
                  color: const Color(0xff434343),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(275.0, -11.0),
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
          Transform.translate(
            offset: Offset(8.0, 126.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 385, 359),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 350,
                  height: 465,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 39,
                    crossAxisCount: 1,
                    childAspectRatio: 3.0702,
                    children: [
                      {
                        'text': 'Physics',
                      },
                      {
                        'text': 'meth',
                      },
                      {
                        'text': 'lsd\n',
                      },
                      {
                        'text': 'math',
                      },
                    ].map((map) {
                      final text = map['text'];
                      return Transform.translate(
                        offset: Offset(-32.0, -137.0),
                        child: Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(45.09, 150.0),
                              child: SvgPicture.string(
                                _svg_yjeo4d,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(52.0, 150.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 25,
                                  color: const Color(0xffffffff),
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
            offset: Offset(11.0, 582.0),
            child: Container(
              width: 148.0,
              height: 51.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: const Color(0xffffa500),
              ),
            ),
          ),
          Container(
            width: 360.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: const Color(0xffffa500),
            ),
          ),
          Transform.translate(
            offset: Offset(15.0, 586.0),
            child: Container(
              width: 58.0,
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 13.0),
            child:
                // Adobe XD layer: 'Icon material-menu' (shape)
                SvgPicture.string(
              _svg_pfp4g2,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(201.0, 582.0),
            child: Container(
              width: 148.0,
              height: 51.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: const Color(0xffffa500),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(205.0, 586.0),
            child: Container(
              width: 58.0,
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: const Color(0xffffffff),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(221.0, 595.0),
            child:
                // Adobe XD layer: 'Icon material-add-b…' (shape)
                SvgPicture.string(
              _svg_rxdit5,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(257.0, -2.0),
            child: Container(
              width: 110.0,
              height: 111.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(55.0, 55.5)),
                color: const Color(0xffffa500),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(270.0, 8.0),
            child:
                // Adobe XD layer: '8i6e9pyz' (shape)
                Container(
              width: 86.0,
              height: 86.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(43.0, 43.0)),
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(85.0, 587.0),
            child: Text(
              'Live \nsessions',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(273.0, 589.0),
            child: Text(
              'Add\ncourses',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(62.0, 8.0),
            child: Text(
              'Academy Name',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 23,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_yjeo4d =
    '<svg viewBox="45.1 150.0 322.8 86.4" ><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_pfp4g2 =
    '<svg viewBox="16.0 13.0 44.1 609.5" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(25.6, 589.5)" d="M 31.5 9 L 20.11499977111816 9 L 25.04999923706055 4.065000057220459 L 24 3 L 18 9 L 12 3 L 10.93499946594238 4.065000057220459 L 15.88500022888184 9 L 4.5 9 C 2.849999904632568 9 1.5 10.33500003814697 1.5 12 L 1.5 30 C 1.5 31.64999961853027 2.849999904632568 33 4.5 33 L 31.5 33 C 33.15000152587891 33 34.5 31.64999961853027 34.5 30 L 34.5 12 C 34.5 10.33500003814697 33.15000152587891 9 31.5 9 Z M 31.5 30 L 4.5 30 L 4.5 12 L 31.5 12 L 31.5 30 Z M 13.5 15 L 13.5 27 L 24 21 L 13.5 15 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rxdit5 =
    '<svg viewBox="221.0 595.0 27.0 27.0" ><path transform="translate(216.5, 590.5)" d="M 28.5 4.5 L 7.5 4.5 C 5.835000038146973 4.5 4.5 5.849999904632568 4.5 7.5 L 4.5 28.5 C 4.5 30.14999961853027 5.835000038146973 31.5 7.5 31.5 L 28.5 31.5 C 30.14999961853027 31.5 31.5 30.14999961853027 31.5 28.5 L 31.5 7.5 C 31.5 5.849999904632568 30.14999961853027 4.5 28.5 4.5 Z M 25.5 19.5 L 19.5 19.5 L 19.5 25.5 L 16.5 25.5 L 16.5 19.5 L 10.5 19.5 L 10.5 16.5 L 16.5 16.5 L 16.5 10.5 L 19.5 10.5 L 19.5 16.5 L 25.5 16.5 L 25.5 19.5 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
