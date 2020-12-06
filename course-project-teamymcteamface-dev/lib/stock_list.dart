import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'stock_ticker.dart';
import 'WebView.dart';
// import 'get_stock_price.dart';

class StockList extends StatefulWidget {
  @override
  _StockList createState() => _StockList();
}

class _StockList extends State<StockList> {
  var mutStockList = List<StockTicker>();
  var stockTicker;

  Future<String> getData() async {
    var response = await http.get(
        'https://finnhub.io/api/v1/stock/symbol?exchange=US&token=bug8dff48v6qf6lcdlq0',
        headers: {"Accept": "application/json"});
    this.setState(() {
      stockTicker = stockTickerFromJson(response.body);
      mutStockList = stockTickerFromJson(response.body);
    });
  }

  // void setCost(){
  //   var x = new getPrice();
  // var y;
  //   stockTicker.forEach((stock) {
  //   x.getStockPrice(stock.symbol);
  //
  //   stock.cost = x.price;
  //
  //   });
  // }

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  void filterSearchResults(String query) {
    List<StockTicker> dummySearchList = List<StockTicker>();
    dummySearchList.addAll(stockTicker);

    if (query.isNotEmpty) {
      List<StockTicker> dummyListData = List<StockTicker>();
      dummySearchList.forEach((item) {
        if (item.description.contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        mutStockList.clear();
        mutStockList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        mutStockList.clear();
        mutStockList.addAll(stockTicker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  hintText: "Search",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
            ),
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey[400]);
                },
                // stockTicker == null ? 0 :
                itemCount: mutStockList == null ? 0 : mutStockList.length,
                itemBuilder: (context, index) {
                  final stock = mutStockList[index];

                  return FlatButton(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${stock.symbol}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500)),
                            Text("${stock.description}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            ButtonTheme(
                              minWidth: 40.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {},
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Text('Follow',
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ),
                          ]),
                      trailing: Column(
                        children: <Widget>[
                          Text("${stock.cost}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            width: 70,
                            height: 20,
                            child: Text("-1.09%",
                                style: TextStyle(color: Colors.white)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new WebPageView(stockName: stock.symbol),
                      ));
                    },
                  );
                }),
          ),
        ]),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
