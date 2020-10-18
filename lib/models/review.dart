import 'package:cloud_firestore/cloud_firestore.dart';

class Review {

  final String name_of_reviewer;
  final String name_of_business;
  final String user_uid;
  final String business_doc_id;
  final String descreption;
  final Timestamp dateTime;
  final int rate;
  final DocumentReference reference;


  Review.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name_of_reviewer'] != null),
        assert(map['name_of_business'] != null),
        assert(map['user_uid'] != null),
        assert(map['business_doc_id'] != null),
        assert(map['descreption'] != null),
        assert(map['dateTime'] != null),
        assert(map['rate'] != null),
        name_of_reviewer = map['name_of_reviewer'],
        name_of_business = map['name_of_business'],
        user_uid = map['user_uid'],
        business_doc_id = map['business_doc_id'],
        descreption = map['descreption'],
        dateTime = map['dateTime'],
        rate = map['rate'];

  Review.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}