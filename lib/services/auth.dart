import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{

 // HashMap<String,User> _userList = HashMap<String,User>(); //user_id and User mapUser _currentUser;
  User _currentUser;
  User get currentUser => _currentUser;

  final CollectionReference _users = DatabaseService().userCollection;

  final FirebaseAuth _auth = FirebaseAuth.instance; //singeltone of the firebase aut h object. to get all data from firebase


//create user object based firebase object
  User _userFromFirebaseUser(FirebaseUser user,String Groom_name , String Bride_name,int number_of_messages,String phone_number,String imageFileName,String imageUrl,Timestamp eventDate){ // create our user from the the firebase instance user, we want to get te functionality of the user.
    return user!=null  ? User(uid: user.uid,emailAddress: user.email, Groom_name: Groom_name,Bride_name: Bride_name,eventDate:eventDate,imageFileName: imageFileName,imageUrl: imageUrl) : null;

  }
      //.fromMap(DatabaseService().userCollection.buildArguments(),user.uid)
//auth change user stream


Stream<User> get user  { // going to return as User object was stream, and who logs in. with that info we can know how to navigate him
    return _auth.onAuthStateChanged
          .map((FirebaseUser user) => _userFromFirebaseUser(user,"","",0,"","","",Timestamp.now()));
  }


//register with email and password
Future registerWithEmailAndPassword(String email,String Password, String Groom_name , String Bride_name,int number_of_messages,String phone_number,String imageFileName,String imageUrl,Timestamp eventDate)  async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: Password);
      FirebaseUser user = result.user;

      // create Document for user database.
      await DatabaseService(uid: user.uid).updateUserData(email,Groom_name,Bride_name,number_of_messages, phone_number,imageFileName,imageUrl,eventDate); // sign the user document to get his data.
     _currentUser = _userFromFirebaseUser(user,Groom_name,Bride_name,number_of_messages, phone_number,imageFileName,imageUrl,eventDate);
    //  _userList.putIfAbsent(user.uid,() => appUser);
      return _currentUser;
    }
    catch(e){
      print(e.toString());
      return null;
    }

}
//sign in with email and password
  Future sighinWithEmailAndPassword(String email,String password)  async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(result);
      //return _userFromFirebaseUser(user, "_userList[user.uid].Groom_name","_userList[user.uid].Bride_name"); //TODO chage it because does not recognize all othe things.
     DocumentSnapshot snap = await DatabaseService().userCollection.document(user.uid).get();

      _currentUser = User.fromSnapshot(snap,user.uid);

      //print(_currentUser.Groom_name);
      //_userList.putIfAbsent(user.uid,() => appUser);
      return _currentUser;
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }
  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await DatabaseService().getUser(user.uid);
    }
  }

/*
//sign in anon not will use it in my app
Future signInAnon() async {
  try{
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user ," " ," "); // add empty string fot the othr func.
  } catch(e){
    print(e.toString());
    return null;
    }
  }*/





  //register with facebook account

  //register with google account

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }

  }

}