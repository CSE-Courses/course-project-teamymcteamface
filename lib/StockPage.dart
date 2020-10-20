import 'package:StockMarketApp/stock_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'models/stock.dart';

void main() {
  runApp(StockPage());
}

class StockPage extends StatelessWidget {
  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//         theme: ThemeData(
//           brightness: Brightness.light,
//           primaryColor: Colors.black, //Changing this will change the color of the TabBar
//         ),
//         home: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//     appBar: PreferredSize(
//     preferredSize: Size.fromHeight(50.0),
//         child: AppBar(
//         bottom: TabBar(
//         tabs: [
//               Tab(text: "Home"),
//               Tab(text: "Following"),
//             ],
//           ),
//         ),
//     ),
//         body: TabBarView(
//           children: [
//             new HomePage(),
//            Text("//TO DO"),
//           ],
//         ),
//       ),
//     ));
//   }
//  }
    return MaterialApp(title: "Stocks", home: HomePage());
  }
}

class HomePage extends StatelessWidget {

  final date = DateTime.parse(DateTime.now().toString());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text("Stocks",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
                Text(date.month.toString() + "/" + date.day.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          hintText: "Search",
                          prefix: Icon(Icons.search),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  ),
                ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 270,
                        child: StockList(stocks: Stock.getAll())
                    )
              ])))
    ]));
  }
}
