import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypersonalconcierge/components/displayimage.dart';
import '../components/button.dart';
import '../utils/authutil.dart';
import '../utils/constant.dart';
import 'editimage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  //final _auth = FirebaseAuth.instance;
  String imageprofile = 'assets/cropped-logo.png';
  String namecustomer = 'NN';
  String email = '';
  String password = '';
  bool isloading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3E1F92),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                color: const Color(0xFF3E1F92),
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () async {
                            //navigateSecondPage(EditIamge());
                            var result = await Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return EditImage(imageuser: "assets/cropped-logo.png");
                                }
                            ));
                            setState(() {
                              imageprofile = result; //update the returndata with the return result,
                              //update UI with setState()
                            });
                          },
                          child: DisplayImage(
                            imagePath: imageprofile,
                            onPressed: () {},
                          )),
                      const SizedBox(height: 30),
                      const Hero(
                        tag: '1',
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        onChanged: (value) {
                          namecustomer = value.toString().trim();
                          setState(() {
                          });

                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter your name'
                            : null,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your Name',
                          hintStyle:
                          const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.face,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter email'
                            : null,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your Email',
                          hintStyle:
                          const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Choose a Password',
                            hintStyle:
                            const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 80),
                      ElevateGenericButton(
                        title: 'Register',
                        ontapp: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            User? user = await FireAuth
                                .registerUsingEmailPassword(
                              name: namecustomer,
                              email: email,
                              password:
                              password,
                            );

                            setState(() {
                              isloading = false;
                            });
                            if (user != null) {
                              Navigator.of(context)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                  LoginScreen(),
                                ),
                                ModalRoute.withName('/'),
                              );
                            }
                          }
                        },
                      ),
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

  Future<dynamic> onGoBack(dynamic value) async {
    setState(() {});
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
