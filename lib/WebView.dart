//import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPageView extends StatefulWidget {
  final String stockName;
  WebPageView({this.stockName});
  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  @override
  Widget build(BuildContext context) {


    return WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=" + widget.stockName,
      withJavascript: true,
      withZoom: true,
      appBar: AppBar(
        title: Text("${widget.stockName}"),
        backgroundColor: Colors.black,
      ),
    );
  }
}