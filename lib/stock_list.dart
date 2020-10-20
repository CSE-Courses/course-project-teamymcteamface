import 'package:flutter/material.dart';

import 'models/stock.dart';

class StockList extends StatelessWidget{

  final List<Stock> stocks;
  StockList({this.stocks});




  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index){
          return Divider(color: Colors.grey[400]);
        },
        itemCount: stocks.length,
        itemBuilder: (context, index){
          final stock = stocks[index];

          return ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${stock.symbol}",
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
                  Text("${stock.company}",
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
  }}