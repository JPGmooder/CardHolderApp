import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          DrawerHeader(
            duration: Duration(seconds: 3),
            decoration: BoxDecoration(
              color: Color(0xff2B3647),
            ),
            child: ListTile(leading: CircleAvatar(),),
          ),
        ],
      ),
    );
  }
}
