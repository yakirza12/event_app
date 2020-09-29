import 'package:eventapp/models/BusinessObject.dart';
import 'package:flutter/material.dart';

class PhotographerDetailScreen extends StatefulWidget {

  final Photographer photographer;
  const PhotographerDetailScreen({Key key,this.photographer});

  @override
  _PhotographerDetailScreenState createState() => _PhotographerDetailScreenState();
}

class _PhotographerDetailScreenState extends State<PhotographerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,

      leading: IconButton(icon:Icon(Icons.keyboard_backspace),
          onPressed: ()=>Navigator.pop(context),),
        centerTitle: true,
        title: Text(widget.photographer.name,),
      ),

    );
  }
}
