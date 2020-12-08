import 'package:flutter/material.dart';
import 'landingPage.dart';
void main() => runApp(new StartFunds());
class StartFunds extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Starting Funds Page",
        home: new Material(
            child: new Container (
                padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                child: new Container(
                  child: new Center(
                      child: new Column(
                          children : [
                            new Padding(padding: EdgeInsets.only(top: 140.0)),
                            new Text('Enter Starting Amount',
                              style: new TextStyle(color: hexToColor("#F2A03D"), fontSize: 25.0),),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: 'Recommended 5000 Dollars',
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if(val.length==0) {
                                  return "Email cannot be empty";
                                }else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LandingPage()),
                              );},
                              child: const Text('Begin Your Stock Adventure', style: TextStyle(fontSize: 20)),
                              color: Colors.blue,
                              textColor: Colors.white,
                              elevation: 5,
                            )
                          ]
                      )
                  ),
                )
            )
        )
    );
  }
}