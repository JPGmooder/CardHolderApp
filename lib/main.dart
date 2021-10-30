import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:card_holder_app_with_kistik_love/pages/addBankCardd.dart';
import 'package:card_holder_app_with_kistik_love/pages/Home.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/addCardBank': (context) => addBankCard(),
        },
      ),
    );



//for number
