import 'package:eventapp/models/user.dart';
import 'package:eventapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'BusinessesScreens/Photographers.dart';


// list of colors that we use in our app
const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);
const kDefaultPadding = 20.0;





// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);





class BusinessesGrid extends StatefulWidget {
  final User user;

  BusinessesGrid(this.user);
  @override
  _BusinessesGridState createState() => _BusinessesGridState();
}

class _BusinessesGridState extends State<BusinessesGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Suppliers",
          style:Theme.of(context).textTheme.display1,),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async{
              },
              icon: Icon(Icons.menu),
            label: Text("") ,
          ),


        ],
      ),


      body: Container(
        color: kBlueColor,
        child: Column(
          children: [
            createGridItem(0,context,widget.user),
           // SearchBox(),
            //CategoryList(),

          ],
        ),

      ),

    );
  }
}


Widget createGridItem(int position,BuildContext context,User user) {
  //final HomeManagement _home = HomeManagement();
  var color = Colors.white;
  var iconData = Icons.add;
  var text;
  var onTap = () {};


  //var user = Provider.of<User>(context);
  switch (position) {
    case 0:
      color = Colors.orange[300].withOpacity(.5);

      iconData = Icons.people_outline;
      text = "Photographers";
      onTap = () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => PhotographList(user)
          ),
        );
      }; //TODO open the next page
      break;
    case 1:
      color = Colors.deepPurpleAccent.withOpacity(.2);
      iconData = Icons.search;
      text = "a";
      onTap = () {
        /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => BusinessesGrid(),
            ) );*/
      };
      break;
    case 2:
      color = Colors.pinkAccent.withOpacity(.3);

      iconData = Icons.calendar_today;
      text = "b";
      break;
    case 3:
      color = Colors.green.withOpacity(.2);
      iconData = Icons.monetization_on;
      text = "c";
      break;
  }


  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15, bottom: 10, top: 10),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconData, size: 40,
                  color: Colors.white,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text, style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  );


/*


// We need statefull widget because we are gonna change some state on our category
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // by default first item will be selected
  int selectedIndex = 0;
  List categories = ['All', 'Sofa', 'Park bench'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2
      , horizontal: kDefaultPadding / 4),
      height: 30,
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




class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
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
          hintText: 'Free Search',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
*/
}