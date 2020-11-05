import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'stock_ticker.dart';

class StockList extends StatefulWidget {
  @override
  _StockList createState() => _StockList();
}

class _StockList extends State<StockList>{

  var stockTicker;

  Future<String> getData() async {
    var response = await http.get('https://finnhub.io/api/v1/stock/symbol?exchange=US&token=bug8dff48v6qf6lcdlq0',
        headers: {
          "Accept": "application/json"

        });
    this.setState(() {
      stockTicker = stockTickerFromJson(response.body);
    });

  }


  @override
  void initState() {
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index){
          return Divider(color: Colors.grey[400]);
        },
        itemCount: stockTicker == null ? 0 : stockTicker.length,
        itemBuilder: (context, index){

          final stock = stockTicker[index];

          return ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${stock.symbol}",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
                  Text("${stock.description}",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  ButtonTheme(
                    minWidth: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Follow', style: TextStyle(fontSize: 10)),
                    ),
                  ),


                ]),
            trailing: Column(children: <Widget>[
              Text("${stock.symbol}",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
              Container(
                width: 70,
                height: 20,
                child: Text("-1.09%", style: TextStyle(color: Colors.white)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red
                ),
              )
            ],),
          );
        }
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }}