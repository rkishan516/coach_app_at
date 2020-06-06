import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_Chapterpage extends StatelessWidget {
  XD_Chapterpage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(16.0, 11.0),
            child:
                // Adobe XD layer: 'Icon awesome-search' (shape)
                SvgPicture.string(
              _svg_os500x,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(112.0, 76.0),
            child: SizedBox(
              width: 136.0,
              child: Text(
                'cHAPTERS',
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
            offset: Offset(8.0, 126.0),
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
                    childAspectRatio: 3.0435,
                    children: [
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
                            Transform.translate(
                              offset: Offset(322.0, 167.0),
                              child: SizedBox(
                                width: 60.0,
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 58,
                                    color: const Color(0xff8a8a8a),
                                    shadows: [
                                      Shadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(3, 3),
                                        blurRadius: 6,
                                      )
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
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
            offset: Offset(83.0, -20.0),
            child:
                // Adobe XD layer: 'feature_ds_png' (shape)
                Container(
              width: 200.0,
              height: 97.0,
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

const String _svg_os500x =
    '<svg viewBox="16.0 11.0 330.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yjeo4d =
    '<svg viewBox="45.1 150.0 322.8 86.4" ><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 6.434839725494385 0 L 316.3796081542969 0 C 319.9335021972656 0 322.814453125 3.413033485412598 322.814453125 7.623224258422852 L 322.814453125 78.7733154296875 C 322.814453125 82.98350524902344 319.9335021972656 86.39654541015625 316.3796081542969 86.39654541015625 L 6.434839725494385 86.39654541015625 C 2.880975484848022 86.39654541015625 0 82.98350524902344 0 78.7733154296875 L 0 7.623224258422852 C 0 3.413033485412598 2.880975484848022 0 6.434839725494385 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
