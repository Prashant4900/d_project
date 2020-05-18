import 'dart:convert';

import 'package:d_project/screens/paymentDoneScreen.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:random_string/random_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:d_project/Constants..dart';

String HashCode = "";

class PaymentScreen extends StatefulWidget {
  PaymentScreen({
    this.orderId,
    this.userId,
    this.amount,
  });

  String orderId;
  String userId;
  String amount;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  UserData userData = UserData();
  String Hash;

  @override
  void initState(){
    navigateToOtherPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: screenWidth(context, dividedBy: 2),
            height: screenWidth(context, dividedBy: 2),
            child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> createHash() async{
    final response = await http.post(PAYMENT_URL, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "amount": widget.amount,
      "order_id": widget.orderId,
      "customer_id": widget.userId
    });
    var data = json.decode(response.body);
    var hash = data['CHECKSUMHASH'];
    Hash = hash;
    print(hash);
    print(hash.length);
  }

  Future<bool> updateOrdertoServer() async{
      var url = 'http://13.127.202.246/api/create_order';
      var response = await http.post(url, body: {
        "amount" : widget.amount,
        "order_id" : widget.orderId,
        "name" : userData.name != null ? userData.name : "No Name",
        "phone" : userData.phoneNo,
        "house_no" : userData.selectedAddress.houseNumber,
        "apartment" : userData.selectedAddress.apartmentName,
        "street" : userData.selectedAddress.streetDetails,
        "area" : userData.selectedAddress.areaDetails,
        "city" : userData.selectedAddress.city,
        "zip_code" : userData.selectedAddress.pinCode.toString(),
        "address_type" : userData.selectedAddress.addressType,
        "user_id" : userData.userid,
        "payment_mode": "ONLINE"
      });
      var data = json.decode(response.body.toString());
      print(data);
      print(data["error"]);
      if(data["error"] == false || data["error"] == "false"){
        return true;
      }
      else{
        return false;
      }
  }

  void navigateToOtherPage() async{
    bool createOrder = await updateOrdertoServer();
    var a = await createHash();
    if(Hash.length > 100 && createOrder == true){
      Navigator.pushReplacement(context,MaterialPageRoute(
        builder: (context) => PaymentSuccessfulScreen(orderId: widget.orderId, amount: widget.amount, userId: widget.userId,hashprime: Hash,),
      ));
    }
  }
}

class PaymentSuccessfulScreen extends StatefulWidget {

  PaymentSuccessfulScreen({
    this.orderId,
    this.userId,
    this.amount,
    this.hashprime,
});

  String orderId;
  String userId;
  String amount;
  String hashprime;
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
      var decodedJSON = jsonDecode(data);
      print(decodedJSON);
      final error = decodedJSON["error"];
      final order_id = decodedJSON["order_id"];
      print(error);
      if (error == "false") {
        print("Success");
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PaymentDoneScreen(success : true, orderId: order_id, amount: widget.amount,customerId: widget.userId, type: "ONLINE",),
        ));
        dispose();
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PaymentDoneScreen(success : false),
        ));
        dispose();
      }
      this.setState((){});
    });
  }





  WebViewController _webController;


  bool loading = true;



  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'><h1>Redirecting to Payment Gateway</h1> <form id='f' name='f' method='post' action='https://securegw-stage.paytm.in/theia/processTransaction'>"
        "<input type='hidden' name='MID' value='hRKZHE36260544645209'/>" +
        "<input  type='hidden' name='ORDER_ID' value='${widget.orderId}' />" +
        "<input  type='hidden' name='TXN_AMOUNT' value='${widget.amount}' />" +
        "<input  type='hidden' name='CUST_ID' value='${widget.userId}' />" +
        "<input  type='hidden' name='INDUSTRY_TYPE_ID' value='Retail' />" +
        "<input  type='hidden' name='WEBSITE' value='WEBSTAGING' />" +
        "<input  type='hidden' name='CHANNEL_ID' value='WEB' />" +
        "<input  type='hidden' name='CALLBACK_URL' value='http://13.127.202.246/api/handle_app_request' />" +
        "<input  type='hidden' name='CHECKSUMHASH' value=${widget.hashprime} />" +
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
                _webController = controller;
                _webController.loadUrl(
                    new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                        .toString());
              },
              onPageFinished: (page) {
                if (page.contains("/handle_app_request")){
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

