import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PDFPlayer extends StatefulWidget {
  final String link;
  PDFPlayer({this.link});
  @override
  _PDFPlayerState createState() => _PDFPlayerState();
}

class _PDFPlayerState extends State<PDFPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(
                2,
                4,
              ),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff519ddb),
              Color(0xff54d179),
            ],
          ),
        ),
        child: WebView(
          initialUrl:
              'https://docs.google.com/gview?embedded=true&url=${widget.link}',
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onWebViewCreated: (cntlr) {},
        ),
      ),
    );
  }
}
