import 'package:StockMarketApp/NavPage.dart';
import 'package:flutter/material.dart';
import 'firebase_auth.dart';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
double chooseBalance;

// TextEditingController nameChange = TextEditingController();
// TextEditingController bioChange = TextEditingController();

void main() => runApp(Balance());

class Balance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _BalanceSell createState() => _BalanceSell();
}

class _BalanceSell extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          color: Colors.green,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                    controller: pickBalance,
                    style: style,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Please Enter Amount",
                        hintStyle: TextStyle(color: Colors.white)
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(32.0))
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Balance";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      chooseBalance = double.parse(value.trim());
                    }),

                // Slider(
                //   value: chooseBalance,
                //   onChanged: (value) {
                //     setState(() {
                //       chooseBalance = value;
                //     });
                //   },
                //   label: "$chooseBalance",
                //   activeColor: Colors.blue,
                //   inactiveColor: Colors.black45,
                //   divisions: 250,
                //   min: 0,
                //   max: 25000,
                // ),
                RaisedButton(
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    child: Text('SAVE'),
                    onPressed: () {
                      balanceSetup(double.parse(pickBalance.text));

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return NavPage();
                          },
                        ),
                      );
                    })
              ],
            ),
          )),
    );
  }
}
