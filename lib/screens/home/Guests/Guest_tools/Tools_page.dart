import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/home/Guests/Guest_System/guestForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventapp/models/user.dart';

import 'before_wedding_messages.dart';



class toolsGrid extends StatelessWidget {
  final User user;
  toolsGrid(this.user);

  @override


  Widget build(BuildContext context) {



    return Column(

        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
          createGridItem(0,context),
          createGridItem(1,context),
          createGridItem(2,context),
          createGridItem(3,context),

        ],
      );



  }

  Widget createGridItem(int position,BuildContext context)
  {

    var color=Colors.white;
    var iconData=Icons.add;
    var text;
    var onTap = () {};


  //  var user = Provider.of<User>(context);
    switch(position) {
      case 0:
        color = Colors.orange[300].withOpacity(.5);

        iconData = Icons.person_add;
        text = "הוספת אורח\ים ידנית";
        onTap = () {

          var alertDialog = AlertDialog(
            title: Text("Add Guest"),
            content: GuestForm(user),
          );
          showDialog(context: context, builder: (_) => alertDialog);


         };
        break;
      case 3:
        onTap =  ()  {


          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Before_Event_message(user))
          );
        };
        color = Colors.deepPurpleAccent.withOpacity(0.9);
        iconData = Icons.forum;
        text = "שליחת הודעות לאורחים";

        break;
      case 1:
        color = Colors.pinkAccent.withOpacity(.3);

        iconData = Icons.insert_drive_file;
        text = "טעינת רשימת אורחים מקובץ";
        break;
      case 2:
        color = Colors.orange[300].withOpacity(.5);
        iconData = Icons.perm_contact_calendar;
        text =  "טעינת רשימת אורחים מאנשי קשר";
        break;
    }


    return Builder(builder: (context)
    {
      return Padding(
        padding: const EdgeInsets.only(left:15.0,right:15,bottom: 10,top: 10),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            side: BorderSide(
                color: Colors.white
            ),

          ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: onTap,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(text!=null?text: "",style: TextStyle(color: Colors.white),),
                  )
                  ,Icon(iconData,size:40,
                    color: Colors.white,),
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
