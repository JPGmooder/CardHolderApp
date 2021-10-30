import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:card_holder_app_with_kistik_love/pages/_add_bank_cardd.dart';
import 'package:card_holder_app_with_kistik_love/pages/_home.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/addCardBank': (context) => add_bank_card(),
        },
      ),
    );



//for number
