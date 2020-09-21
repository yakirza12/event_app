import 'package:eventapp/models/user.dart';
import 'package:eventapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Guest_System/Guests_System.dart';
import 'Guest_tools/Tools_page.dart';

class GuestsManagementGrid extends StatefulWidget {
  final Function toggleViewShowHomeVsGuestManagement;
  final User user;

  GuestsManagementGrid({this.user, this.toggleViewShowHomeVsGuestManagement});
  @override
  _GuestsManagementState createState() => _GuestsManagementState();
}

class _GuestsManagementState extends State<GuestsManagementGrid> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Guests Management'
        ,style: TextStyle(color: Color(0xFFB0CBC4).withOpacity(1)),),
        backgroundColor: Colors.grey.withOpacity(.15),
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
       actions: <Widget>[

        ],
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          color: Color(0xFFFFCCBF),
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.83), BlendMode.dstATop),
            image: AssetImage("assets/whine.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //margin: EdgeInsets.only(top: 20,left: 60,right: 60),
        child: Padding(
          padding: const EdgeInsets.only(top : 20 ,left: 30, right: 30,bottom:20  ),
          child: Column(

            children: <Widget>[
              new Expanded(child: GridView.count(
                crossAxisCount: 1,
                children: [
                  createGridItem(0, context),
                  createGridItem(1, context),
                ],
              ),
              )
            ],

          ),
        ),
      ) ,
    );
  }

  Widget createGridItem(int position,BuildContext context)
  {

    var color=Colors.white;
    var iconData=Icons.add;
    var onTap = () {};
    var text;

    switch(position) {
      case 0:
        color = Colors.deepPurpleAccent.withOpacity(.2);
        iconData = Icons.content_paste;
        text = "Guests System";
        onTap = () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Guests_System(widget.user)
            ),
          );
        };
        break;
      case 1:
        color = Colors.grey.withOpacity(.5);
        text = "More Tools";
        onTap = () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => toolsGrid(widget.user)
            ));
        iconData = Icons.add_box;
        break;
    }


    return Builder(builder: (context)
    {
      return Padding(
        padding: const EdgeInsets.only(left:10,right: 10,bottom: 10,top: 10),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            side: BorderSide(
                color: Colors.white
            ),

          ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: onTap,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconData,size:40,
                    color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text,style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    );

  }
}



