import 'package:flutter/material.dart';
import 'package:mypersonalconcierge/utils/constant.dart';

import '../screens/login_page.dart';
import '../utils/authutil.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/cropped-logo.png'))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'My Perfil',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 35,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.face),
            title: const Text(titleMenuPerfil),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(titleMenuLogout),
            onTap: () async {
              FireAuth.LogoutFromApp();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      ),
    );
  }
}
