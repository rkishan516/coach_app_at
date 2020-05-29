import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';
import 'package:adobe_xd/page_link.dart';
import './XD_AndroidMobile16.dart';
import './XD_AndroidMobile15.dart';

class XD_AndroidMobile30 extends StatelessWidget {
  XD_AndroidMobile30({
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
              _shapeSVG_9e78481c481e4a9cadfe181b78b530b8,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(96.0, 85.0),
            child: SizedBox(
              width: 170.0,
              child: Text(
                'GUARDIAN DETAILS',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 15,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(4.0, 152.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 361, 192),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 323,
                  height: 184,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 141,
                    crossAxisCount: 1,
                    childAspectRatio: 6.729166666666667,
                    children: [
                      {
                        'text': 'Name',
                      },
                      {
                        'text': 'Mobile',
                      },
                      {
                        'text': 'E-Mail',
                      },
                    ].map((map) {
                      final text = map['text'];
                      return Transform.translate(
                        offset: Offset(-16.0, -146.0),
                        child: Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(104.0, 152.0),
                              child: Container(
                                width: 257.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: const Color(0xffd9d9d9),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x29000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 6)
                                  ],
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(48.0, 157.0),
                              child: SizedBox(
                                width: 40.0,
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 13,
                                    color: const Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.right,
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
            offset: Offset(-21.0, 122.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  duration: 0.3,
                  ease: Curves.easeOut,
                  pageBuilder: () => XD_AndroidMobile16(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(113.0, 373.0),
                    child: Container(
                      width: 176.0,
                      height: 53.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        gradient: LinearGradient(
                          begin: Alignment(0.91, 0.0),
                          end: Alignment(-1.0, 0.0),
                          colors: [
                            const Color(0xfff7ff00),
                            const Color(0xffffa200)
                          ],
                          stops: [0.0, 1.0],
                        ),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 6)
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(171.0, 389.0),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(232.0, 391.0),
                    child:
                        // Adobe XD layer: 'Icon material-navig…' (shape)
                        SvgPicture.string(
                      _shapeSVG_f36b8315381c442f8611dd6aa84bede9,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(161.63, 363.63),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  duration: 0.3,
                  ease: Curves.easeOut,
                  pageBuilder: () => XD_AndroidMobile15(),
                ),
              ],
              child:
                  // Adobe XD layer: 'Icon ionic-ios-add-…' (group)
                  Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(3.38, 3.38),
                    child: SvgPicture.string(
                      _shapeSVG_dfae8225cbd04e2780faf056e1a0db04,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(111.0, 406.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  duration: 0.3,
                  ease: Curves.easeOut,
                  pageBuilder: () => XD_AndroidMobile15(),
                ),
              ],
              child: SizedBox(
                width: 138.0,
                child: Text(
                  'ADD ANOTHER \nGUARDIAN',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 13,
                    color: const Color(0xff000000),
                    letterSpacing: 1.95,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
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

const String _shapeSVG_9e78481c481e4a9cadfe181b78b530b8 =
    '<svg viewBox="16.0 11.0 330.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_f36b8315381c442f8611dd6aa84bede9 =
    '<svg viewBox="232.0 391.0 11.1 18.0" ><path transform="translate(219.11, 382.0)" d="M 15 9 L 12.88500022888184 11.11499977111816 L 19.7549991607666 18 L 12.88499927520752 24.88500022888184 L 15 27 L 24 18 L 15 9 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_dfae8225cbd04e2780faf056e1a0db04 =
    '<svg viewBox="3.4 3.4 29.3 29.3" ><path  d="M 24.36328125 16.875 L 19.125 16.875 L 19.125 11.63671875 C 19.125 11.01796913146973 18.61874961853027 10.51171875 18 10.51171875 C 17.38125038146973 10.51171875 16.875 11.01796913146973 16.875 11.63671875 L 16.875 16.875 L 11.63671875 16.875 C 11.01796913146973 16.875 10.51171875 17.296875 10.51171875 18 C 10.51171875 18.703125 11.0390625 19.125 11.63671875 19.125 C 12.234375 19.125 16.875 19.125 16.875 19.125 C 16.875 19.125 16.875 23.6953125 16.875 24.36328125 C 16.875 25.03125 17.3671875 25.48828125 18 25.48828125 C 18.6328125 25.48828125 19.125 24.98203086853027 19.125 24.36328125 L 19.125 19.125 L 24.36328125 19.125 C 24.98203086853027 19.125 25.48828125 18.61874961853027 25.48828125 18 C 25.48828125 17.38125038146973 24.98203086853027 16.875 24.36328125 16.875 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path  d="M 18 5.34375 C 21.38203048706055 5.34375 24.56015586853027 6.658593654632568 26.95078086853027 9.049219131469727 C 29.34140586853027 11.43984413146973 30.65625 14.61796855926514 30.65625 18 C 30.65625 21.38203048706055 29.34140586853027 24.56015586853027 26.95078086853027 26.95078086853027 C 24.56015586853027 29.34140586853027 21.38203048706055 30.65625 18 30.65625 C 14.61796855926514 30.65625 11.43984413146973 29.34140586853027 9.049219131469727 26.95078086853027 C 6.658593654632568 24.56015586853027 5.34375 21.38203048706055 5.34375 18 C 5.34375 14.61796951293945 6.658593654632568 11.43984413146973 9.049219131469727 9.049219131469727 C 11.43984413146973 6.658593654632568 14.61796855926514 5.34375 18 5.34375 M 18 3.375 C 9.921093940734863 3.375 3.375 9.921093940734863 3.375 18 C 3.375 26.07890701293945 9.921093940734863 32.625 18 32.625 C 26.07890701293945 32.625 32.625 26.07890701293945 32.625 18 C 32.625 9.921092987060547 26.07890701293945 3.375 18 3.375 L 18 3.375 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
