import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventapp/models/guest.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/home/Businesses/Businesses_system.dart';
import 'package:eventapp/screens/home/Guests/Guest_tools/Tools_page.dart';
import 'package:eventapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'guestForm.dart';


bool addToGuestList = false;

// ignore: camel_case_types
class Guests_System extends StatefulWidget {
  final User user;

  Guests_System(this.user);

  @override
  _Guests_SystemState createState() => _Guests_SystemState();
}

// ignore: camel_case_types
class _Guests_SystemState extends State<Guests_System> {
  List<Guest> guestList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Guests',
          style: new TextStyle(
            color:  Colors.red[200],//Color(0xFFB0CBC4),

          ),
        ),
        backgroundColor: Colors.transparent,
        
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        /*Container(
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
        ),*/

        /**/
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFCCBF),
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.83), BlendMode.dstATop),
            image: AssetImage("assets/Marble Gold.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: 800,width: 5000),
            child: Column(
              children: [
              //  Text("Guests Table"),
                Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height*0.5,
//Color(0xFFFFCCBF)
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white.withOpacity(0.5),
                     // image: DecorationImage(
                      //  colorFilter: new ColorFilter.mode(
                       //     Colors.black.withOpacity(0.83), BlendMode.dstATop),
                        //image: AssetImage("assets/Marbel Grey.jpg"),
                       // fit: BoxFit.cover,
                    //  ),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    margin:
                    EdgeInsets.only(top: 10.0,bottom: 10, left: 20.0, right: 20.0),
                    alignment: Alignment.center,
                    child: _buildBody(context, widget.user)),

                new Expanded(
                    child: toolsGrid(widget.user)),

              ],
            ),
          ),
        ),
      ),
  /*
        onPressed: () {
      var alertDialog = AlertDialog(
        title: Text("Add Guest"),
        content: GuestForm(widget.user),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    },
    child: Icon(Icons.add),
    backgroundColor: Colors.green,
    ),*/

      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 55,
          index:0,
          items:<Widget>
          [
            Icon(Icons.people_outline,size:MediaQuery.of(context).size.height*0.035,color: Colors.red[200],),
            Icon(Icons.search,size:MediaQuery.of(context).size.height*0.035,color: Colors.red[200],),
            Icon(Icons.home,size:MediaQuery.of(context).size.height*0.055,color: Colors.red[200],),
            Icon(Icons.calendar_today,size:MediaQuery.of(context).size.height*0.035,color: Colors.red[200],),
            Icon(Icons.monetization_on,size:MediaQuery.of(context).size.height*0.035,color: Colors.red[200],),
          ],
          onTap: (index){
            switch(index){
              case 0:
                break;

              case 1:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusinessesGrid(),
                    )
                );
                break;
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home()),
                );
                break;

              case 3:
                break;

              case 4:
                break;

            }


          }
      ),
  );
  }

  // this lives OUTSIDE a class
  Widget _buildBody(BuildContext context, User _user) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(_user.uid)
            .collection('guests')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          else {
            _buildGuestList(context, snapshot.data.documents);

            return Stack(
              alignment:Alignment.center,
                fit: StackFit.expand,
                children: <Widget>[
              Positioned(
                top: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),

                  width: MediaQuery.of(context).size.width*0.89,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Proximity\nGroup',
                        style: new TextStyle(
                          fontSize: (MediaQuery.of(context).size.width)/24,
                          color:Colors.red[200],
                        ),
                      ),
                      Text(
                        '   Last\n   Name',
                        style: new TextStyle(
                          fontSize: (MediaQuery.of(context).size.width)/24,
                          color:Colors.red[200],
                        ),
                      ),
                      Text(
                        '     First\n     Name',
                        style: new TextStyle(
                          fontSize: (MediaQuery.of(context).size.width)/24,
                          color:Colors.red[200],
                        ),
                      ),
                      Text(
                        ' Quantity\n  Invited',
                        style: new TextStyle(
                          fontSize: (MediaQuery.of(context).size.width)/25,
                          color:Colors.red[200],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  child: DataTable(
          horizontalMargin: 10,
          columnSpacing: MediaQuery.of(context).size.width * 0.06,
                    //take the val from the form screen
                    onSelectAll: (b) {},
                    sortAscending: false,
                    dataRowHeight: 50.0,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text(''),
                        numeric: false,
                        onSort: (i, b) {
                          print("$i $b");

                        },
                        tooltip: "To display first name of the Name",
                      ),
                      DataColumn(
                        label: Text(''),
                        numeric: false,
                        onSort: (i, b) {
                          print("$i $b");

                        },
                      ),
                      DataColumn(
                        label: Text(''),
                        numeric: false,
                        onSort: (i, b) {
                          print("$i $b");

                        },
                      ),
                      DataColumn(
                        label: Text(''),
                        numeric: false,
                        onSort: (i, b) {
                          print("$i $b");

                        },
                      ),
                    ],

                    rows: guestList
                        .map((guest) => _buildListItem(context, guest))
                        .toList(),
                  ),

                ),

              ),

                  //todo put here the tools grid.

                ]);
          }
        });
  }



  void _buildGuestList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
//if(addToGuestList==false){

  //if(guestList == null) {
    //guestList.clear();
    guestList = snapshot.map((data) {
      final guest = Guest.fromSnapshot(data);
      return guest;
    }).toList();
    guestList.sort((a, b) =>
        a.proximityGroup.compareTo(b.proximityGroup));
  //}
//    addToGuestList = true;
//}
//    return guestList;
  }
}



DataRow _buildListItem(BuildContext context, Guest guest) {
  return DataRow(
      cells: [
    DataCell(Text(
      guest.proximityGroup,
      textAlign: TextAlign.left,
    ),
      placeholder: true
    ),
    DataCell(Text(
      guest.last_name,
      textAlign: TextAlign.left,
    )),
    DataCell(Text(
      guest.first_name,
      textAlign: TextAlign.left,
    )),
    DataCell(Text(
      "${guest.quantity_invited}",
      textAlign: TextAlign.left,
    )),
  ]);
}
