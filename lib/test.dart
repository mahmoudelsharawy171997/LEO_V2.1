import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({Key key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {

  bool _canShowButton = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  //color: Colors.white,
                  height: 200.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('https://picsum.photos/250?image=10'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ///if the show button is false
              !_canShowButton
                  ? const SizedBox.shrink()
                  : RaisedButton(
                child: Text('Login'),
                textColor: Colors.white,
                elevation: 7.0,
                color: Colors.blue,
                onPressed: () {
                  hideWidget();
                  //_number();
                },
              ),
            ],
          )),
    );
  }
}
