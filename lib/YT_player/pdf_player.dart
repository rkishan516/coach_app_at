import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:path_provider/path_provider.dart';

class PDFPlayer extends StatefulWidget {
  final String link;
  PDFPlayer({this.link});
  @override
  _PDFPlayerState createState() => _PDFPlayerState();
}

class _PDFPlayerState extends State<PDFPlayer> {
  String path;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get('${widget.link}');
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  loadPdf() async {
    writeCounter(await fetchPost());
    path = (await _localFile).path;

    if (!mounted) return;

    setState(() {});
  }
  @override
  void initState() {
    loadPdf();
    super.initState();
  }

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
        child: (path != null)
            ? PdfViewer(
                filePath: path,
              )
            : Card(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PlaceholderLines(
                    count: 20,
                    animate: true,
                  ),
                ),
              ),
      ),
    );
  }
}
