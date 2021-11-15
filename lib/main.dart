import 'package:card_holder_app_with_kistik_love/logic/bloc/authentification/authentification_bloc.dart';
import 'package:card_holder_app_with_kistik_love/logic/bloc/authentification/authentification_states.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../logic/bloc/authentification/authentification_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/_add_bank_cardd.dart';
import 'pages/_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var usersCollection = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthentificationBloc(usersCollection))],
        child: MaterialApp(title: 'Material App', home: SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthentificationBloc>().logIn();
    sub = BlocProvider.of<AuthentificationBloc>(context)
        .stream
        .listen((state) => state is Authentification_LogedIn_Via_Google
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (ctx) => Home(), settings: RouteSettings()),
              )
            : null);
  }

  @override
  void dispose() {
    sub!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff445671),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('img/logo.png'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Теперь платить - одно касание',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
    );
  }
}
