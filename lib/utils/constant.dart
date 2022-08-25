import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value 1',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
);

const String messagephotoprofile = "Elige una foto para tu perfil";
const String messagebuttonupdate = "Update";
const String messagesignin = "Sign In";
const String messagebuttonlogin = "Login";
const String messageenteramail = "Please enter Email";
const String messageenterapassword = "Please enter password";
const String hinttextmail = "Email";
const String hinttextpassword = "Password";
const String titleApplication = "My Concierge";
const String titleMenuPerfil = "My Perfil";
const String titleMenuLogout = "Logout";
