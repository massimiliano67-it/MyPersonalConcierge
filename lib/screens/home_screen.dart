import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/navdrawer.dart';
import '../utils/constant.dart';

class HomePage extends StatefulWidget {

  final User user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
          title: const Text(titleApplication),
      ),
      body: const Center(
          child:
          Image(image: AssetImage('assets/cropped-logo.png'))
      ),
    );
  }
}
