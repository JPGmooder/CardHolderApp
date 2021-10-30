import 'package:card_holder_app_with_kistik_love/pages/_add_bank_cardd.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:flutter/widgets.dart';
import 'package:card_holder_app_with_kistik_love/widgets/home_drawer.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cardholder = 'CARD OWNER';
  String numbercard = '**** **** **** ****';
  String date = '00/00';
  String cvc = '***';

  List<int> card = [1, 2, 3];

  Widget _buildItemList(BuildContext context, int index) {
    if (index == card.length)
      return SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
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
              ),
            ),
          ),
        ],
      ),
    );
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
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Container(
                  child: Image.asset(
                    'img/nfc.png',
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(
                  'Поднесите устройство к терминалу',
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
          // bottomSheet: _showBottomSheet(),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
            ));
      },
    );
  }
}
