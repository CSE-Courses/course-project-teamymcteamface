import 'package:flutter/material.dart';

void main() => runApp(StockPage());

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Stocks will go here',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // RaisedButton(
            //   textColor: Colors.white,
            //   color: Colors.redAccent,
            //   child: Text('Back to Main Page'),
            //   onPressed: () {

            //   },
            // )
          ],
        ),
      )),
    );
  }
}
