import 'package:eventapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';



class Before_Event_message extends StatefulWidget {
  final User user;
  Before_Event_message(this.user);

  @override
  _Before_Event_messageState createState() => _Before_Event_messageState();
}

class _Before_Event_messageState extends State<Before_Event_message> {



 final TwilioFlutter twilioFlutter  =  TwilioFlutter(
  accountSid : 'AC7eeb6159541595ec336e03ddd02b4763', // replace *** with Account SID
  authToken : '1d4aafd792891def89ca5ea621885df9',  // replace xxx with Auth Token
  twilioNumber : '+16413816314'  // replace .... with Twilio Number
  );
/*
  twilioFlutter.sendSMS(
  toNumber : '+................',
  messageBody : 'hello world');

 */

  @override
  Widget build(BuildContext context) {
    return Container(

        child: FloatingActionButton(
          onPressed: ()=>{
          twilioFlutter.sendSMS(
          toNumber : '+972528795522',
          messageBody : 'hello world'),
          },
        ),




    );
  }
}
