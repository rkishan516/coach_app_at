import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/specific_rect_clip.dart';
import './XD_AndroidMobile19.dart';

class XD_AndroidMobile18 extends StatelessWidget {
  XD_AndroidMobile18({
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
              _shapeSVG_34478b50c0b64355bdc66a70fce3b19c,
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
                _shapeSVG_4263fea786f3497fa70737a4428b3fc7,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(106.0, 70.0),
            child: SizedBox(
              width: 148.0,
              child: Text(
                'Subjects',
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
            offset: Offset(0.0, 134.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  duration: 0.3,
                  ease: Curves.easeOut,
                  pageBuilder: () => XD_AndroidMobile19(),
                ),
              ],
              child: SpecificRectClip(
                rect: Rect.fromLTWH(0, 0, 385, 264),
                child: UnconstrainedBox(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 259,
                    height: 271,
                    child: GridView.count(
                      primary: false,
                      padding: EdgeInsets.all(0),
                      mainAxisSpacing: -7,
                      crossAxisSpacing: 130,
                      crossAxisCount: 1,
                      childAspectRatio: 2.7263157894736842,
                      children: [
                        {},
                        {
                          'text': 'physics',
                        },
                        {
                          'text': 'chem',
                        },
                        {
                          'text': 'math',
                        },
                      ].map((map) {
                        final text = map['text'];
                        return Transform.translate(
                          offset: Offset(57.48, 13.0),
                          child: SvgPicture.string(
                            _shapeSVG_c287a9140abe4f5a9235985c3e32e932,
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
            offset: Offset(317.0, 11.0),
            child:
                // Adobe XD layer: 'Icon awesome-bell' (shape)
                SvgPicture.string(
              _shapeSVG_d0282946f77d4f1fa49b2d050d1c2d62,
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

const String _shapeSVG_34478b50c0b64355bdc66a70fce3b19c =
    '<svg viewBox="320.0 11.0 26.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_4263fea786f3497fa70737a4428b3fc7 =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_c287a9140abe4f5a9235985c3e32e932 =
    '<svg viewBox="57.5 13.0 231.5 244.0" ><g transform="translate(-32.0, -137.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(89.48, 150.0)" d="M 4.615182399749756 0 L 226.9131317138672 0 C 229.4620361328125 0 231.5283203125 2.686291217803955 231.5283203125 6 L 231.5283203125 62 C 231.5283203125 65.31370544433594 229.4620361328125 68 226.9131317138672 68 L 4.615182399749756 68 C 2.066287279129028 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.066287279129028 0 4.615182399749756 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, -49.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(89.48, 150.0)" d="M 4.615182399749756 0 L 226.9131317138672 0 C 229.4620361328125 0 231.5283203125 2.686291217803955 231.5283203125 6 L 231.5283203125 62 C 231.5283203125 65.31370544433594 229.4620361328125 68 226.9131317138672 68 L 4.615182399749756 68 C 2.066287279129028 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.066287279129028 0 4.615182399749756 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 39.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(89.48, 150.0)" d="M 4.615182399749756 0 L 226.9131317138672 0 C 229.4620361328125 0 231.5283203125 2.686291217803955 231.5283203125 6 L 231.5283203125 62 C 231.5283203125 65.31370544433594 229.4620361328125 68 226.9131317138672 68 L 4.615182399749756 68 C 2.066287279129028 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.066287279129028 0 4.615182399749756 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g></svg>';
const String _shapeSVG_d0282946f77d4f1fa49b2d050d1c2d62 =
    '<svg viewBox="317.0 11.0 31.5 36.0" ><path transform="translate(317.0, 11.0)" d="M 15.75 36 C 18.23343658447266 36 20.24789047241211 33.98554611206055 20.24789047241211 31.5 L 11.25210952758789 31.5 C 11.25210952758789 33.98554611206055 13.26656246185303 36 15.75 36 Z M 30.89460945129395 25.47351455688477 C 29.53617095947266 24.01382637023926 26.99437522888184 21.81796836853027 26.99437522888184 14.62499904632568 C 26.99437522888184 9.161718368530273 23.16374969482422 4.788280487060547 17.99859428405762 3.715312004089355 L 17.99859428405762 2.25 C 17.99859428405762 1.007578134536743 16.99171829223633 0 15.75 0 C 14.50828170776367 0 13.50140571594238 1.007578134536743 13.50140571594238 2.25 L 13.50140571594238 3.715312480926514 C 8.336250305175781 4.788281440734863 4.505624771118164 9.161718368530273 4.505624771118164 14.625 C 4.505624771118164 21.81796836853027 1.963827848434448 24.01382827758789 0.6053903102874756 25.47351455688477 C 0.1835153102874756 25.92703056335449 -0.003515958786010742 26.46913909912109 -2.980232238769531e-07 26.99999809265137 C 0.007734077051281929 28.15312385559082 0.9126559495925903 29.24999809265137 2.257030963897705 29.24999809265137 L 29.24296760559082 29.24999809265137 C 30.58734321594238 29.24999809265137 31.49296760559082 28.15312385559082 31.49999809265137 26.99999809265137 C 31.50351333618164 26.46913909912109 31.31648254394531 25.92632675170898 30.89460754394531 25.47351455688477 Z" fill="#434343" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
