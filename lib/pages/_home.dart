import 'dart:async';
import 'package:card_holder_app_with_kistik_love/widgets/bottom_dialog_window.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:flutter/widgets.dart';
import 'package:card_holder_app_with_kistik_love/widgets/home_drawer.dart';

import 'package:card_holder_app_with_kistik_love/widgets/card.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAvailable = false;
  StreamSubscription? nfcChecker;
  List<int> card = [1, 2, 3];

  Widget _buildItemList(BuildContext context, int index) {
    if (index == card.length)
      return SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    return cardmaket();
  }

  Stream<bool> streamGenerator() async* {
    for (int i = 0; i > -1; i++) {
      await Future.delayed(const Duration(seconds: 3));
      yield await NfcManager.instance.isAvailable();
    }
  }

  @override
  void initState() {
    NfcManager.instance.isAvailable().then((value) => setState(() {
          isAvailable = value;
        }));

    nfcChecker = streamGenerator().listen((event) {
      setState(() {
        isAvailable = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nfcChecker!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF445671),
          ),
          drawer: HomeDrawer(),
          backgroundColor: Color(0xFF445671),
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.only(bottom: 220),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Container(
                  child: Stack(
                    children: [
                      Image.asset('img/nfc.png', color: Colors.white),
                    ]
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(
                  isAvailable
                      ? 'Поднесите устройство к терминалу'
                      : 'NFC недоступно на вашем устройстве или выключено',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Expanded(
                  child: ScrollSnapList(
                    itemBuilder: _buildItemList,
                    itemCount: card.length,
                    itemSize: 350,
                    dynamicItemSize: true,
                    onItemFocus: (int) {},
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 350,
                        height: 35,
                        padding: EdgeInsets.only(left: 25),
                        child: ElevatedButton(
                          onPressed: () {
                            _showModalBottomSheet();
                          },
                          child: Text('Добавить карту'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                            primary: Color(0xffA39BFF),
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 45,
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Информация о карте'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                            primary: Color(0xff6BBB7C),
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return bottom_dialog_window();
      },
    );
  }
}