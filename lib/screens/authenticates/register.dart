import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/screens/home/Businesses/AddBusinessForms/AddPhotographerForm.dart';
import 'package:eventapp/services/cloud_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:eventapp/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import '../../locator.dart';

StorageUploadTask _uploadTask;
String filePath;

class Uploader extends StatefulWidget {
  final File file;
  CloudStorageResult storageResult;

  Uploader({Key key, this.file, this.storageResult}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =  FirebaseStorage(storageBucket: 'gs://heppyvents.appspot.com');

  var downloadUrl;

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file
    filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            if (_uploadTask.isComplete) {
              widget.storageResult = CloudStorageResult(
                imageUrl: downloadUrl.toString(),
                imageFileName: widget.file.toString(),
              );
            }

            return Column(
              children: [
                if (_uploadTask.isComplete) Text('🎉🎉🎉'),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = locator<AuthService>();

  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String Groom_name = ''; // hatan
  String Bride_name = ''; // kala
  int number_of_messages = 0;
  String phone_number = '';
  String imageFileName = "";
  String imageUrl = "";
  String error = " ";
  Timestamp date;
  DateTime _dateTime;
  File _imageFile;
  static CloudStorageResult _storageResult;

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _imageFile = null;
      _uploadTask = null;
    });

    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          //for the appbar
          elevation: 0.0,
          // elevation from the screen
          title: Text(
            'הרשמה',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(
                'רשום?',
                style: TextStyle(fontSize: 10),
              ),
              onPressed: () {
                widget.toggleView(); // this is how we call to the function
              },
            )
          ],
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            // wil help as to scroling down with no issuse
            //  padding: EdgeInsets.symmetric(vertical: 40.0,horizontal: 22.0),
            //0774493080
            child: Container(
              padding: EdgeInsets.only(top: 8.0 ,left: _size.width * 0.1,right: _size.width * 0.1),
              /*
              padding: EdgeInsets.symmetric(
                  vertical: _size.height * 0.04, horizontal: _size.width * 0.1),*/
              height: MediaQuery.of(context).size.height * 1.195,
              decoration: BoxDecoration(
                //color: Color(0xFFFFCCBF),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.83), BlendMode.dstATop),
                  image: AssetImage("assets/HappyPhoto2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                  key: _formKey, // keep truck to our form, for validate.
                  child: Column(
                    children: <Widget>[
                      /*SizedBox(height: 20.0
                      ,child: Text("הרשמה"),),*/
                      Padding(
                          padding: EdgeInsets.only(
                            top: _size.height * 0.02,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: _size.width * 0.04),
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? "הכנס מייל" : null,
                                decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    labelText: "הכנס מייל"),
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                            ),
                          )),
//Spacer(),
                      // new Padding(padding: EdgeInsets.all(20.0)),
                      Padding(
                        padding: EdgeInsets.only(
                          top: _size.height * 0.02,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: _size.width * 0.04),
                            child: TextFormField(
                              validator: (val) => val.length < 6
                                  ? "Enter password longer then 6"
                                  : null,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  labelText: "סיסמה"),
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                              obscureText: true,
                              //for password
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      //  new Padding(padding: EdgeInsets.all(8.0)),

                      Padding(
                          padding: EdgeInsets.only(
                            top: _size.height * 0.02,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: _size.width * 0.04),
                                child: TextFormField(
                                  validator: (val) => val.length < 2
                                      ? "Enter valied name"
                                      : null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      labelText: "שם החתן"),
                                  keyboardType: TextInputType.emailAddress,
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      Groom_name = val;
                                    });
                                  },
                                ),
                              ))),
                      //new Padding(padding: EdgeInsets.all(8.0)),
                      Padding(
                          padding: EdgeInsets.only(
                            top: _size.height * 0.02,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: _size.width * 0.04),
                                child: TextFormField(
                                  validator: (val) => val.length < 2
                                      ? "Enter valied name"
                                      : null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      labelText: "שם הכלה"),
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      Bride_name = val;
                                    });
                                  },
                                ),
                              ))),
                      Padding(
                          padding: EdgeInsets.only(
                            top: _size.height * 0.02,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: _size.width * 0.04),
                                child: TextFormField(
                                  validator: (val) => val.length < 2
                                      ? "Enter valied Phone Number"
                                      : null,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      labelText: "מספר טלפון"),
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      phone_number = val;
                                    });
                                  },
                                ),
                              ))),
                      Text(
                        'תמונת פרופיל',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal[400],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _pickImage(ImageSource.gallery),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.grey[200].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          // If the selected image is null we show "Tap to add post image"
                          child: _imageFile == null
                              ? Text(
                                  'Tap to add profile image',
                                  style: TextStyle(color: Colors.black),
                                )
                              // If we 90have a selected image we want to show it
                              : Uploader(
                                  file: _imageFile,
                                  storageResult: _storageResult,
                                ), /*

                        */ //Image.file(_imageFile),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(_dateTime == null
                                  ? 'תאריך האירוע לא נבחר עדיין'
                                  :" התאריך שנבחר: " + _dateTime.year.toString() + " - "  + _dateTime.month.toString() + " - " + _dateTime.day.toString() ,style: TextStyle(fontSize: 14,color: _dateTime == null?Colors.red:Colors.teal[400]),),
                              InkWell(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: _dateTime == null
                                                ? DateTime.now()
                                                : _dateTime,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2025))
                                        .then((date) {
                                      setState(() {
                                        _dateTime = date;
                                      });
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),//horizontal: 10),

                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: _size.height*0.063,vertical: _size.width*0.05),
                                        child: Text(_dateTime == null?'לחץ על-מנת לבחור תאריך':'ערוך בחירה',style: TextStyle(fontSize: 16),)),
                                  ))
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          if (
                          _formKey.currentState
                              .validate()) //will check if our from is legi
                             {
                            StorageTaskSnapshot storageSnapshot =
                            await _uploadTask.onComplete;
                            dynamic downloadUrl = await storageSnapshot.ref.getDownloadURL();
                            String imageUrl1 = downloadUrl.toString();
                            dynamic result = await _auth.registerWithEmailAndPassword(
                                email,
                                password,
                                Groom_name,
                                Bride_name,
                                number_of_messages,
                                phone_number,
                                Groom_name + " " + Bride_name + " " +  filePath,
                                imageUrl1,
                                Timestamp.fromDate(_dateTime));
                            if (result == null) {
                              setState(() => error =
                              'Could not sign in with those credentials'); //TODO check
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),//horizontal: 10),

                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.pink[52],
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical:_size.width*0.05, horizontal: _size.height*0.14),
                            child: Text(
                              'הרשמה',
                              style: TextStyle(color: Colors.white,fontSize: 22),
                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
          );
        }));
  }
}
