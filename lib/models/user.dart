import 'package:cloud_firestore/cloud_firestore.dart';

class User{ // the user object, need to be expandent in the future

  final String uid;
  final String emailAddress;
  final String Groom_name;// hatan
  final String Bride_name;
  final Timestamp eventDate;
  final String phone_number;
  final int number_of_messages;
  final String imageFileName;
  final String imageUrl;
  final DocumentReference reference;

  User({this.uid,this.emailAddress,this.Groom_name,this.Bride_name,this.eventDate,this.phone_number,this.number_of_messages,this.imageUrl,this.imageFileName,this.reference}); //the constructor for user




  User.fromMap(Map<String, dynamic> map,String _uid, {this.reference})
      : //assert(map['uid'] != null),eventDate
        assert(map['emailAddress'] != null),
        assert(map['Groom_name'] != null),
        assert(map['Bride_name'] != null),
        assert(map['eventDate'] != null),
        assert(map['phone_number'] != null),
        assert(map['number_of_messages'] != null),
        assert(map['imageFileName'] != null),
        assert(map['imageUrl'] != null),
        uid = _uid,
        emailAddress = map['emailAddress'],
        Groom_name = map['Groom_name'],
        Bride_name = map['Bride_name'],
        eventDate = map['eventDate'],
        phone_number = map['phone_number'],
        imageFileName = map['imageFileName'],
        imageUrl = map['imageUrl'],
        number_of_messages = map['number_of_messages'];

  User.fromSnapshot(DocumentSnapshot snapshot,String user_uid)
      : this.fromMap(snapshot.data,user_uid,reference: snapshot.reference);




}