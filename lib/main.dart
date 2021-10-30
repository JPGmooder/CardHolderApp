import 'package:cardholderapp/logic/bloc/authentification/authentification_bloc.dart';
import 'package:cardholderapp/view/authentificationtest.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: BlocProvider(
          create: (context) => AuthentificationBloc(),
          child: BodyWidget(), // * Тестовый виджет для проверки авторизации
        ),
      ),
    );
  }
}


