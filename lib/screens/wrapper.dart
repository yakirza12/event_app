import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/home/home.dart';
import 'package:eventapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import 'authenticates/autenticate.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context)   {
   //var check =  AuthService().isUserLoggedIn();

    final AuthService _auth =  locator<AuthService>();
   final user  = Provider.of<User>(context); // listen to the provider, if it will be null we will navigate to the log in page. else we can access the user data from the provider.
   if(user == null) {
     return Authenticate();
   }else{
     return Home();
   }

  }
}
