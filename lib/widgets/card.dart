import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String cardholder;
  final String numbercard;
  final String date;
  final String cvc;
  final String imagePath;
  const CardWidget(
      {required this.cardholder,
      required this.numbercard,
      required this.date,
      required this.cvc,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.fill, )),
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
                            style: TextStyle(fontSize: 10, color: Colors.white),
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
                )),
          ),
        ],
      ),
    );
  }
}
