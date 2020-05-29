import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_AndroidMobile28 extends StatelessWidget {
  XD_AndroidMobile28({
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
              _shapeSVG_b708fb02b0044f17b1e97ce815359374,
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
                _shapeSVG_df99a58c69094c25a0de43626ef5d8c2,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-20.0, 70.0),
            child: SizedBox(
              width: 400.0,
              child: Text(
                'Teacher\'s Performance',
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
            offset: Offset(-6438.0, -1367.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(6438.0, 1496.0),
                  child: SpecificRectClip(
                    rect: Rect.fromLTWH(0, 0, 385, 506),
                    child: UnconstrainedBox(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 367,
                        height: 542,
                        child: GridView.count(
                          primary: false,
                          padding: EdgeInsets.all(0),
                          mainAxisSpacing: -14,
                          crossAxisSpacing: 22,
                          crossAxisCount: 1,
                          childAspectRatio: 3.5980392156862746,
                          children: [
                            {},
                            {
                              'text': '75%',
                            },
                            {
                              'text': '75%',
                            },
                            {
                              'text': '75%',
                            },
                            {
                              'text': '75%',
                            },
                            {
                              'text': '75%',
                            },
                            {
                              'text': '75%',
                            },
                          ].map((map) {
                            final text = map['text'];
                            return Transform.translate(
                              offset: Offset(9.16, 13.0),
                              child: SvgPicture.string(
                                _shapeSVG_b586e00ee775438c9f6d04a97e03c610,
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
                  offset: Offset(6472.0, 2088.0),
                  child: Container(
                    width: 1.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
              ],
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

const String _shapeSVG_b708fb02b0044f17b1e97ce815359374 =
    '<svg viewBox="320.0 11.0 26.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_df99a58c69094c25a0de43626ef5d8c2 =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_b586e00ee775438c9f6d04a97e03c610 =
    '<svg viewBox="9.2 13.0 339.3 514.3" ><g transform="translate(-32.0, -137.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(41.16, 150.0)" d="M 6.76253604888916 0 L 332.4913330078125 0 C 336.2262268066406 0 339.25390625 2.934027194976807 339.25390625 6.55333423614502 L 339.25390625 67.71778106689453 C 339.25390625 71.33708953857422 336.2262268066406 74.2711181640625 332.4913330078125 74.2711181640625 L 6.76253604888916 74.2711181640625 C 3.027689933776855 74.2711181640625 0 71.33708953857422 0 67.71778106689453 L 0 6.55333423614502 C 0 2.934027194976807 3.027689933776855 0 6.76253604888916 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, -49.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(41.16, 150.0)" d="M 6.76253604888916 0 L 332.4913330078125 0 C 336.2262268066406 0 339.25390625 2.934027194976807 339.25390625 6.55333423614502 L 339.25390625 67.71778106689453 C 339.25390625 71.33708953857422 336.2262268066406 74.2711181640625 332.4913330078125 74.2711181640625 L 6.76253604888916 74.2711181640625 C 3.027689933776855 74.2711181640625 0 71.33708953857422 0 67.71778106689453 L 0 6.55333423614502 C 0 2.934027194976807 3.027689933776855 0 6.76253604888916 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 39.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(41.16, 150.0)" d="M 6.76253604888916 0 L 332.4913330078125 0 C 336.2262268066406 0 339.25390625 2.934027194976807 339.25390625 6.55333423614502 L 339.25390625 67.71778106689453 C 339.25390625 71.33708953857422 336.2262268066406 74.2711181640625 332.4913330078125 74.2711181640625 L 6.76253604888916 74.2711181640625 C 3.027689933776855 74.2711181640625 0 71.33708953857422 0 67.71778106689453 L 0 6.55333423614502 C 0 2.934027194976807 3.027689933776855 0 6.76253604888916 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 127.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(41.16, 150.0)" d="M 6.76253604888916 0 L 332.4913330078125 0 C 336.2262268066406 0 339.25390625 2.934027194976807 339.25390625 6.55333423614502 L 339.25390625 67.71778106689453 C 339.25390625 71.33708953857422 336.2262268066406 74.2711181640625 332.4913330078125 74.2711181640625 L 6.76253604888916 74.2711181640625 C 3.027689933776855 74.2711181640625 0 71.33708953857422 0 67.71778106689453 L 0 6.55333423614502 C 0 2.934027194976807 3.027689933776855 0 6.76253604888916 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 215.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(41.16, 150.0)" d="M 6.76253604888916 0 L 332.4913330078125 0 C 336.2262268066406 0 339.25390625 2.934027194976807 339.25390625 6.55333423614502 L 339.25390625 67.71778106689453 C 339.25390625 71.33708953857422 336.2262268066406 74.2711181640625 332.4913330078125 74.2711181640625 L 6.76253604888916 74.2711181640625 C 3.027689933776855 74.2711181640625 0 71.33708953857422 0 67.71778106689453 L 0 6.55333423614502 C 0 2.934027194976807 3.027689933776855 0 6.76253604888916 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 303.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(41.16, 150.0)" d="M 6.76253604888916 0 L 332.4913330078125 0 C 336.2262268066406 0 339.25390625 2.934027194976807 339.25390625 6.55333423614502 L 339.25390625 67.71778106689453 C 339.25390625 71.33708953857422 336.2262268066406 74.2711181640625 332.4913330078125 74.2711181640625 L 6.76253604888916 74.2711181640625 C 3.027689933776855 74.2711181640625 0 71.33708953857422 0 67.71778106689453 L 0 6.55333423614502 C 0 2.934027194976807 3.027689933776855 0 6.76253604888916 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g></svg>';
