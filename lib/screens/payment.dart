import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paytm/paytm.dart';
import 'dart:convert';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String payment_response = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Paytm example app'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $payment_response\n'),
              RaisedButton(
                onPressed: () {
                  //Firstly Generate CheckSum bcoz Paytm Require this
                  generateCheckSum();
                },
                color: Colors.blue,
                child: Text(
                  "Pay Now",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void generateCheckSum() async {
    var url =
        'http://13.127.202.246/api/generate_checksum';

    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    //Please use your parameters here
    //CHANNEL_ID etc provided to you by paytm


    final response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "amount" : "10.00",
      "order_id" : orderId,
      "customer_id":"test123434",
    });

    //for Testing(Stagging) use this

    //https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=

    //https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=

    String callBackUrl =
     'http://13.127.202.246/api/' +
         'handle_app_request';

    var hash = json.decode(response.body)["CHECKSUMHASH"];
    print(hash);


    //Parameters are like as per given below

    // Testing (Staging or Production) if true then Stagginh else Production
    // MID provided by paytm
    // ORDERID your system generated order id
    // CUSTOMER ID
    // CHANNEL_ID provided by paytm
    // AMOUNT
    // WEBSITE provided by paytm
    // CallbackURL (As used above)
    // INDUSTRY_TYPE_ID provided by paytm
    // checksum generated now

    //Testing Credentials
    //Mobile number: 7777777777
    //OTP: 489871

    var paytmResponse = Paytm.startPaytmPayment(
        true,
        "hRKZHE36260544645209",
        orderId,
        "test123434",
        "WAP",
        "10.00",
        'WEBSTAGING',
        callBackUrl,
        'Retail',
        hash);

    paytmResponse.then((value) {
      print("Value" + value.toString());
      setState(() {
        payment_response = value.toString();
      });
    });
  }
}