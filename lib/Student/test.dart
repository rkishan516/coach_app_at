import 'dart:async';
import 'dart:io' show Platform;
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/google_pay_constants.dart'
    as google_pay_constants;
import 'dart:io';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

String squareApplicationId = 'sandbox-sq0idb-sKaId-7Z8O74_Lh1sR-T_g';
String squareLocationId = 'X9XWRESTK1CZ1';
String applePayMerchantId = '';

class InApp extends StatefulWidget {
  @override
  _InAppState createState() => new _InAppState();
}

class _InAppState extends State<InApp> {
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;
  final List<String> _productLists = Platform.isAndroid
      ? [
          'android.test.purchased',
          'point_1000',
          '5000_point',
          'android.test.canceled',
        ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  List<Widget> _renderInApps() {
    List<Widget> widgets = this
        ._items
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.orange,
                      onPressed: () {
                        print("---------- Buy Item Button Pressed");
                        this._requestPurchase(item);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 48.0,
                              alignment: Alignment(-1.0, 0.0),
                              child: Text('Buy Item'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  List<Widget> _renderPurchases() {
    List<Widget> widgets = this
        ._purchases
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 20;
    double buttonWidth = (screenWidth / 3) - 20;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Running on: $_platformVersion\n',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: buttonWidth,
                          height: 60.0,
                          margin: EdgeInsets.all(7.0),
                          child: FlatButton(
                            color: Colors.amber,
                            padding: EdgeInsets.all(0.0),
                            onPressed: () async {
                              print(
                                  "---------- Connect Billing Button Pressed");
                              await FlutterInappPurchase
                                  .instance.initConnection;
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment(0.0, 0.0),
                              child: Text(
                                'Connect Billing',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: buttonWidth,
                          height: 60.0,
                          margin: EdgeInsets.all(7.0),
                          child: FlatButton(
                            color: Colors.amber,
                            padding: EdgeInsets.all(0.0),
                            onPressed: () async {
                              print("---------- End Connection Button Pressed");
                              await FlutterInappPurchase.instance.endConnection;
                              if (_purchaseUpdatedSubscription != null) {
                                _purchaseUpdatedSubscription.cancel();
                                _purchaseUpdatedSubscription = null;
                              }
                              if (_purchaseErrorSubscription != null) {
                                _purchaseErrorSubscription.cancel();
                                _purchaseErrorSubscription = null;
                              }
                              setState(() {
                                this._items = [];
                                this._purchases = [];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: Alignment(0.0, 0.0),
                              child: Text(
                                'End Connection',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              width: buttonWidth,
                              height: 60.0,
                              margin: EdgeInsets.all(7.0),
                              child: FlatButton(
                                color: Colors.green,
                                padding: EdgeInsets.all(0.0),
                                onPressed: () {
                                  print("---------- Get Items Button Pressed");
                                  this._getProduct();
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  alignment: Alignment(0.0, 0.0),
                                  child: Text(
                                    'Get Items',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                              width: buttonWidth,
                              height: 60.0,
                              margin: EdgeInsets.all(7.0),
                              child: FlatButton(
                                color: Colors.green,
                                padding: EdgeInsets.all(0.0),
                                onPressed: () {
                                  print(
                                      "---------- Get Purchases Button Pressed");
                                  this._getPurchases();
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  alignment: Alignment(0.0, 0.0),
                                  child: Text(
                                    'Get Purchases',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                              width: buttonWidth,
                              height: 60.0,
                              margin: EdgeInsets.all(7.0),
                              child: FlatButton(
                                color: Colors.green,
                                padding: EdgeInsets.all(0.0),
                                onPressed: () {
                                  print(
                                      "---------- Get Purchase History Button Pressed");
                                  this._getPurchaseHistory();
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  alignment: Alignment(0.0, 0.0),
                                  child: Text(
                                    'Get Purchase History',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              )),
                        ]),
                  ],
                ),
                Column(
                  children: this._renderInApps(),
                ),
                Column(
                  children: this._renderPurchases(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SquarePayment extends StatefulWidget {
  @override
  _SquarePaymentState createState() => _SquarePaymentState();
}

class _SquarePaymentState extends State<SquarePayment> {
  @override
  void initState() {
    _initSquarePayment();
    super.initState();
  }

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(squareApplicationId);
  }

  Future<void> _onStartCardEntryFlow() async {
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow);
  }

  /**
  * Callback when card entry is cancelled and UI is closed
  */
  void _onCancelCardEntryFlow() {
    // Handle the cancel callback
  }

  /**
  * Callback when successfully get the card nonce details for processig
  * card entry is still open and waiting for processing card nonce details
  */
  void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
    try {
      // take payment with the card nonce details
      // you can take a charge
      // await chargeCard(result);

      // payment finished successfully
      // you must call this method to close card entry
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
    } on Exception catch (ex) {
      // payment failed to complete due to error
      // notify card entry to show processing error
      InAppPayments.showCardNonceProcessingError('message');
    }
  }

  /**
  * Callback when the card entry is closed after call 'completeCardEntry'
  */
  void _onCardEntryComplete() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomePage()));
    // Update UI to notify user that the payment flow is finished successfully
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: _onStartCardEntryFlow,
          child: Text('Press for try Payment'),
        ),
      ),
    );
  }
}
