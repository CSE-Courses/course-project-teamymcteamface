//import 'package:flutter/foundation.dart';
import 'dart:async';
import 'buySell.dart';
import 'stockPrice.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'stock_ticker.dart';

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


var currentStockPrice;
var stockprices;

 
         Future<String> getData() async {
    var response = await http.get(
        'https://finnhub.io/api/v1/quote?symbol=' + widget.stockName + '&token=bug8dff48v6qf6lcdlq0',
        headers: {
          "Accept": "application/json"
        });
    this.setState(() {
    stockprices = stockPriceFromJson(response.body);
    currentStockPrice = stockprices.c;
    });

  }


  @override
  void initState() {
    this.getData();
    super.initState();

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.stockName}"),
        backgroundColor: Colors.black,
        actions: <Widget>[
     ButtonTheme(
                    minWidth: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                         Navigator.pop(context);
                        Navigator.of(context).push(
                        MaterialPageRoute(
                          settings: RouteSettings(name: "/BuySell"),
                          builder: (context) {
                            return BuySell(stockPrice: currentStockPrice);
                           },
                        ),
                      );
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('BUY', style: TextStyle(fontSize: 10)),
                    ),
                  ),
  ],  
      ),
    body: WebviewScaffold(
      url: "https://in.tradingview.com/chart/?symbol=" + widget.stockName,
      withJavascript: true,
      withZoom: true,
     
    ),
    );
  }
}
