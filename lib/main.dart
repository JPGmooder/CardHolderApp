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
  String cvc = '***';
  bool _isObscureForNumberCard = true;
  bool _isObscureForCvcCard = true;
  int ColorCard = 0xffFF7B7B; //фича пока не работает

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Карточки',
      home: Scaffold(
        backgroundColor: Color(0xff445671),
        resizeToAvoidBottomInset: false,
        body: Center(
            child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 10,
                  color: Color(0xffFF7B7B),
                  child: Container(
                    width: 350,
                    height: 200,
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                'img/chip.png',
                                color: Colors.white,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 200),
                            // ),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.edit, color: Colors.white),
                            // ), //фича пока не работает
                          ],
                        ),
                        Text(
                          numbercard.replaceAll(RegExp(r'.(?=.{15})'), '*'),
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
                        Row(
                          children: [
                            Text(
                              cardholder,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                            ),
                            Text(
                              'CVC',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Text(
                              cvc.replaceAll(RegExp(r'.(?=.{0})'), '*'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  obscureText: _isObscureForNumberCard,
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
                    labelText: 'Номер',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscureForNumberCard = !_isObscureForNumberCard;
                        });
                      },
                      icon: Icon(
                        _isObscureForNumberCard
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      maxLength: 25,
                      style: TextStyle(color: Colors.white),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-z+|\s]'))
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Владелец карты',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 160,
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
                            labelText: 'Дата',
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
                      SizedBox(
                        width: 160,
                        child: TextField(
                          obscureText: _isObscureForCvcCard,
                          style: TextStyle(color: Colors.white),
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Cvc',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscureForCvcCard = !_isObscureForCvcCard;
                                });
                              },
                              icon: Icon(
                                _isObscureForCvcCard
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              cvc = val.toUpperCase();
                              if (val == '') {
                                cvc = '***';
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                //пока не работает
                width: 350,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Добавить карту'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      primary: Color(0xffA39BFF),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
