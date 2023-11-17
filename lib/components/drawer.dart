import 'package:flutter/material.dart';

import 'My_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  final void Function()? onSearch;
  //  final void Function()? onLogHours;
  const MyDrawer(
      {super.key,
      required this.onProfileTap,
      required this.onSignOut,
      required this.onSearch
      // required this.onLogHours
      });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 3, 34, 59),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            const DrawerHeader(
                child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            )),
            MyListTile(
              icon: Icons.home,
              text: 'H O M E',
              onTap: () => Navigator.pop(context),
            ),
            //profile list tile
            MyListTile(
                icon: Icons.person, text: 'P R O F I L E', onTap: onProfileTap),
            MyListTile(
                icon: Icons.search, text: 'S E A R C H', onTap: onSearch),
          ],
        ),

        //logout list tile
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: MyListTile(
              icon: Icons.logout, text: 'L O G O U T', onTap: onSignOut),
        ),
      ]),
    );
  }
}
