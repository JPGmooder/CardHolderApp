import 'package:flutter/material.dart';
import 'package:card_holder_app_with_kistik_love/pages/_add_bank_cardd.dart';

class bottom_dialog_window extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Color(0xff2B3647),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Container(
            width: 350,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff445671),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => add_bank_card()));
              },
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    child: Image.asset('img/bankcard.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                  ),
                  Text(
                    'Кредитная или дебетовая карта',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Container(
            width: 350,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff445671),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: Image.asset('img/giftcard.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Text(
                    'Дисконтная карта',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
