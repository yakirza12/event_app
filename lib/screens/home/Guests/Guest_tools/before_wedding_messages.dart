import 'package:eventapp/models/user.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Before_Event_message extends StatefulWidget {
  final User user;
  Before_Event_message(this.user);

  @override
  _Before_Event_messageState createState() => _Before_Event_messageState();
}
 DocumentSnapshot snapshot;

class _Before_Event_messageState extends State<Before_Event_message> {

  final _formKey = GlobalKey<FormState>();
  String message;

  dynamic data;
  Future<dynamic>  getData()async{ //use a Async-await function to get the data
  /*  final data =  await Firestore.instance.collection('users').document(widget.user.uid).get(); //get the data

    snapshot = data;*/
    final DocumentReference document =   Firestore.instance.collection("users").document(widget.user.uid);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
      });
    });

  }

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
  void initState() {

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
   // getData();
    String numberOfMessages  = data['number_of_messages'].toString();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("שליחת הודעות לאורחים"),

        ),
        
        /*
        * child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: 800,width: 5000),
            child: Column(
        * 
        * 
        * */
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: 2000,width: 5000),
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left:250,top:15,bottom:20,right: 10),
                  child: Container(
                    width: 150,//MediaQuery.of(context).size.width*0.90,
                    height: 80,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(.3),

                              Colors.white.withOpacity(.1),
                            ]
                        )
                    ),
                    child: Column(children: [
                      Center(
                          child: Text(    'כמות הודעות לשליחה: ' + numberOfMessages)

                      ),


                    //    Text( "", textDirection: TextDirection.ltr, ),


                    ],

                    ),
                  ),
                ),
                FormMessage("הזן בבקשה את תוכן הודעת ההזמנה לאירוע, כאן עלייך לוודא שמופיע התאריך, שמות בעלי השמחה, וקישור להזמנה הדיגיטלית במידה ויצרתם כזו. ",
                    'רשום כאן את הודעת ההזמנה לאירוע',
                        (){}),
                
              Container(

                padding: EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom: 0),
                child: Image.asset('assets/niceLine.png',color: Colors.pink.withOpacity(0.5),


                ),
              ),

                FormMessage("הזן בבקשה את תוכן הודעת ההזמנה לאירוע, כאן עלייך לוודא שמופיע התאריך, שמות בעלי השמחה, וקישור להזמנה הדיגיטלית במידה ויצרתם כזו. ",
                    'רשום כאן את הודעת ההזמנה לאירוע',
                        (){}),

                Container(

                  padding: EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom: 0),
                  child: Image.asset('assets/niceLine.png',color: Colors.pink.withOpacity(0.5),


                  ),
                ),FormMessage("הזן בבקשה את תוכן הודעת ההזמנה לאירוע, כאן עלייך לוודא שמופיע התאריך, שמות בעלי השמחה, וקישור להזמנה הדיגיטלית במידה ויצרתם כזו. ",
                    'רשום כאן את הודעת ההזמנה לאירוע',
                        (){}),

                Container(

                  padding: EdgeInsets.only(left:10.0,top:0.0,right:10.0,bottom: 0),
                  child: Image.asset('assets/niceLine.png',color: Colors.pink.withOpacity(0.5),


                  ),
                ),
 /* Padding
    (padding: EdgeInsets.all((10)),
      child: Form(child: Text("הזן בבקשה את תוכן הודעת ההזמנה לאירוע, כאן עלייך לוודא שמופיע התאריך, שמות בעלי השמחה, וקישור להזמנה הדיגיטלית במידה ויצרתם כזו. "))),
                Padding(
                  padding: const EdgeInsets.only(left:30,top:10,bottom:50,right: 30),
                  child: TextFormField(
                    validator: (val) => val.length < 5 ? "הכנס הודעה באורך 5 לפחות" : null,
                    //textDirection: TextDecoration.,
                    minLines: 7,
                    maxLines: 12,
                    maxLength: 256,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'רשום כאן את הודעת ההזמנה לאירוע',
                      filled: true,
                      fillColor: Color(0xFFDBEDFF),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.deepOrangeAccent[100],
                    onPressed: () async {
                      if(_formKey.currentState.validate())//will check if our from is legit
            {/** need to inmplement the api**/
                  }
                      //dynamic result = await _auth.sighinWithEmailAndPassword(email, password);

                        else {

                        }
                      },

                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 00,
                        horizontal: 50.0,

                      ),
                      margin: EdgeInsets.all(7),

                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "שלח הודעות",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )

                ),*/



            ],
            ),
          ),
        ),




/*
          child: FloatingActionButton(
            onPressed: ()=>{
            twilioFlutter.sendSMS(
            toNumber : '+972528795522',
            messageBody : 'hello world'),
            },
          ),*/




      ),
    );
  }
}

//'רשום כאן את הודעת ההזמנה לאירוע'

class FormMessage extends StatefulWidget {
  var Before_message;
  var hint_message;
  var error =" ";
  var onTap = () {};

  FormMessage(this.Before_message,this.hint_message,this.onTap);

  @override
  _FormMessageState createState() => _FormMessageState();
}

class _FormMessageState extends State<FormMessage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding
          (padding: EdgeInsets.all((10)),
            child: Form(child: Text(widget.Before_message))),
        Padding(
          padding: const EdgeInsets.only(left:30,top:0,bottom:0,right: 30),
          child: TextFormField(
            validator: (val) => val.length < 5 ? widget.error = "הכנס הודעה באורך 5 לפחות" : null,
            //textDirection: TextDecoration.,
            minLines: 7,
            maxLines: 12,
            maxLength: 256,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: widget.hint_message,
              filled: true,
              fillColor: Color(0xFFDBEDFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.deepOrangeAccent[100],
            onPressed: () async {
              if(_formKey.currentState.validate())//will check if our from is legit
                  {
                 widget.onTap;
                  }
              //dynamic result = await _auth.sighinWithEmailAndPassword(email, password);
              else {
               print(widget.error);
              }
            },

            child: new Container(
             // padding: const EdgeInsets.fromLTRB(10,10, 10, 10),


              child:
                  Text(
                    "שלח הודעות",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

            )
        ),
      ],
    );
  }
}


class Messagesgrid extends StatefulWidget {
  @override
  _MessagesgridState createState() => _MessagesgridState();
}

class _MessagesgridState extends State<Messagesgrid> {
  @override
  Widget build(BuildContext context) {
    return Container(


    );
  }
}
