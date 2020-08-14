import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{
  final String uid;
  DatabaseService({ this.uid });

//collection  reference
final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference guestsCollection = Firestore.instance.collection('users'); // will create even does note exist on firestore.


Future updateUserData(String emailAddress ,String Groom_name ,String Bride_name) async
    {
      return await userCollection.document(uid).setData({
        'emailAddress': emailAddress,
        'Groom_name' : Groom_name,
        'Bride_name' : Bride_name
      });
    }

   Future addGuestData(String index ,String proximityGroup ,String last_name ,String first_name,int quantity_invited) async {
     return await userCollection.document(uid).collection('guests').document(index).
     setData({
       'proximityGroup': proximityGroup,
       'last_name' : last_name,
       'first_name' : first_name,
       'quantity_invited' : quantity_invited
     });
     
   }
/* For Update The data Cell**/
  Future updateGuestsData(String proximityGroup ,String last_name ,String first_name,int quantity_invited) async
  {
    return await guestsCollection.document(uid).setData({
      'proximityGroup': proximityGroup,
      'last_name' : last_name,
      'first_name' : first_name,
      'quantity_invited' : quantity_invited
    });
  }

/*
  //get list guests from snapshot
  List<Guest> _guestsListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.documents.map( (doc) {
        return Guest(
           proximityGroup: doc.data['proximityGroup'] ?? '',
             last_name :doc.data['last_name'] ?? '',
            first_name : doc.data['first_name'] ?? '',
            quantity_invited: doc.data['quantity_invited'] ?? 0,
        );
      }).toList();
  }
 //get guests stream
  Stream<List<Guest>> get guests{
  return  guestsCollection.document(uid).collection('guests').snapshots().map(
    _guestsListFromSnapshot);
  }



}
*/
}