import 'package:cloud_firestore/cloud_firestore.dart';

class Guest{

 final String proximityGroup;
 final String last_name;
 final String first_name;
 final int quantity_invited;
 final DocumentReference reference;

//Guest({this.last_name,this.first_name,this.proximityGroup,this.quantity_invited}); // the constructor.

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
 }


