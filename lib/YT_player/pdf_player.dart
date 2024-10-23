import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PDFPlayer extends StatefulWidget {
  final String link;
  PDFPlayer({required this.link});

  @override
  _PDFPlayerState createState() => _PDFPlayerState();
}

class _PDFPlayerState extends State<PDFPlayer> {
  late InAppWebViewController controller;

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
        ),
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.link)),
          // 'https://docs.google.com/gview?embedded=true&url=${widget.link}',
          onWebViewCreated: (cntlr) {
            controller = cntlr;
          },
        ),
      ),
    );
  }
}
