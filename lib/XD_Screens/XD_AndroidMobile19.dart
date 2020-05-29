import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/specific_rect_clip.dart';
import './XD_AndroidMobile20.dart';

class XD_AndroidMobile19 extends StatelessWidget {
  XD_AndroidMobile19({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(320.0, 11.0),
            child:
                // Adobe XD layer: 'Icon awesome-search' (shape)
                SvgPicture.string(
              _shapeSVG_4c62157ff25341f1a8c9e7e82a99ff48,
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
                _shapeSVG_3a6cf17113474ddf999b96cae02f78c7,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(100.0, 70.0),
            child: SizedBox(
              width: 160.0,
              child: Text(
                'cHAPTERS',
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
            offset: Offset(8.0, 126.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  duration: 0.3,
                  ease: Curves.easeOut,
                  pageBuilder: () => XD_AndroidMobile20(),
                ),
              ],
              child: SpecificRectClip(
                rect: Rect.fromLTWH(0, 0, 385, 708),
                child: UnconstrainedBox(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 350,
                    height: 817,
                    child: GridView.count(
                      primary: false,
                      padding: EdgeInsets.all(0),
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 39,
                      crossAxisCount: 1,
                      childAspectRatio: 3.0434782608695654,
                      children: [
                        {},
                        {
                          'text': '1',
                        },
                        {
                          'text': '2',
                        },
                        {
                          'text': '3',
                        },
                        {
                          'text': '4',
                        },
                        {
                          'text': '5',
                        },
                        {
                          'text': '6',
                        },
                        {
                          'text': '1',
                        },
                      ].map((map) {
                        final text = map['text'];
                        return Transform.translate(
                          offset: Offset(13.09, 13.0),
                          child: SvgPicture.string(
                            _shapeSVG_ed30857a7300468984e0b03b12c159b4,
                            allowDrawingOutsideViewBox: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
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

const String _shapeSVG_4c62157ff25341f1a8c9e7e82a99ff48 =
    '<svg viewBox="320.0 11.0 26.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_3a6cf17113474ddf999b96cae02f78c7 =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_ed30857a7300468984e0b03b12c159b4 =
    '<svg viewBox="13.1 13.0 322.8 788.4" ><g transform="translate(-32.0, -137.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, -20.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 97.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 214.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 331.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 448.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 565.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g></svg>';
