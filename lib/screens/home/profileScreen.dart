
import 'package:eventapp/models/user.dart';
import 'package:eventapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class Profile extends StatefulWidget {

  User user;
  Profile({this.user});

  @override

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth =  locator<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: Directionality(
          textDirection:TextDirection.rtl ,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Image.network(
                      widget.user.imageUrl,
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Jane Doe",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                       // SizedBox(height: 5.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "jane@doefamily.com",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: ()async{
                                await _auth.signOut();
                              },
                              child: Text("Logout",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),

              Divider(),
              Container(height: 15.0),

              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text(
                    "Account Information".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 20.0,
                      ),
                      onPressed: (){
                      },
                      tooltip: "Edit",
                    ),]),
              ),

              ListTile(
                title: Text(
                  "שם החתן",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                subtitle: Text(
                  widget.user.Groom_name,
                ),

              ),
              ListTile(
                title: Text(
                  "שם הכלה",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                subtitle: Text(
                  widget.user.Bride_name,
                ),
              ),

              ListTile(
                title: Text(
                  "דואר אלקטרוני",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                subtitle: Text(
                  widget.user.emailAddress,
                ),
              ),

              ListTile(
                title: Text(
                  "מספר טלפון",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                subtitle: Text(
                  widget.user.phone_number,
                ),
              ),





              ListTile(
                title: Text(
                  "תאריך האירוע",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                subtitle: Text(
                widget.user.eventDate.toDate().year.toString() + " - "  + widget.user.eventDate.toDate().month.toString() + " - " +widget.user.eventDate.toDate().day.toString(),) ,


              ),


            ],
          ),
        ),
      ),
    );
  }
}
