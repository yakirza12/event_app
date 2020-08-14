import 'package:eventapp/screens/authenticates/register.dart';
import 'package:eventapp/screens/authenticates/sign_in.dart';
import 'package:eventapp/screens/authenticates/sign_in2.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn =true; // what we prefer to show
  void toggleView (){ // we will able to use this function from register and sign in if we send it as a parameter.
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {

     if(showSignIn){
       return SignIn2(toggleView:toggleView);
    }
     else {
       return Register(toggleView:toggleView);
     }

  }
}
