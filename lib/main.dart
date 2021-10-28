import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

//for number
class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

//for date
class CustomInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class _MyAppState extends State<MyApp> {
  String cardholder = 'CARD OWNER';
  String numbercard = '**** **** **** ****';
  String date = '00/00';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Карточки',
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                child: Card(
                  elevation: 20,
                  color: Colors.redAccent,
                  child: Container(
                    width: 350,
                    height: 200,
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'img/chip.png',
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          numbercard,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'DATE',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                        ),
                        Text(
                          cardholder,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   color: Colors.redAccent,
                    // image: DecorationImage(
                    //   image: AssetImage("img/chip.png"),
                    // ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  maxLength: 19,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    new CustomInputFormatter()
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      numbercard = val.toUpperCase();
                      if (val == '') {
                        numbercard = '**** **** **** ****';
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  maxLength: 25,
                  style: TextStyle(color: Colors.white),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z+|\s]'))
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Card Owner',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      cardholder = val.toUpperCase();
                      if (val == '') {
                        cardholder = 'CARD OWNER';
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  maxLength: 5,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    new CustomInputFormatter2()
                  ],
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Date',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      date = val.toUpperCase();
                      if (val == '') {
                        date = '00/00';
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
