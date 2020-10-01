import 'package:cloud_firestore/cloud_firestore.dart';

class Business{
  final String  name;
  final String descreption;
  final String place;
  final int area;
  final int rate;
  final String documentId;
  final String imageFileName;
  final String imageUrl;
  final String phone_number;
  final DocumentReference reference;
  Business({ this.descreption,this.name,this.place,this.area,this.documentId,this.rate,this.imageUrl,this.reference,this.imageFileName,this.phone_number});

  Business.fromMap(Map<String , dynamic> map,{this.reference}):
  // if (map == null) return null;
        assert(map['name'] != null),
        assert(map['documentId'] != null),
        assert(map['descreption'] != null),
        assert(map['place'] != null),
        assert(map['rate'] != null),
        assert(map['area'] != null),
        assert(map['imageUrl'] != null),
        assert(map['imageFileName'] != null),
        assert(map['phone_number'] != null),
      documentId =  map['documentId'],
      name = map['name'],
      descreption = map['descreption'] ,
      place = map['place'],
      rate = map['rate'],
      area = map['area'] ,
      imageUrl = map['imageUrl'],
      imageFileName = map['imageFileName'],
      phone_number = map["phone_number"];

  Business.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}


class Photographer extends Business{

  final String video;
  final String photographic_still;
  Photographer({descreption,name,place,area,rate,documentId,imageFileName,imageUrl,phone_number,reference,this.video,this.photographic_still

}):super(descreption:descreption,
    name:name,place:place,area:area,documentId:documentId,rate:rate,reference:reference,imageFileName:imageFileName,imageUrl:imageUrl ,phone_number:phone_number);


  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
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

   Photographer.fromMap(Map<String , dynamic> map,{reference}):
     // if (map == null) return null;
       //  assert(map['documentId'] != null),
         assert(map['name'] != null),
         assert(map['descreption'] != null),
         assert(map['place'] != null),
         assert(map['rate'] != null),
         assert(map['area'] != null),
         assert(map['imageUrl'] != null),
         assert(map['imageFileName'] != null),
         assert(map['phone_number'] != null),
         assert(map['video'] != null),
         assert(map['photographic_still'] != null),
        //documentId: documentId,

        /*Just for this photograpghers type*/
        video  = map['video'],
        photographic_still =  map['photographic_still'];



    Photographer.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);


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
