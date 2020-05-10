import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:d_project/Constants..dart';

String HashCode = "";

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
//  WebViewController _webController;
//  bool _loadingPayment = true;
//  String _responseStatus = STATUS_LOADING;
//
//
//  String _loadHTML() {
//    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='$PAYMENT_URL'>"
//        "<input type='hidden' name='order_id' value='ORDER_${ORDER_DATA["order_id"]}'/>" +
//        "<input  type='hidden' name='customer_id' value='${ORDER_DATA["custID"]}' />" +
//        "<input  type='hidden' name='amount' value='${ORDER_DATA["amount"]}' />" +
//        "</form> </body> </html>";
//  }
//
//  void getData() {
//    _webController.evaluateJavascript("document.body.innerText").then((data) {
//      print(data);
//      var decodedJSON = jsonDecode(data);
//      print(decodedJSON);
//      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
//      final error = responseJSON["error"];
//      final checkSumHash = responseJSON["data"];
//      if (error != false) {
//          _responseStatus = STATUS_SUCCESSFUL;
//      } else {
//        _responseStatus = STATUS_FAILED;
//      }
//      this.setState((){});
//    });
//  }
//
//  Widget getResponseScreen() {
//    switch (_responseStatus) {
//      case STATUS_SUCCESSFUL:
//        return PaymentSuccessfulScreen();
//      case STATUS_CHECKSUM_FAILED:
//        return CheckSumFailedScreen();
//      case STATUS_FAILED:
//        return PaymentFailedScreen();
//    }
//    return PaymentSuccessfulScreen();
//  }
//
//  @override
//  void dispose() {
//    _webController = null;
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
              children: <Widget>[
                Text(HashCode),
                RaisedButton(
                  child: Text("Get Hash Code"),
                  onPressed: () async {
                    final response = await http.post(PAYMENT_URL, headers: {
                      "Content-Type": "application/x-www-form-urlencoded"
                    }, body: {
                      "amount": "20.0",
                      "order_id": "test1234",
                      "customer_id": "1"
                    });
                    var data = json.decode(response.body);
                    var hash = data['CHECKSUMHASH'];
                    setState(() {
                      HashCode = hash;
                    });
                    return PaymentSuccessfulScreen();
                  },
                ),
              ],
            )),

//          body: Stack(
//            children: <Widget>[
//              Container(
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
//                child: WebView(
//                  debuggingEnabled: false,
//                  javascriptMode: JavascriptMode.unrestricted,
//                  onWebViewCreated: (controller){
//                    _webController = controller;
//                    _webController
//                        .loadUrl(new Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString());
//                  },
//                  onPageFinished: (page){
//                    if (page.contains("/process")) {
//                      if (_loadingPayment) {
//                        this.setState(() {
//                          _loadingPayment = false;
//                        });
//                      }
//                    }
//                    if (page.contains("/paymentReceipt")) {
//                      getData();
//                    }
//                  },
//                ),
//              ),
//              (_loadingPayment)
//                  ? Center(
//                child: CircularProgressIndicator(),
//              )
//                  : Center(),
//              (_responseStatus != STATUS_LOADING) ? Center(child:getResponseScreen()) : Center()
//            ],
//          )
      ),
    );
  }
}

class PaymentSuccessfulScreen extends StatefulWidget {
  @override
  _PaymentSuccessfulScreenState createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) {
      print(data);
      var first = data.split("{");
      var second = first[1].split("}");
      data = second[0];
      data = data.replaceAll("\\n", "");
      data = data.replaceAll("\\", "");
      data = "{" + data + "}";
      print(data);
      var decodedJSON = jsonDecode(data);
      print(decodedJSON);
      final error = decodedJSON["error"];
      final order_id = decodedJSON["order_id"];
      if (error != false) {
        print("Success");
        dispose();
      } else {
        print("Unsucessful");
      }
      this.setState((){});
    });
  }



  WebViewController _webController;

  String hashPrime;

  Future<void> createHash() async{
    final response = await http.post(PAYMENT_URL, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "amount": '20.00',
      "order_id": 'this12w345689',
      "customer_id": '1'
    });
    var data = json.decode(response.body);
    var hash = data['CHECKSUMHASH'];
    hashPrime = hash;
    print(hashPrime);
    print(hashPrime.length);
  }

  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='https://securegw-stage.paytm.in/theia/processTransaction'>"
        "<input type='hidden' name='MID' value='hRKZHE36260544645209'/>" +
        "<input  type='hidden' name='ORDER_ID' value='this12w345689' />" +
        "<input  type='hidden' name='TXN_AMOUNT' value='20.00' />" +
        "<input  type='hidden' name='CUST_ID' value='1' />" +
        "<input  type='hidden' name='INDUSTRY_TYPE_ID' value='Retail' />" +
        "<input  type='hidden' name='WEBSITE' value='WEBSTAGING' />" +
        "<input  type='hidden' name='CHANNEL_ID' value='WEB' />" +
        "<input  type='hidden' name='CALLBACK_URL' value='http://13.127.202.246/api/handle_app_request' />" +
        "<input  type='hidden' name='CHECKSUMHASH' value=$hashPrime />" +
        "</form> </body> </html>";
  }

  @override
  void dispose() {
    super.dispose();
    _webController = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              debuggingEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async{
                await createHash();
                _webController = controller;
                _webController.loadUrl(
                    new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                        .toString());
              },
              onPageFinished: (page) {
                print(page);
                if (page.contains("/handle_app_request")){
                  print("This triggered");
                  print(_webController.toString());
                  getData();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

