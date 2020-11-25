import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PDFPlayer extends StatefulWidget {
  final String link;
  PDFPlayer({this.link});

  @override
  _PDFPlayerState createState() => _PDFPlayerState();
}

class _PDFPlayerState extends State<PDFPlayer> {
  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    keywords: <String>[
      // 'Education',
      'Technology',
      // 'Career',
      'news',
      'cricket',
      'current affairs',
      'business',
      'success stories',
      'motivation',
      // 'concentration',
      'exercise',
      'fitness',
      'workout',
      'fun facts',
      'nature',
      'robots',
      'mobiles',
      'cars',
      'rockets',
      'space',
      'science',
      'maths',
      'biology',
      'geography',
      'english',
      'vocabulary',
      'grammar',
      'spoken english',
      'army',
      'gamees',
      'adventure',
      // 'focus'
    ],
    childDirected: true,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-9529467099496606/3258157614",
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9529467099496606~5774987233");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  InAppWebViewController controller;

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
              color: GuruCoolLightColor.backgroundShade,
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
          initialUrl: widget.link,
          // 'https://docs.google.com/gview?embedded=true&url=${widget.link}',
          onWebViewCreated: (cntlr) {
            controller = cntlr;
          },
        ),
      ),
    );
  }
}
