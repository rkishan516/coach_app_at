import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';
import 'package:adobe_xd/page_link.dart';

class XD_AndroidMobile5 extends StatelessWidget {
  XD_AndroidMobile5({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(320.0, 13.0),
            child:
                // Adobe XD layer: 'Icon awesome-search' (shape)
                SvgPicture.string(
              _shapeSVG_68455d505256444e8192a04e8ec38109,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 559.0),
            child: Container(
              width: 360.0,
              height: 81.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [const Color(0x00ffa500), const Color(0xff000000)],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 72.0),
            child: SvgPicture.string(
              _shapeSVG_20b31fb231c143c8a74d51a6fd9001b2,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(2.0, 6.13),
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(20.0, 70.87),
                      child: Text(
                        'ENGINEERING',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 20,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(27.0, 130.87),
                      child: SpecificRectClip(
                        rect: Rect.fromLTWH(0, 0, 302, 554),
                        child: UnconstrainedBox(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 299,
                            height: 564,
                            child: GridView.count(
                              primary: false,
                              padding: EdgeInsets.all(0),
                              mainAxisSpacing: 32,
                              crossAxisSpacing: 28,
                              crossAxisCount: 3,
                              childAspectRatio: 0.6923076923076923,
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
                                          width: 81.0,
                                          height: 95.0,
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
                                        offset: Offset(47.0, 213.0),
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
                        _shapeSVG_a54b7acbb14f45309efb93a3dee7849d,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                _shapeSVG_021ed267ee1c4d6090fdf4ea5dc1864f,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 594.0),
            child: Container(
              width: 360.0,
              height: 81.0,
              decoration: BoxDecoration(
                color: const Color(0xffffa500),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(67.0, 583.0),
            child: Container(
              width: 51.0,
              height: 51.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(25.5, 25.5)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(3, 3),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(234.0, 583.0),
            child: Container(
              width: 51.0,
              height: 51.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(25.5, 25.5)),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(3, 3),
                      blurRadius: 6)
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(81.0, 13.0),
            child:
                // Adobe XD layer: 'Icon material-libra…' (shape)
                SvgPicture.string(
              _shapeSVG_fe0357edb45141efa7881d4ff902dd15,
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

const String _shapeSVG_68455d505256444e8192a04e8ec38109 =
    '<svg viewBox="320.0 13.0 26.3 26.7" ><path transform="translate(320.0, 13.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_a54b7acbb14f45309efb93a3dee7849d =
    '<svg viewBox="-42.5 110.4 442.0 1.0" ><path transform="translate(-42.5, 110.37)" d="M 0 0 L 442 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_20b31fb231c143c8a74d51a6fd9001b2 =
    '<svg viewBox="0.0 72.0 360.0 44.0" ><g transform=""><path transform="translate(0.0, 72.0)" d="M 0 0 L 360 0 L 360 44 L 221.3384399414063 44 L 0 44 L 0 0 Z" fill="#ffa500" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><g transform="translate(316.63, 75.63)"><path  d="M 10.37812519073486 14.81484413146973 C 9.850781440734863 15.34218788146973 9.850781440734863 16.20703125 10.37812519073486 16.734375 L 17.10703086853027 23.44218826293945 C 17.62031173706055 23.95546913146973 18.44999885559082 23.96953201293945 18.97734260559082 23.484375 L 25.60781097412109 16.875 C 25.87499809265137 16.60781288146973 26.00859260559082 16.26328086853027 26.00859260559082 15.91171836853027 C 26.00859260559082 15.56718730926514 25.87499809265137 15.21562480926514 25.61484336853027 14.95546817779541 C 25.08749961853027 14.42812442779541 24.22968673706055 14.42109298706055 23.6953125 14.95546817779541 L 18 20.56640625 L 12.29765605926514 14.80781269073486 C 11.77031230926514 14.28046894073486 10.91250038146973 14.28046894073486 10.37812519073486 14.81484413146973 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path  d="M 3.375 18 C 3.375 26.07890701293945 9.921093940734863 32.625 18 32.625 C 26.07890701293945 32.625 32.625 26.07890701293945 32.625 18 C 32.625 9.921093940734863 26.07890701293945 3.375 18 3.375 C 9.921092987060547 3.375 3.375 9.921093940734863 3.375 18 Z M 26.74687576293945 9.253125190734863 C 29.08828163146973 11.58749961853027 30.375 14.6953125 30.375 18 C 30.375 21.3046875 29.08828163146973 24.41250038146973 26.74687576293945 26.74687576293945 C 24.41250038146973 29.08828163146973 21.3046875 30.375 18 30.375 C 14.6953125 30.375 11.58749961853027 29.08828163146973 9.253125190734863 26.74687576293945 C 6.911718845367432 24.41250038146973 5.625 21.3046875 5.625 18 C 5.625 14.6953125 6.911718845367432 11.58749961853027 9.253125190734863 9.253125190734863 C 11.58749961853027 6.911718845367432 14.6953125 5.625 18 5.625 C 21.3046875 5.625 24.41250038146973 6.911718845367432 26.74687576293945 9.253125190734863 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></g></svg>';
const String _shapeSVG_021ed267ee1c4d6090fdf4ea5dc1864f =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_fe0357edb45141efa7881d4ff902dd15 =
    '<svg viewBox="81.0 13.0 265.3 607.5" ><path transform="translate(244.0, 593.07)" d="M 5.44266939163208 7.885339260101318 L 3 7.885339260101318 L 3 24.98402786254883 C 3 26.32749557495117 4.099201202392578 27.42669677734375 5.44266939163208 27.42669677734375 L 22.54135894775391 27.42669677734375 L 22.54135894775391 24.98402786254883 L 5.44266939163208 24.98402786254883 L 5.44266939163208 7.885339260101318 Z M 24.98402786254883 3 L 10.3280086517334 3 C 8.984540939331055 3 7.885339260101318 4.099201202392578 7.885339260101318 5.44266939163208 L 7.885339260101318 20.09868812561035 C 7.885339260101318 21.4421558380127 8.984540939331055 22.54135894775391 10.3280086517334 22.54135894775391 L 24.98402786254883 22.54135894775391 C 26.32749557495117 22.54135894775391 27.42669677734375 21.4421558380127 27.42669677734375 20.09868812561035 L 27.42669677734375 5.44266939163208 C 27.42669677734375 4.099201202392578 26.32749557495117 3 24.98402786254883 3 Z M 23.76269340515137 13.9920129776001 L 18.87735366821289 13.9920129776001 L 18.87735366821289 18.87735366821289 L 16.43468284606934 18.87735366821289 L 16.43468284606934 13.9920129776001 L 11.54934406280518 13.9920129776001 L 11.54934406280518 11.54934406280518 L 16.43468284606934 11.54934406280518 L 16.43468284606934 6.664004325866699 L 18.87735366821289 6.664004325866699 L 18.87735366821289 11.54934406280518 L 23.76269340515137 11.54934406280518 L 23.76269340515137 13.9920129776001 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(81.0, 595.7)" d="M 2.212695598602295 3.374999761581421 C 0.9906575679779053 3.374999761581421 0 4.365657329559326 0 5.587695121765137 C 0 6.809733390808105 0.99065762758255 7.80039119720459 2.212695837020874 7.80039119720459 C 3.434733867645264 7.80039119720459 4.42539119720459 6.809733390808105 4.42539119720459 5.587695121765137 C 4.42539119720459 4.365657329559326 3.434733867645264 3.374999761581421 2.212695598602295 3.374999761581421 Z M 2.212695598602295 10.75065231323242 C 0.9906575679779053 10.75065231323242 0 11.74131011962891 0 12.96334743499756 C 0 14.18538570404053 0.99065762758255 15.17604351043701 2.212695837020874 15.17604351043701 C 3.434733867645264 15.17604351043701 4.42539119720459 14.18538570404053 4.42539119720459 12.96334743499756 C 4.42539119720459 11.74131011962891 3.434733867645264 10.75065231323242 2.212695598602295 10.75065231323242 Z M 2.212695598602295 18.12630462646484 C 0.9906575679779053 18.12630462646484 0 19.11696434020996 0 20.3390007019043 C 0 21.56103897094727 0.99065762758255 22.55169486999512 2.212695837020874 22.55169486999512 C 3.434733867645264 22.55169486999512 4.42539119720459 21.56103897094727 4.42539119720459 20.3390007019043 C 4.42539119720459 19.11696434020996 3.434733867645264 18.12630462646484 2.212695598602295 18.12630462646484 Z M 22.86452293395996 18.86386871337891 L 8.113217353820801 18.86386871337891 C 7.705871105194092 18.86386871337891 7.375652313232422 19.19408798217773 7.375652313232422 19.6014347076416 L 7.375652313232422 21.07656478881836 C 7.375652313232422 21.48391151428223 7.705871105194092 21.81413078308105 8.113217353820801 21.81413078308105 L 22.86452293395996 21.81413078308105 C 23.2718677520752 21.81413078308105 23.60208702087402 21.48391151428223 23.60208702087402 21.07656478881836 L 23.60208702087402 19.6014347076416 C 23.60208702087402 19.19408798217773 23.2718677520752 18.86386871337891 22.86452293395996 18.86386871337891 Z M 22.86452293395996 4.112565040588379 L 8.113217353820801 4.112565040588379 C 7.705871105194092 4.112565040588379 7.375652313232422 4.442784309387207 7.375652313232422 4.850130081176758 L 7.375652313232422 6.325261116027832 C 7.375652313232422 6.732606887817383 7.705871105194092 7.062826156616211 8.113217353820801 7.062826156616211 L 22.86452293395996 7.062826156616211 C 23.2718677520752 7.062826156616211 23.60208702087402 6.732606887817383 23.60208702087402 6.325261116027832 L 23.60208702087402 4.850130081176758 C 23.60208702087402 4.442784309387207 23.2718677520752 4.112565040588379 22.86452293395996 4.112565040588379 Z M 22.86452293395996 11.4882173538208 L 8.113217353820801 11.4882173538208 C 7.705871105194092 11.4882173538208 7.375652313232422 11.81843662261963 7.375652313232422 12.22578239440918 L 7.375652313232422 13.70091247558594 C 7.375652313232422 14.1082592010498 7.705871105194092 14.43847846984863 8.113217353820801 14.43847846984863 L 22.86452293395996 14.43847846984863 C 23.2718677520752 14.43847846984863 23.60208702087402 14.1082592010498 23.60208702087402 13.70091247558594 L 23.60208702087402 12.22578239440918 C 23.60208702087402 11.81843662261963 23.2718677520752 11.4882173538208 22.86452293395996 11.4882173538208 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(320.0, 13.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
