import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/review.dart';
import 'package:eventapp/screens/home/Businesses/AddBusinessForms/AddPhotographerForm.dart';
import 'package:eventapp/screens/home/Businesses/DetailScreens/PhotographersDetialScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/models/BusinessObject.dart';
import 'package:eventapp/models/user.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PhotographList extends StatefulWidget {
  final User _user;

  PhotographList(this._user);

  @override
  _PhotographListState createState() => _PhotographListState();
}

class _PhotographListState extends State<PhotographList> {
  List<Photographer> _photographers;
  List<Review> _reviews;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text("Photographers",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 26),),
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
              label: Text("")),
        ],
      ),
      backgroundColor: Colors.teal[200],
      body: _buildBodyPhotographer(context),
    );
  }

  Widget _buildBodyPhotographer(BuildContext context) {
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


                /*  Padding(padding: EdgeInsets.only(top:20),
                      child: Text('Chose Area:',style: TextStyle(color: Colors.white,fontSize: 20),)),*/
                  CategoryList(),
                  SearchBox(),
                  SizedBox(height: kDefaultPadding / 2,width: kDefaultPadding*2,),
                  new Expanded(
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
                          // List<Review> _reviews =snapshot.data.documents()(index).collection('Reviews').map((doc) => Review.fromSnapshot(doc));
                          itemBuilder: (context, index) => StreamBuilder(
                            stream: Firestore.instance
                                .collection('Businesses')
                                .document('Photograph')
                                .collection('Photograpes').document( _photographers[index].documentId).collection('Reviews').snapshots(),
                            builder:(context, snapshot) {
                              if (snapshot.hasData)
                                _buildReviewsList(context, snapshot.data.documents);
                              //print(_reviews.length);

                              return PhotographerCard(
                                reviews : _reviews,
                                itemIndex: index,
                                photographer: _photographers[index],
                                press: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PhotographerDetailScreen(
                                            photographer: _photographers[index],
                                            user: widget._user,
                                            reviews: _reviews,

                                          ),
                                    ),
                                  );
                                },
                              );
                            } ),
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

  void _buildReviewsList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    _reviews = snapshot.map((data) {
      final review = Review.fromSnapshot(data);
      return review;
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
    this.reviews,
  }) : super(key: key);

  final List<Review> reviews;
  final int itemIndex;
  final Photographer photographer;
  final Function press;

  @override
  Widget build(BuildContext context) {
/*
* final list = ['a', 'bb', 'ccc'];
// compute the sum of all length
list.fold(0, (t, e) => t + e.length);
* */
    double rate;
    if (reviews!=null)
      rate = reviews.fold(0.0, (acc, e) =>  acc + e.rate)/reviews.length;
    else
      rate = 3;

    const kBackgroundColor = Color(0xFFF1EFF1);
    const kPrimaryColor = Color(0xFFFF9E80);
    const kSecondaryColor = Color(0xFFE1BEE7);
    const kTextColor = Color(0xFF000839);
    const kTextLightColor = Color(0xFF747474);
    const kBlueColor = Color(0xFFFFD180);
    const kDefaultPadding = 20.0;
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        //top: kDefaultPadding / 8,
        bottom:kDefaultPadding / 8,
      ),
      // color: Colors.blueAccent,
      height: 161,
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
                margin: EdgeInsets.only(right: 7, top: 5),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.4,
                      vertical: kDefaultPadding * 1.6),
                  height: 190,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 170,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      photographer.imageUrl.toString(),
                      fit: BoxFit.cover,
                    ),
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
                    //Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                     //   horizontal: kDefaultPadding / 2,
                        left: kDefaultPadding / 2,
                      top:  kDefaultPadding / 2
                      //  vertical: kDefaultPadding / 2,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          // photographer.video,
                          photographer.name,
                          style: TextStyle(
                            fontSize: size.width / 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontFamily: "CaviarDreams",

                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left:5),
                      child: Row(
                          children:[ Icon(Icons.photo_camera), Text(" Stills - "),
                            if(photographer.photographic_still=='True')
                              Icon(Icons.check,color: Colors.green,),
                            if(photographer.photographic_still!='True')
                              Icon(Icons.cancel,color: Colors.red,),]
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(left:5),
                child: Row(
                        children:[ Icon(Icons.videocam),Text(' Video - ',
                          style: TextStyle(),
                        ),
                        if(photographer.video=='True')
                            Icon(Icons.check,color: Colors.green,),
                          if(photographer.video!='True')
                            Icon(Icons.cancel,color: Colors.red,),

                        ]
                    ),),
                    Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left:kDefaultPadding * 1,
                         right: kDefaultPadding * 1 ,                       // 5 top and bottom,
                         // horizontal: kDefaultPadding * 1.5, // 30 padding
                          top: kDefaultPadding / 3, // 5 top and bottom
                          bottom: kDefaultPadding / 3, // 5 top and bottom

                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor, //lalala
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Text(
                          "${photographer.area}",
                          // style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, bottom: 0.0, top: 5.0),
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              SmoothStarRating(
                                starCount: 5,
                                color: Colors.yellow[600],
                                allowHalfRating: true,
                                rating: reviews!=null ? rate:0.0,
                                size: 12.0,
                              ),
                              Text(
                                reviews!=null?
                                " ${(rate*1.01).toStringAsFixed(1)}":" 5.0",
                                style: TextStyle(
                                  fontSize: 11.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                            ]),
                            Text(
                              reviews!=null?
                              "(${reviews.length} Reviews)":
                              "(0 Reviews)" ,
                              style: TextStyle(
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // it use the available space
                    ]),
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

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    const kBackgroundColor = Color(0xFFF1EFF1);
    const kPrimaryColor = Color(0xFFFF9E80);
    const kSecondaryColor = Color(0xFFE1BEE7);
    const kTextColor = Color(0xFF000839);
    const kTextLightColor = Color(0xFF747474);
    const kBlueColor = Color(0xFFFFD180);
    const kDefaultPadding = 20.0;
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 top and bottom
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          // icon: SvgPicture.asset("assets/search.svg"),
          hintText: 'Search for Photographer',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // by default first item will be selected
  int selectedIndex = 0;
  List categories = ['All', 'North', 'South','Center'];
  @override
  Widget build(BuildContext context) {
    const kBackgroundColor = Color(0xFFF1EFF1);
    const kPrimaryColor = Color(0xFFFF9E80);
    const kSecondaryColor = Color(0xFFE1BEE7);
    const kTextColor = Color(0xFF000839);
    const kTextLightColor = Color(0xFF747474);
    const kBlueColor = Color(0xFFFFD180);
    const kDefaultPadding = 20.0;
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding / 2,bottom: kDefaultPadding / 2
          , left:0,right: kDefaultPadding / 10),
      height:40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              // At end item it add extra 20 right  padding
              right: index == categories.length - 1 ? kDefaultPadding : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
