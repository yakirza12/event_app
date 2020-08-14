import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/guest.dart';
import 'package:eventapp/models/user.dart';
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
        title: Text('Guests Table',
          style: new TextStyle(
            color:  Color(0xFFB0CBC4),

          ),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        /**/

        /**/
      ),
      body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFFFFCCBF),
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.83), BlendMode.dstATop),
              image: AssetImage("assets/Marbel Grey.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(0.0),
          margin:
              EdgeInsets.only(top: 0.0, bottom: 40.0, left: 20.0, right: 20.0),
          alignment: Alignment.center,
          child: _buildBody(context, widget.user)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var alertDialog = AlertDialog(
            title: Text("Add Guest"),
            content: GuestForm(widget.user),
          );
          showDialog(context: context, builder: (_) => alertDialog);
//         Navigator.push(context,
//              MaterialPageRoute(builder: (context) => StreamProvider<User>.value(
//                  value: AuthService().user,
//                  child: GuestForm()
//              )
//              )
//          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
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
                  width: MediaQuery.of(context).size.width*0.9,
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
              )
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
