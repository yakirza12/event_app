import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/BusinessObject.dart';
import 'package:flutter/services.dart';


class DatabaseService {
  final String uid;

  DatabaseService({ this.uid });


//collection  reference
  final CollectionReference userCollection =
  Firestore.instance.collection('users');
  final CollectionReference guestsCollection =
  Firestore.instance.collection(
      'users'); // will create even does note exist on firestore.

  final CollectionReference _photographersCollectionReference =
  Firestore.instance.collection('Businesses').document('Photograph').collection(
      'Photograpes');


  final StreamController<List<Photographer>> _photographersController =
  StreamController<List<Photographer>>.broadcast();


  Future updateUserData(String emailAddress, String Groom_name,
      String Bride_name, number_of_messages) async
  {
    return await userCollection.document(uid).setData({
      'emailAddress': emailAddress,
      'Groom_name': Groom_name,
      'Bride_name': Bride_name,
      'number_of_messages': number_of_messages,
    });
  }

  Future addGuestData(String index, String proximityGroup, String last_name,
      String first_name, int quantity_invited, String phone_number) async {
    return await userCollection.document(uid).collection('guests').document(
        index).
    setData({
      'proximityGroup': proximityGroup,
      'last_name': last_name,
      'first_name': first_name,
      'quantity_invited': quantity_invited,
      'phone_number': phone_number
    });
  }


/* For Update The data Cell**/
  Future updateGuestsData(String proximityGroup, String last_name,
      String first_name, int quantity_invited, String phone_number) async
  {
    return await guestsCollection.document(uid).setData({
      'proximityGroup': proximityGroup,
      'last_name': last_name,
      'first_name': first_name,
      'quantity_invited': quantity_invited,
      'phone_number': phone_number
    });
  }


  Future addPhotographer(Photographer photographer_bussines) async {
    try {
      await _photographersCollectionReference.add(
          photographer_bussines.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }


  Stream listenToPhotographerRealTime() {
    // Register the handler for when the posts data changes
    _photographersCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) =>
            Photographer.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.name != null)
            .toList();

        // Add the posts onto the controller
        _photographersController.add(posts);
      }
    });

    return _photographersController.stream;
  }

  Future deletePhotographer(String documentId) async {
    await _photographersCollectionReference.document(documentId).delete();
  }

  Future updatePhotographer(Photographer photographer_bussines) async {
    try {
      await _photographersCollectionReference
          .document(photographer_bussines.documentId)
          .updateData(photographer_bussines.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
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
