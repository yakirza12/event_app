import 'package:cloud_firestore/cloud_firestore.dart';

class Business{

  final String descreption;
  final String  name;
  final String place;
  final int area;
  final int rate;
  final String documentId;
  final String imageFileName;
  final String imageUrl;
  final String phone_number;
  //final DocumentReference reference;
  Business({ this.descreption,this.name,this.place,this.area,this.rate,this.documentId,this.imageUrl,this.imageFileName,this.phone_number});

}



class Photographer extends Business{

  final String video;
  final String photographic_still;
  Photographer({descreption,name,place,area,rate,documentId,imageFileName,imageUrl,phone_number,this.video,this.photographic_still

}):super(descreption:descreption,
    name:name,place:place,area:area,documentId:documentId,rate:rate,imageFileName:imageFileName,imageUrl:imageUrl ,phone_number:phone_number);


  Map<String, dynamic> toMap() {
    return {
      //'documentId': documentId,
      'name': name,
      'descreption' :descreption,
      'place':place,
      'rate':rate,
      'area':area,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'phone_number':phone_number,

    /*Just for this photograpghers type*/
      'video':video,
      'photographic_still':photographic_still,
    };
  }

  static Photographer fromMap(Map<String , dynamic> map, String documentId) {
    if (map == null) return null;

    return Photographer(
      documentId: documentId,
      name :map['name'],
      descreption:map['descreption'] ,
      place : map['place'],
      rate : map['rate'],
      area : map['area'] ,
      imageUrl : map['imageUrl'],
      imageFileName :map['imageFileName'],
      phone_number:map["phone_number"],

      /*Just for this photograpghers type*/
      video : map['video'],
      photographic_still: map[ 'photographic_still'],

    );
  }

}




/*

gPhoto(
{id,
owner,
secret,
server,
farm,
title,
ispublic,
isfriend,
isfamily,
url,
this.ownername,
this.dateadded})
    : super(
id: id,
owner: owner,
secret: secret,
server: server,
farm: farm,
title: title,
ispublic: ispublic,
isfamily: isfamily,
url: url);*/
// ; // the constructor.
/*
  Guest.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['proximityGroup'] != null),
        assert(map['last_name'] != null),
        assert(map['first_name'] != null),
        assert(map['quantity_invited'] != null),
        proximityGroup = map['proximityGroup'],
        last_name = map['last_name'],
        first_name = map['first_name'],
        quantity_invited = map['quantity_invited'];

  Guest.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$proximityGroup:$last_name:$first_name:$quantity_invited>";


*/
