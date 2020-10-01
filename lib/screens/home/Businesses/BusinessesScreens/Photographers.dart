import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/screens/home/Businesses/AddBusinessForms/AddPhotographerForm.dart';
import 'package:eventapp/screens/home/Businesses/DetailScreens/PhotographersDetialScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/models/BusinessObject.dart';
import 'package:eventapp/models/user.dart';


class PhotographList extends StatefulWidget {
  final User _user;

  PhotographList(this._user);

  @override
  _PhotographListState createState() => _PhotographListState();
}

class _PhotographListState extends State<PhotographList> {
  List<Photographer> _photographers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,

        leading: IconButton(icon:Icon(Icons.keyboard_backspace),
          onPressed: ()=>Navigator.pop(context),),
        centerTitle: true,
        title: Text("Photographers"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {

                  var alertDialog = AlertDialog(
                    title: Text("Add PhotoGrapher"),
                    content: AddPhotographerForm(),
                  );
                  showDialog(context: context, builder: (_) => alertDialog);

                 // its will set the prividers user to null and wee take as back to the login home page
              },
              icon: Icon(Icons.add),
              label: Text("")
          ),


        ],
      ),
      body: _buildBodyPhotographer(context),
    );
  }

  Widget _buildBodyPhotographer(BuildContext context){
    const kBackgroundColor = Color(0xFFF1EFF1);
    const kPrimaryColor = Color(0xFF035AA6);
    const kSecondaryColor = Color(0xFFFFA41B);
    const kTextColor = Color(0xFF000839);
    const kTextLightColor = Color(0xFF747474);
    const kBlueColor = Color(0xFF40BAD5);
    const kDefaultPadding = 20.0;
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Businesses')
            .document('Photograph')
            .collection('Photograpes')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LinearProgressIndicator();
          else {
            _buildPhographerList(context, snapshot.data.documents);
            return SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  SizedBox(height: kDefaultPadding / 2),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        // Our background
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        ListView.builder(
                          // here we use our demo procuts list
                          itemCount: _photographers.length,
                          itemBuilder: (context, index) => PhotographerCard(
                            itemIndex: index,
                            photographer: _photographers[index],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotographerDetailScreen(
                                    photographer: _photographers[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );

          }

        });
  }

  void _buildPhographerList(
      BuildContext context, List<DocumentSnapshot> snapshot) {

    _photographers = snapshot.map((data) {
      final phorographer = Photographer.fromSnapshot(data);
      return phorographer;
    }).toList();

  }


}


// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);


/*
class Body extends StatelessWidget {

 List<Photographer> get photographers => _photographers;

  var storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return
  }
}
*/

class PhotographerCard extends StatelessWidget {
  const PhotographerCard({
    Key key,
    this.itemIndex,
    this.photographer,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final Photographer photographer;
  final Function press;

  @override
  Widget build(BuildContext context) {
    const kBackgroundColor = Color(0xFFF1EFF1);
    const kPrimaryColor = Color(0xFF035AA6);
    const kSecondaryColor = Color(0xFFFFA41B);
    const kTextColor = Color(0xFF000839);
    const kTextLightColor = Color(0xFF747474);
    const kBlueColor = Color(0xFF40BAD5);
    const kDefaultPadding = 20.0;
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '${photographer.documentId}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                  child: Image.network(
                    photographer.imageUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "T",
                       // photographer.name,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "\$${photographer.area}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}