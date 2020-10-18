import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/home/HomeManagement.dart';
import 'package:eventapp/screens/home/profileScreen.dart';
import 'package:eventapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import 'Businesses/Businesses_system.dart';
import 'Guests/Guest_System/Guests_System.dart';
import 'Guests/Guest_management.dart';

class Home extends StatefulWidget {
  // he made is stateless but im want it in differ because its will be my menu

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final AuthService _auth = AuthService();
  final AuthService _auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(_user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          } else {
            User user = User.fromSnapshot(snapshot.data, _user.uid);
            Size _size = MediaQuery.of(context).size;
            return Directionality(
              textDirection:TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    "Home",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  leading: IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile(user: user)),
                      );
                    },
                    icon: Icon(Icons.menu,size: _size.width*0.085,color: Colors.teal[300],),

                  ),
                  actions: <Widget>[

                    ],
                ),
                /*appBar: AppBar(
        title: Text('appBar home text'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
      FlatButton.icon(
                onPressed: () async{
                  await _auth.signOut(); // its will set the prividers user to null and wee take as back to the login home page
                },
                icon: Icon(Icons.person),
                label: Text('logout')
          )//flat
        ],
      ),*/
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    /*image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.83), BlendMode.dstATop),
                      image: AssetImage("assets/plaining.jpg"),
                      fit: BoxFit.cover,
                    ),*/
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.teal[200].withOpacity(.2),
                                    Colors.greenAccent.withOpacity(.5),
                                  ])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "CaviarDreams",
                                  fontSize: 32.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${user.Groom_name} and ${user.Bride_name}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "CaviarDreams",
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                              //Text("Feel free to use the tools below" , style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                              SizedBox(
                                height: 20,
                              ),
                              /* Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                           // child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                          ),*/
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      new Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            scrollDirection: Axis.vertical,
                            children: [
                              createGridItem(1, context, user),
                              createGridItem(0, context, user),
                              createGridItem(3, context, user),
                              createGridItem(2, context, user),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                bottomNavigationBar: CurvedNavigationBar(
                    backgroundColor: Colors.transparent,
                    height: 55,
                    index: 2,
                    items: <Widget>[
                      Icon(
                        Icons.people_outline,
                        size: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.red[200],
                      ),
                      Icon(
                        Icons.search,
                        size: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.red[200],
                      ),
                      Icon(
                        Icons.home,
                        size: MediaQuery.of(context).size.height * 0.055,
                        color: Colors.red[200],
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.red[200],
                      ),
                      Icon(
                        Icons.monetization_on,
                        size: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.red[200],
                      ),
                    ],
                    onTap: (index) {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Guests_System(user)),
                          );
                          break;

                        case 1:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessesGrid(user),
                              ));
                          break;
                        case 2:
                          break;

                        case 3:
                          break;

                        case 4:
                          break;
                      }
                    }),
              ),
            );
          }
        });
  }

  Widget createGridItem(int position, BuildContext context, User user) {
    final HomeManagement _home = HomeManagement();
    var color = Colors.white;
    var iconData = Icons.add;
    var text;
    var onTap = () {};

//  var user = Provider.of<User>(context);
    switch (position) {
      case 0:
        color = Colors.orange[300].withOpacity(.5);

        iconData = Icons.people_outline;
        text = "Guests";
        onTap = () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Guests_System(user)),
          );
        }; //TODO open the next page
        break;
      case 1:
        color = Colors.deepPurpleAccent.withOpacity(.2);
        iconData = Icons.search;
        text = "Search Suppliers";
        onTap = () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessesGrid(user),
              ));
        };
        break;
      case 2:
        color = Colors.pinkAccent.withOpacity(.3);

        iconData = Icons.calendar_today;
        text = "Todo List";
        break;
      case 3:
        color = Colors.green.withOpacity(.2);
        iconData = Icons.monetization_on;
        text = "Total Sum";
        break;
    }

    return Builder(builder: (context) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 10),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: onTap,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconData,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
