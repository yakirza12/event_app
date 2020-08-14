import 'package:flutter/material.dart';

import 'Guests/Guest_management.dart';
import 'home.dart';

class HomeManagement extends StatefulWidget {
  get toggleViewShowHomeVsGuestManagement => toggleViewShowHomeVsGuestManagement();

  @override
  _HomeManagementState createState() => _HomeManagementState();
}

class _HomeManagementState extends State<HomeManagement> {
  bool showHomeVsGuestManagement =true; // what we prefer to show
  void toggleViewShowHomeVsGuestManagement(){ // we will able to use this function from register and sign in if we send it as a parameter.
    setState(() {
      showHomeVsGuestManagement = !showHomeVsGuestManagement;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showHomeVsGuestManagement){
      return GuestsManagementGrid(toggleViewShowHomeVsGuestManagement : toggleViewShowHomeVsGuestManagement);
    }
    else {
      return Home();
    }
  }
}
