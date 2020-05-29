import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/page_link.dart';
import './XD_AndroidMobile12.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_AndroidMobile9 extends StatelessWidget {
  XD_AndroidMobile9({
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
              _shapeSVG_6ca99d829e6c4104977b34c068c9fe74,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(97.0, 70.0),
            child: Text(
              'All Courses',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 34,
                color: const Color(0xff434343),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(32.0, 137.0),
            child: SpecificRectClip(
              rect: Rect.fromLTWH(0, 0, 301, 517),
              child: UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 319,
                  height: 526,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    crossAxisCount: 1,
                    childAspectRatio: 3.7093023255813953,
                    children: [
                      {},
                      {},
                      {},
                      {},
                      {},
                      {},
                      {},
                    ].map((map) {
                      return Transform.translate(
                        offset: Offset(-32.0, -137.0),
                        child: Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(30.0, 156.0),
                              child: PageLink(
                                links: [
                                  PageLinkInfo(
                                    transition: LinkTransition.Fade,
                                    duration: 0.3,
                                    ease: Curves.easeOut,
                                    pageBuilder: () => XD_AndroidMobile12(),
                                  ),
                                ],
                                child: SvgPicture.string(
                                  _shapeSVG_005db026a86b497f9fc0b1a0ea8e5110,
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(86.0, 167.0),
                              child: Text(
                                'XYZ',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 25,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(232.0, 167.0),
                              child: Text(
                                '\$100',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 25,
                                  color: const Color(0xffffffff),
                                  shadows: [
                                    Shadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    )
                                  ],
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
            offset: Offset(16.0, 13.0),
            child: PageLink(
              links: [
                PageLinkInfo(),
              ],
              child:
                  // Adobe XD layer: 'Icon material-menu' (shape)
                  SvgPicture.string(
                _shapeSVG_84d10fc5f3df452f8f13cbc8796b55b2,
                allowDrawingOutsideViewBox: true,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(85.0, 127.0),
            child: Text(
              'Name',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(241.0, 127.0),
            child: Text(
              'Price',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
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
            offset: Offset(243.0, 583.0),
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
            offset: Offset(81.0, 596.07),
            child:
                // Adobe XD layer: 'Icon material-libra…' (shape)
                SvgPicture.string(
              _shapeSVG_efb68fdf28ba4a03b6777a92882ee20e,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(155.0, 583.0),
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
            offset: Offset(168.0, 13.0),
            child:
                // Adobe XD layer: 'Icon material-libra…' (shape)
                SvgPicture.string(
              _shapeSVG_cc88d23a05c9412d8a77adde71c94aa5,
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

const String _shapeSVG_6ca99d829e6c4104977b34c068c9fe74 =
    '<svg viewBox="320.0 11.0 26.3 26.7" ><path transform="translate(320.0, 11.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_005db026a86b497f9fc0b1a0ea8e5110 =
    '<svg viewBox="30.0 156.0 301.0 68.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(30.0, 156.0)" d="M 6 0 L 295 0 C 298.313720703125 0 301 2.686291217803955 301 6 L 301 62 C 301 65.31370544433594 298.313720703125 68 295 68 L 6 68 C 2.686291217803955 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.686291217803955 0 6 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _shapeSVG_118fedefe613421787aa3d7ecc4b321f =
    '<svg viewBox="-2.0 107.0 301.0 420.0" ><g transform="translate(-32.0, -49.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(30.0, 156.0)" d="M 6 0 L 295 0 C 298.313720703125 0 301 2.686291217803955 301 6 L 301 62 C 301 65.31370544433594 298.313720703125 68 295 68 L 6 68 C 2.686291217803955 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.686291217803955 0 6 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 39.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(30.0, 156.0)" d="M 6 0 L 295 0 C 298.313720703125 0 301 2.686291217803955 301 6 L 301 62 C 301 65.31370544433594 298.313720703125 68 295 68 L 6 68 C 2.686291217803955 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.686291217803955 0 6 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 127.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(30.0, 156.0)" d="M 6 0 L 295 0 C 298.313720703125 0 301 2.686291217803955 301 6 L 301 62 C 301 65.31370544433594 298.313720703125 68 295 68 L 6 68 C 2.686291217803955 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.686291217803955 0 6 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 215.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(30.0, 156.0)" d="M 6 0 L 295 0 C 298.313720703125 0 301 2.686291217803955 301 6 L 301 62 C 301 65.31370544433594 298.313720703125 68 295 68 L 6 68 C 2.686291217803955 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.686291217803955 0 6 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g><g transform="translate(-32.0, 303.0)"><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(30.0, 156.0)" d="M 6 0 L 295 0 C 298.313720703125 0 301 2.686291217803955 301 6 L 301 62 C 301 65.31370544433594 298.313720703125 68 295 68 L 6 68 C 2.686291217803955 68 0 65.31370544433594 0 62 L 0 6 C 0 2.686291217803955 2.686291217803955 0 6 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></g></svg>';
const String _shapeSVG_84d10fc5f3df452f8f13cbc8796b55b2 =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_efb68fdf28ba4a03b6777a92882ee20e =
    '<svg viewBox="81.0 596.1 199.4 24.4" ><path transform="translate(253.0, 593.07)" d="M 5.44266939163208 7.885339260101318 L 3 7.885339260101318 L 3 24.98402786254883 C 3 26.32749557495117 4.099201202392578 27.42669677734375 5.44266939163208 27.42669677734375 L 22.54135894775391 27.42669677734375 L 22.54135894775391 24.98402786254883 L 5.44266939163208 24.98402786254883 L 5.44266939163208 7.885339260101318 Z M 24.98402786254883 3 L 10.3280086517334 3 C 8.984540939331055 3 7.885339260101318 4.099201202392578 7.885339260101318 5.44266939163208 L 7.885339260101318 20.09868812561035 C 7.885339260101318 21.4421558380127 8.984540939331055 22.54135894775391 10.3280086517334 22.54135894775391 L 24.98402786254883 22.54135894775391 C 26.32749557495117 22.54135894775391 27.42669677734375 21.4421558380127 27.42669677734375 20.09868812561035 L 27.42669677734375 5.44266939163208 C 27.42669677734375 4.099201202392578 26.32749557495117 3 24.98402786254883 3 Z M 23.76269340515137 13.9920129776001 L 18.87735366821289 13.9920129776001 L 18.87735366821289 18.87735366821289 L 16.43468284606934 18.87735366821289 L 16.43468284606934 13.9920129776001 L 11.54934406280518 13.9920129776001 L 11.54934406280518 11.54934406280518 L 16.43468284606934 11.54934406280518 L 16.43468284606934 6.664004325866699 L 18.87735366821289 6.664004325866699 L 18.87735366821289 11.54934406280518 L 23.76269340515137 11.54934406280518 L 23.76269340515137 13.9920129776001 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(81.0, 595.7)" d="M 2.212695598602295 3.374999761581421 C 0.9906575679779053 3.374999761581421 0 4.365657329559326 0 5.587695121765137 C 0 6.809733390808105 0.99065762758255 7.80039119720459 2.212695837020874 7.80039119720459 C 3.434733867645264 7.80039119720459 4.42539119720459 6.809733390808105 4.42539119720459 5.587695121765137 C 4.42539119720459 4.365657329559326 3.434733867645264 3.374999761581421 2.212695598602295 3.374999761581421 Z M 2.212695598602295 10.75065231323242 C 0.9906575679779053 10.75065231323242 0 11.74131011962891 0 12.96334743499756 C 0 14.18538570404053 0.99065762758255 15.17604351043701 2.212695837020874 15.17604351043701 C 3.434733867645264 15.17604351043701 4.42539119720459 14.18538570404053 4.42539119720459 12.96334743499756 C 4.42539119720459 11.74131011962891 3.434733867645264 10.75065231323242 2.212695598602295 10.75065231323242 Z M 2.212695598602295 18.12630462646484 C 0.9906575679779053 18.12630462646484 0 19.11696434020996 0 20.3390007019043 C 0 21.56103897094727 0.99065762758255 22.55169486999512 2.212695837020874 22.55169486999512 C 3.434733867645264 22.55169486999512 4.42539119720459 21.56103897094727 4.42539119720459 20.3390007019043 C 4.42539119720459 19.11696434020996 3.434733867645264 18.12630462646484 2.212695598602295 18.12630462646484 Z M 22.86452293395996 18.86386871337891 L 8.113217353820801 18.86386871337891 C 7.705871105194092 18.86386871337891 7.375652313232422 19.19408798217773 7.375652313232422 19.6014347076416 L 7.375652313232422 21.07656478881836 C 7.375652313232422 21.48391151428223 7.705871105194092 21.81413078308105 8.113217353820801 21.81413078308105 L 22.86452293395996 21.81413078308105 C 23.2718677520752 21.81413078308105 23.60208702087402 21.48391151428223 23.60208702087402 21.07656478881836 L 23.60208702087402 19.6014347076416 C 23.60208702087402 19.19408798217773 23.2718677520752 18.86386871337891 22.86452293395996 18.86386871337891 Z M 22.86452293395996 4.112565040588379 L 8.113217353820801 4.112565040588379 C 7.705871105194092 4.112565040588379 7.375652313232422 4.442784309387207 7.375652313232422 4.850130081176758 L 7.375652313232422 6.325261116027832 C 7.375652313232422 6.732606887817383 7.705871105194092 7.062826156616211 8.113217353820801 7.062826156616211 L 22.86452293395996 7.062826156616211 C 23.2718677520752 7.062826156616211 23.60208702087402 6.732606887817383 23.60208702087402 6.325261116027832 L 23.60208702087402 4.850130081176758 C 23.60208702087402 4.442784309387207 23.2718677520752 4.112565040588379 22.86452293395996 4.112565040588379 Z M 22.86452293395996 11.4882173538208 L 8.113217353820801 11.4882173538208 C 7.705871105194092 11.4882173538208 7.375652313232422 11.81843662261963 7.375652313232422 12.22578239440918 L 7.375652313232422 13.70091247558594 C 7.375652313232422 14.1082592010498 7.705871105194092 14.43847846984863 8.113217353820801 14.43847846984863 L 22.86452293395996 14.43847846984863 C 23.2718677520752 14.43847846984863 23.60208702087402 14.1082592010498 23.60208702087402 13.70091247558594 L 23.60208702087402 12.22578239440918 C 23.60208702087402 11.81843662261963 23.2718677520752 11.4882173538208 22.86452293395996 11.4882173538208 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _shapeSVG_cc88d23a05c9412d8a77adde71c94aa5 =
    '<svg viewBox="168.0 13.0 178.3 607.5" ><path transform="translate(165.0, 593.07)" d="M 5.44266939163208 7.885339260101318 L 3 7.885339260101318 L 3 24.98402786254883 C 3 26.32749557495117 4.099201202392578 27.42669677734375 5.44266939163208 27.42669677734375 L 22.54135894775391 27.42669677734375 L 22.54135894775391 24.98402786254883 L 5.44266939163208 24.98402786254883 L 5.44266939163208 7.885339260101318 Z M 24.98402786254883 3 L 10.3280086517334 3 C 8.984540939331055 3 7.885339260101318 4.099201202392578 7.885339260101318 5.44266939163208 L 7.885339260101318 20.09868812561035 C 7.885339260101318 21.4421558380127 8.984540939331055 22.54135894775391 10.3280086517334 22.54135894775391 L 24.98402786254883 22.54135894775391 C 26.32749557495117 22.54135894775391 27.42669677734375 21.4421558380127 27.42669677734375 20.09868812561035 L 27.42669677734375 5.44266939163208 C 27.42669677734375 4.099201202392578 26.32749557495117 3 24.98402786254883 3 Z M 23.76269340515137 13.9920129776001 L 18.87735366821289 13.9920129776001 L 18.87735366821289 18.87735366821289 L 16.43468284606934 18.87735366821289 L 16.43468284606934 13.9920129776001 L 11.54934406280518 13.9920129776001 L 11.54934406280518 11.54934406280518 L 16.43468284606934 11.54934406280518 L 16.43468284606934 6.664004325866699 L 18.87735366821289 6.664004325866699 L 18.87735366821289 11.54934406280518 L 23.76269340515137 11.54934406280518 L 23.76269340515137 13.9920129776001 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(320.0, 13.0)" d="M 25.90769577026367 23.09368324279785 L 20.79285049438477 17.89277839660645 C 20.56198883056641 17.65803337097168 20.24904441833496 17.52762031555176 19.92070960998535 17.52762031555176 L 19.08448028564453 17.52762031555176 C 20.50042533874512 15.68617725372314 21.3417854309082 13.37002658843994 21.3417854309082 10.85043144226074 C 21.3417854309082 4.856611728668213 16.5655345916748 0 10.6708927154541 0 C 4.776249885559082 0 0 4.856611728668213 0 10.85043144226074 C 0 16.84425163269043 4.776250839233398 21.70086288452148 10.6708927154541 21.70086288452148 C 13.14879703521729 21.70086288452148 15.42662239074707 20.8453483581543 17.23759651184082 19.40558052062988 L 17.23759651184082 20.25587844848633 C 17.23759651184082 20.58973693847656 17.36585235595703 20.9079475402832 17.59671211242676 21.14269256591797 L 22.7115592956543 26.34359550476074 C 23.19380187988281 26.83395195007324 23.97359848022461 26.83395195007324 24.45070838928223 26.34359550476074 L 25.90256690979004 24.8673095703125 C 26.38480949401855 24.376953125 26.38480949401855 23.58403968811035 25.90769577026367 23.09368133544922 Z M 10.6708927154541 17.52762031555176 C 7.043815135955811 17.52762031555176 4.104189395904541 14.54375171661377 4.104189395904541 10.85043144226074 C 4.104189395904541 7.162327766418457 7.038685321807861 4.173243045806885 10.6708927154541 4.173243045806885 C 14.29797077178955 4.173243045806885 17.23759651184082 7.157112121582031 17.23759651184082 10.85043144226074 C 17.23759651184082 14.53853511810303 14.3031005859375 17.52762031555176 10.6708927154541 17.52762031555176 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
