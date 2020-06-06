import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_Instituteregistration extends StatelessWidget {
  XD_Instituteregistration({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(92.0, 567.0),
            child: Container(
              width: 176.0,
              height: 53.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                gradient: LinearGradient(
                  begin: Alignment(0.91, 0.0),
                  end: Alignment(-1.0, 0.0),
                  colors: [const Color(0xfff7ff00), const Color(0xffffa200)],
                  stops: [0.0, 1.0],
                ),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
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
          Transform.translate(
            offset: Offset(320.0, 13.0),
            child:
                // Adobe XD layer: 'Icon awesome-search' (shape)
                SvgPicture.string(
              _svg_16llqo,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(146.0, 580.0),
            child: Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 10,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(109.0, 89.0),
            child: Text(
              'Institute details',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 21,
                color: const Color(0xff434343),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(16.0, 13.0),
            child:
                // Adobe XD layer: 'Icon material-menu' (shape)
                SvgPicture.string(
              _svg_qzyylc,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(3.0, 117.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 354, 425),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 354,
                  height: 448,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 20,
                    crossAxisCount: 1,
                    childAspectRatio: 5.5313,
                    children: [
                      {
                        'text': 'Name',
                      },
                      {
                        'text': 'Address',
                      },
                      {
                        'text': 'City',
                      },
                      {
                        'text': 'State',
                      },
                      {
                        'text': 'Postal Code',
                      },
                      {
                        'text': 'Domain',
                      },
                      {
                        'text': 'Logo',
                      },
                    ].map((map) {
                      final text = map['text'];
                      return Transform.translate(
                        offset: Offset(-3.0, -117.0),
                        child: Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(12.0, 123.0),
                              child: Container(
                                width: 336.0,
                                height: 46.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: const Color(0xffd5d4d4),
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
                            Transform.translate(
                              offset: Offset(20.0, 135.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 17,
                                  color: const Color(0xff9f9f9f),
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

const String _svg_16llqo =
    '<svg viewBox="320.0 13.0 26.3 26.7" ><path transform="translate(320.0, 13.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qzyylc =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
