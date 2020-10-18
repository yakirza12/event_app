import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/BusinessObject.dart';
import 'package:eventapp/models/review.dart';
import 'package:eventapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Reviews.dart';

class PhotographerDetailScreen extends StatefulWidget {
  final User user;
  final Photographer photographer;
  final List<Review> reviews;

  //final int number_of_reviews;
  //final double avarage_reviews;

  const PhotographerDetailScreen(
      {Key key, this.photographer, this.user, this.reviews});


  @override
  _PhotographerDetailScreenState createState() =>
      _PhotographerDetailScreenState();
}

class _PhotographerDetailScreenState extends State<PhotographerDetailScreen> {
  List<Review> _reviews;
  double _avarage_reviews = 5.0;
  int _number_of_reviews = 0;
  Widget _widgetList;
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            "Business Info",
            style: TextStyle(color: Colors.lightBlue,fontSize:26,fontWeight: FontWeight.bold ),
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Businesses')
                .document('Photograph')
                .collection('Photograpes')
                .document(widget.photographer.documentId)
                .collection('Reviews')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                _widgetList = LinearProgressIndicator();
              else {
                _buildReviewsList(context, snapshot.data.documents);
                _avarage_reviews = _reviews.fold(0.0, (acc, e) =>  acc + e.rate)/_reviews.length;
                _number_of_reviews = _reviews.length;
                _widgetList = SafeArea(
                  bottom: false,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      Review rev = _reviews[index];
                      return ReviewCard(
                        review: rev,
                      );
                    },
                  ),
                );
              }
              return Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3.2,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                widget.photographer.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -10.0,
                            bottom: 3.0,
                            child: RawMaterialButton(
                              onPressed: () {},
                              fillColor: Colors.white,
                              shape: CircleBorder(),
                              elevation: 4.0,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.lightBlue,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[Text(
                        widget.photographer.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      Spacer(),
                      FlatButton(child: Text("Phone",style: TextStyle(color: Colors.white),),
                        onPressed: ()
                        {
                          String phone = widget.photographer.phone_number;
                          customLaunch('tel: $phone');
                        }, color: Colors.green,),
                      Spacer(),
                      FlatButton(child: Text("Web",style:TextStyle(color: Colors.white)), onPressed: (){
                        String url = widget.photographer.webUrl;
                        customLaunch(url);

                      }, color: Colors.blueAccent,)
                      ]),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0, top: 0,left: 0.5),
                              child: Row(
                                children:[ Icon(Icons.place),Text('${widget.photographer.place}',
                                  style: TextStyle(color: Colors.blue,),
                                ),]
                              ),
                            ),
                            Row(
                                children:[ Icon(Icons.photo_camera), Text(" Stills - "),
                                  if(widget.photographer.photographic_still=='True')
                                    Icon(Icons.check,color: Colors.green,),
                                  if(widget.photographer.photographic_still!='True')
                                    Icon(Icons.cancel,color: Colors.red,),]
                            ),
                            Row(
                                children:[ Icon(Icons.videocam),Text(' Video - ',
                                  style: TextStyle(),
                                ),
                                  if(widget.photographer.video=='True')
                                    Icon(Icons.check,color: Colors.green,),
                                  if(widget.photographer.video!='True')
                                    Icon(Icons.cancel,color: Colors.red,),
                                ]
                            ),


                            /*Text(
                              "20 Pieces",
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              r"$90",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).accentColor,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Business Description",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.photographer.descreption,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(
                              "Reviews",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 2,
                            ),
                              Row(children: [Text(
                                "Rate: ${_avarage_reviews.toStringAsFixed(1)} " ,
                                style: TextStyle(
                                  fontSize: 11.0,
                                ),
                              ),
                                Text("(${_number_of_reviews} Reviews)",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  ),

                                )

                              ],),
                            ]
                          ),


                          Spacer(),
                          FloatingActionButton.extended(
                            onPressed: () {
                              var alertDialog = AlertDialog(
                                title: Text("Add PhotoGrapher Review"),
                                content: AddReviewForm(
                                    widget.user,
                                    widget.photographer.name,
                                    widget.photographer.documentId),
                              );
                              showDialog(
                                  context: context,
                                  builder: (_) => alertDialog);
                            },
                            // fillColor: Colors.white,
                            // shape: CircleBorder(),
                            // elevation: 4.0,
                            label: Text(
                              "Add",
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            backgroundColor: Colors.white,

                            icon: Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(
                                Icons.add,
                                color: Colors.lightBlue,
                                size: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      _widgetList,
                      /*if (!snapshot.hasData)
                      LinearProgressIndicator(),
                    else {
                      _buildReviewsList(context, snapshot.data.documents);
                      //ReviewCard(review: rev);
                       //SizedBox(height: 10.0)
                    }*/
                    ],
                  ));
            }));
  }

  void _buildReviewsList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    _reviews = snapshot.map((data) {
      final review = Review.fromSnapshot(data);
      return review;
    }).toList();
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key key, this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    const kDefaultPadding = 20.0;
    return Container(
      margin: EdgeInsets.only(
          left: 0.0, right: kDefaultPadding, bottom: kDefaultPadding / 2),
      child: Row(/*alignment: Alignment.topLeft,*/
          children: <Widget>[
        //new Text(review.descreption),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage(
                              "assets/anunimosAccountPhoto.png")))),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      review.name_of_reviewer,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: SmoothStarRating(
                          starCount: 5,
                          color: Colors.yellow[600],
                          allowHalfRating: true,
                          rating: review.rate * 1.01,
                          size: 17.0,
                        ),
                      ),
                      Text(
                        "${DateFormat('dd-MM-yyyy').format(review.dateTime.toDate())}",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                        /*'${review.dateTime.toString().substring(0, review.dateTime.toString().indexOf(' '))}'*/
                      ),
                    ],
                  )
                ]),

            /*Text(
              //reviews!=null?
              " ${review.rate.toStringAsFixed(1)}",
              style: TextStyle(
                fontSize: 11.0,
              ),
            ),*/
            /* Row(
              children: [

                SizedBox(width: 50.0),
                // Text('${eve.date.toString().substring(eve.date.toString().indexOf(' ')+1,(eve.date.toString().length-7) )}'),
              ],
            ),*/
          ],
        ),
      ]),
    );
  }
}
