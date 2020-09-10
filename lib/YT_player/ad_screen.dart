import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const String testDevice = "BCC52FD9D88E15E383AEAD29E916C3F1";

class MobileAd extends StatefulWidget {
  @override
  _MobileAdState createState() => _MobileAdState();
}

class _MobileAdState extends State<MobileAd> {
  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>[
      'Education',
      'Technology',
      'Career',
      'news',
      'cricket',
      'current affairs',
      'business',
      'success stories',
      'motivation',
      'concentration',
      'exercise',
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
      'focus'
    ],
    childDirected: true,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-9529467099496606/1080207528",
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9529467099496606~5774987233");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app Test'),
      ),
      body: Center(
        child: Text('what is this'),
      ),
    );
  }
}
