import 'dart:async';

import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

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
                  title: Text('Help'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                Container(
                  height: screenHeight(context, dividedBy: 0.2),
                  child: WebView(
                    initialUrl: 'https://purchx.store/faq/',
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
