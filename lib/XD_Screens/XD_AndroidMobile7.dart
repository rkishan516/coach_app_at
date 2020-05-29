import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:adobe_xd/page_link.dart';
import './XD_AndroidMobile9.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XD_AndroidMobile7 extends StatelessWidget {
  XD_AndroidMobile7({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(81.0, 459.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  duration: 0.3,
                  ease: Curves.easeOut,
                  pageBuilder: () => XD_AndroidMobile9(),
                ),
              ],
              child:
                  // Adobe XD layer: 'images (2)' (shape)
                  Container(
                width: 198.0,
                height: 40.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(''),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(161.0, 72.0),
            child: Text(
              'logo',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(-217.96, -103.4),
            child: SvgPicture.string(
              _shapeSVG_ee8d0cfe28854c5bb49ad75404822da3,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(85.0, 175.0),
            child: Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 47,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(76.0, -6.0),
            child:
                // Adobe XD layer: 'GC' (shape)
                Container(
              width: 209.0,
              height: 209.0,
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

const String _shapeSVG_ee8d0cfe28854c5bb49ad75404822da3 =
    '<svg viewBox="-218.0 -103.4 787.6 969.8" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffffff00"  /><stop offset="1.0" stop-color="#ffff9900"  /></linearGradient></defs><path transform="matrix(-0.956305, 0.292372, -0.292372, -0.956305, 2807.54, -128.85)" d="M 2833.14404296875 -60.62829971313477 C 2833.14404296875 -60.62829971313477 2752.8525390625 -42.60367584228516 2783.986083984375 36.04925918579102 C 2815.11962890625 114.7021942138672 2857.72314453125 111.4249877929688 2857.72314453125 111.4249877929688 C 2857.72314453125 111.4249877929688 2915.07421875 124.5337982177734 2915.07421875 150.7514495849609 C 2915.07421875 176.9691009521484 2956.039306640625 214.6569519042969 2962.59375 213.0183563232422 C 2969.148193359375 211.3797607421875 3098.597900390625 98.316162109375 3098.597900390625 73.73712158203125 C 3098.597900390625 49.1580810546875 2915.07421875 -93.40036010742188 2915.07421875 -93.40036010742188 L 2833.14404296875 -60.62829971313477 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ffffff00"  /><stop offset="1.0" stop-color="#ffff9900"  /></linearGradient></defs><path transform="translate(-2529.0, -10.0)" d="M 2833.14404296875 -60.62829971313477 C 2833.14404296875 -60.62829971313477 2752.8525390625 -42.60367584228516 2783.986083984375 36.04925918579102 C 2815.11962890625 114.7021942138672 2857.72314453125 111.4249877929688 2857.72314453125 111.4249877929688 C 2857.72314453125 111.4249877929688 2915.07421875 124.5337982177734 2915.07421875 150.7514495849609 C 2915.07421875 176.9691009521484 2956.039306640625 214.6569519042969 2962.59375 213.0183563232422 C 2969.148193359375 211.3797607421875 3098.597900390625 98.316162109375 3098.597900390625 73.73712158203125 C 3098.597900390625 49.1580810546875 2915.07421875 -93.40036010742188 2915.07421875 -93.40036010742188 L 2833.14404296875 -60.62829971313477 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
