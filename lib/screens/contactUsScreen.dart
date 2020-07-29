import 'dart:async';

import 'package:d_project/utils/userData.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:url_launcher/url_launcher.dart';


String message = "";

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String callText = "Call us";
  UserData userData = UserData();

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      key: _drawerKey,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text('Contact PurchX Team'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                ShowChild(
                  indicator: Container(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                    width: double.infinity,
                    height: 80.0,
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.mail,
                                color: Colors.deepOrange,
                                size: 35.0,
                              )),
                          VerticalDivider(),
                          Text(
                            "Write to us",
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.deepOrange,
                                    size: 35.0,
                                  )),
                              VerticalDivider(),
                              Text(
                                "Write to us",
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
                          TextField(
                            onChanged: (str){
                              message = str;
                            },
                            minLines: 10,
                            maxLines: 40,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              sendMail(message);
                            },
                            color: Colors.deepOrange,
                            child: Container(
                                height: 40.0,
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white),
                                ))),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    if(userData.secondsRemainingToCall > 0){
                      Timer timer =  new Timer.periodic(new Duration(seconds: 1), (time) {
                        if(userData.secondsRemainingToCall > 0){
                          setState(() {
                            callText = "Calling in " + userData.secondsRemainingToCall.toString() + " seconds";
                          });
                          userData.secondsRemainingToCall--;
                          if(userData.secondsRemainingToCall == 0){
                            setState(() {
                              callText = "Call us now";
                            });
                            time.cancel();
                          }
                        }
                        else{
                          setState(() {
                            callText = "Call us now";
                          });
                          time.cancel();
                        }
                      });
                    }
                    else{
                      setState(() {
                        callText = "Call us now";
                      });
                      print("Calling the number");
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    width: double.infinity,
                    height: 80.0,
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.phone,
                                color: Colors.green,
                                size: 35.0,
                              )),
                          VerticalDivider(),
                          Text(
                            callText,
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('About Pop up'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }
}


sendMail(String msg) async {
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'dorakartinfo@gmail..com',
      queryParameters: {
        'subject': 'Query Regarding PurchX Mobile App',
        'body' : msg
      }
  );
  await launch(_emailLaunchUri.toString());
}