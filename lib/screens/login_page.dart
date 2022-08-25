import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypersonalconcierge/components/googlebutton.dart';
import 'package:mypersonalconcierge/screens/home_screen.dart';
import 'package:mypersonalconcierge/screens/register_screen.dart';
import '../components/button.dart';
import '../utils/authutil.dart';
import '../utils/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isloading = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print(user.displayName);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    //context.read<AnalyticsUtils>().setUserLanguage("eSN");
    future: _initializeFirebase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFF3E1F92) ,
        title: const Text(titleApplication),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      //color: const Color(0xFF3E1F92),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              messagesignin,
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Color(0xFF1414D2),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Color(0xFF1414D2)),
                              onChanged: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return messageenteramail;
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: hinttextmail,
                                hintStyle: const TextStyle(color: Color(0xFF1414D2)),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xFF1414D2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return messageenterapassword;
                                }
                              },
                              style: const TextStyle(color: Color(0xFF1414D2)),
                              onChanged: (value) {
                                password = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: hinttextpassword,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF1414D2)),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFF1414D2),
                                  )),
                            ),
                            const SizedBox(height: 80),
                            ElevateGenericButton(
                              title: messagebuttonlogin,
                              ontapp: () async {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  User? user =
                                      await FireAuth.signInUsingEmailPassword(
                                    email: email,
                                    password: password,
                                  );
                                  setState(() {
                                    isloading = false;
                                  });
                                  if (user != null) {
                                    Navigator.of(context)
                                        .pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(user: user),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Ops! Login Failed"),
                                        content: Text("Ops! Login Failed"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const Text('Okay'),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            GoogleButton(
                              title: 'Login',
                              ontapp: () {
                                final snackBar = SnackBar(
                                  content: const Text('Not implemented yet!'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                            const SizedBox(height: 80),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    "Don't have an Account ?",
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xFF1414D2)),
                                  ),
                                  SizedBox(width: 10),
                                  Hero(
                                    tag: '1',
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1414D2)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
