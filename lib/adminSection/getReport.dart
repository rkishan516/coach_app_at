import 'package:coach_app/Models/model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

Future<String> reportView(Map<String, Branch> branches) async {
  final Document pdf = Document();

  var style = TextStyle(
      font: Font.ttf(await rootBundle.load("assets/icons/Hind-Regular.ttf")));

  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('Report',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text('Report', textScaleFactor: 2), PdfLogo()],
          ),
        ),
        Padding(padding: const EdgeInsets.all(10)),
        Table.fromTextArray(
            cellStyle: style,
            context: context,
            data: [
                  <String>["Branch Name", "Courses", "Students", "Teachers"]
                ] +
                branches
                    .map(
                      (key, value) => MapEntry(
                        key,
                        <String>[
                          value?.name ?? 'No Name',
                          value?.courses?.length?.toString() ?? "0",
                          value?.students?.length?.toString() ?? "0",
                          value?.teachers?.length?.toString() ?? "0",
                        ],
                      ),
                    )
                    .values
                    .toList()),
      ],
    ),
  );
  //save PDF

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  return path;
}
