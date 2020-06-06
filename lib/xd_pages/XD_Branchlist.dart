import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/specific_rect_clip.dart';

class XD_Branchlist extends StatelessWidget {
  XD_Branchlist({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Container(
            width: 360.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: const Color(0xffffa500),
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
            offset: Offset(270.0, 8.0),
            child:
                // Adobe XD layer: '8i6e9pyz' (shape)
                Container(
              width: 86.0,
              height: 86.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(43.0, 43.0)),
                image: DecorationImage(
                  image: const NetworkImage(
                      'https://images.unsplash.com/photo-1591286860727-63cdea32f2e8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(62.0, 8.0),
            child: Text(
              'Academy Name',
              style: TextStyle(
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

const String _svg_nol5rc =
    '<svg viewBox="45.1 150.0 119.3 161.2" ><defs><filter id="shadow"><feDropShadow dx="0" dy="6" stdDeviation="9"/></filter></defs><path transform="translate(45.09, 150.0)" d="M 2.379013538360596 0 L 116.9681625366211 0 C 118.2820663452148 0 119.3471755981445 6.367355346679688 119.3471755981445 14.22188758850098 L 119.3471755981445 146.9595031738281 C 119.3471755981445 154.8140258789063 118.2820663452148 161.181396484375 116.9681625366211 161.181396484375 L 2.379013538360596 161.181396484375 C 1.065120458602905 161.181396484375 0 154.8140258789063 0 146.9595031738281 L 0 14.22188758850098 C 0 6.367355346679688 1.065120458602905 0 2.379013538360596 0 Z" fill="#ffa500" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_qzyylc =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
