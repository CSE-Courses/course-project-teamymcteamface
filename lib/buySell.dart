import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NavPage.dart';
import 'firebase_auth.dart';

// void main() => runApp(MyStatefulWidget());
final amountController = TextEditingController();
int total;

// class BuySell extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyStatefulWidget(),
//     );
//   }
// }

class BuySell extends StatefulWidget {
   final double stockPrice;
  BuySell({this.stockPrice});

  @override
  _BuySell createState() => _BuySell();
}

TextEditingController augment = TextEditingController();
TextEditingController augmentTotal = TextEditingController();

@override
void initState() {
  initState();
  augment.text = "0"; // Setting the initial value for the field.
}

class _BuySell extends State<BuySell> {
  @override
  Widget build(BuildContext context) {
    var balance = 0.0;
    final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("users/$currUID");

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Column(children: <Widget>[
            FutureBuilder(
                future: dbRef.once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> values = snapshot.data.value;
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Name: " + values["name"]),
                          Text("Balance: \$" + values["balance"].toString()),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }
            ),
            SizedBox(height: 50),
            Text("${widget.stockPrice}"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  width: 60.0,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          controller: augment,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        height: 38.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.arrow_drop_up,
                                  size: 18.0,
                                ),
                                onTap: () {
                                  int currentValue = int.parse(augment.text);
                                  setState(() {
                                    currentValue++;
                                    augment.text = (currentValue)
                                        .toString(); // incrementing value
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 18.0,
                              ),
                              onTap: () {
                                int currentValue = int.parse(augment.text);

                                setState(() {
                                  currentValue--;
                                  // total = int.parse(amountController.text) *
                                  //     int.parse(augment.text);
                                  augmentTotal.text = total.toString();
                                  augment.text =
                                      (currentValue > 0 ? currentValue : 0)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          Container(
              child: Center(
            child: Text("Total Amount is: " + augmentTotal.text),
          )),
          Container(
              height: 38.0,
              child: Center(
                  child: Row(children: <Widget>[
                ButtonTheme(
                    minWidth: 200.0,
                    height: 70.0,
                    child: RaisedButton(
                      // shape: StadiumBorder(),
                      onPressed: () {},
                      child: Text("BUY"),
                    )),
                SizedBox(
                  width: 5,
                ),
                ButtonTheme(
                    minWidth: 200.0,
                    height: 70.0,
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        child: Text('SELL'),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => NavPage()));
                        }))
              ])))
        ]));
  }
}
