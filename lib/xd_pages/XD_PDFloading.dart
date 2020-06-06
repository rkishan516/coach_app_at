import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XD_PDFloading extends StatelessWidget {
  XD_PDFloading({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
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
            offset: Offset(118.0, 365.0),
            child: Text(
              'Loading PDF...',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(162.5, 302.5),
            child:
                // Adobe XD layer: 'Icon feather-refres…' (group)
                Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(1.5, 4.5),
                  child: SvgPicture.string(
                    _svg_bp5oiq,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ],
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

const String _svg_qzyylc =
    '<svg viewBox="16.0 13.0 31.4 22.0" ><path transform="translate(11.5, 4.0)" d="M 4.5 30.9759521484375 L 35.869384765625 30.9759521484375 L 35.869384765625 27.31329154968262 L 4.5 27.31329154968262 L 4.5 30.9759521484375 Z M 4.5 21.81930541992188 L 35.869384765625 21.81930541992188 L 35.869384765625 18.15664672851563 L 4.5 18.15664672851563 L 4.5 21.81930541992188 Z M 4.5 9 L 4.5 12.66265773773193 L 35.869384765625 12.66265773773193 L 35.869384765625 9 L 4.5 9 Z" fill="#7b7b7b" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_bp5oiq =
    '<svg viewBox="1.5 4.5 33.0 27.0" ><path  d="M 1.5 6 L 1.5 15 L 10.5 15" fill="none" stroke="#434343" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /><path  d="M 34.5 30 L 34.5 21 L 25.5 21" fill="none" stroke="#434343" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /><path  d="M 30.73500061035156 13.5 C 29.18867492675781 9.130218505859375 25.50859832763672 5.85932731628418 20.98756790161133 4.836387634277344 C 16.46653938293457 3.813446998596191 11.73683738708496 5.1815185546875 8.459999084472656 8.459999084472656 L 1.5 15 M 34.5 21 L 27.54000091552734 27.54000091552734 C 24.26316452026367 30.81848526000977 19.53346061706543 32.18655776977539 15.01243114471436 31.16361808776855 C 10.49140167236328 30.14067840576172 6.811324119567871 26.86978721618652 5.26500129699707 22.50000381469727" fill="none" stroke="#434343" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
