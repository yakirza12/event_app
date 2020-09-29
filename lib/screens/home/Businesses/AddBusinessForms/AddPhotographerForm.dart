import 'dart:io';
import 'package:eventapp/services/cloud_storage_service.dart';
import 'package:eventapp/models/BusinessObject.dart';
import 'package:eventapp/models/BusinessesModels/PhotographerViewModel.dart';
import 'package:eventapp/models/user.dart';
import 'package:eventapp/screens/home/Guests/Guest_System/guestForm.dart';
import 'package:eventapp/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../../locator.dart';



StorageUploadTask _uploadTask;
String filePath;


class Uploader extends StatefulWidget {
  final File file;
  CloudStorageResult storageResult;


  Uploader({Key key,this.file,this.storageResult}):super(key:key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://heppyvents.appspot.com');


  var downloadUrl;

  /// Starts an upload task
  void _startUpload() {

    /// Unique file name for the file
    filePath = 'images/${DateTime.now()}.png';

    setState(()  {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);

    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
     /* if(_uploadTask.isComplete){
        widget.storageResult = CloudStorageResult(
          imageUrl: downloadUrl.toString(),
          imageFileName: widget.file.toString(),
        );
      }*/

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;


             if(_uploadTask.isComplete){
        widget.storageResult = CloudStorageResult(
          imageUrl: downloadUrl.toString(),
          imageFileName: widget.file.toString(),
        );
      }


            return Column(

              children: [
                if (_uploadTask.isComplete)
                  Text('🎉🎉🎉'),


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
                Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                ),
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



class AddPhotographerForm extends StatefulWidget {
  final titleController = TextEditingController();

  //final Photographer edittingPhotographer;
  //final User user;
//  AddPhotographerForm(this.user);
  AddPhotographerForm({Key key});

  @override
  _AddPhotographerFormState createState() => _AddPhotographerFormState();
}

class _AddPhotographerFormState extends State<AddPhotographerForm> {
  final _formKey = GlobalKey<
      FormState>(); //because they are dependence each other (the forms).


  String index = UniqueKey().toString();
  String name = '';
  String descreption = '';
  String phone_number = " ";

  String place = '';
  String video = " ";
  String photographic_still = " ";

  int area = 0;
  int rate = 0;
  String imageFileName = "";
  String imageUrl = "";
  String error = " ";
  File _imageFile;

  final CloudStorageService _cloudStorageService =
  CloudStorageService();

    static CloudStorageResult _storageResult;

  Future<void> _pickImage(ImageSource source) async{
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final DatabaseService _firestoreService = locator<DatabaseService>();
    return /*ViewModelBuilder<PhotoGrafersAddViewModel>.reactive(
    viewModelBuilder: () => PhotoGrafersAddViewModel(),
    onModelReady: (model) {
    // update the text in the controller
    widget.titleController.text = widget.edittingPhotographer?.name ?? '';

    model.setEdittingPotographer(widget.edittingPhotographer);
    },
    builder: (context, model, child) => Scaffold(
      appBar: AppBar(
     //   leading: IconButton(icon:Icon(Icons.keyboard_backspace),
   // onPressed: ()=>Navigator.pop(context),),
    centerTitle: true,
    title: Text("Photographers"),),
      body: */
        SingleChildScrollView(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            key: _formKey, // keep truck to our form, for validate.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.length < 1
                      ? "Enter Valid Business Name (at least two words)"
                      : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Business Name"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) =>
                      val.length < 4 ? "Add more words please" : null,
                  minLines: 7,
                  maxLines: 12,
                  maxLength: 256,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Describe Your Business Service"),
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      descreption = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) =>
                      val.length < 0 ? "Enter Number Between 1 to 4" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Area"),
                  keyboardType: TextInputType.number,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      area = val as int;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Add number please" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Phone number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      phone_number = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) =>
                      val.length < 4 ? "Type true or type false" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "Video? Type true or false"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      video = val;
                    });
                  },
                ),
                new Padding(padding: EdgeInsets.all(8.0)),
                TextFormField(
                  validator: (val) =>
                      val.length < 4 ? "Type true or type false" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                      labelText: "still? Type true or false"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                  onChanged: (val) {
                    setState(() {
                      photographic_still = val;
                    });
                  },
                ),
                Text('Post Image'),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    // If the selected image is null we show "Tap to add post image"
                    child: _imageFile == null
                        ? Text(
                            'Tap to add post image',
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        // If we 90have a selected image we want to show it
                        :Uploader(file: _imageFile, storageResult:_storageResult,),/*

                        *///Image.file(_imageFile),
                  ),
                ),
                RaisedButton(
                  color: Colors.pink[52],
                  child: Text(
                    'Add PhotoGrapher',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final form = _formKey.currentState;
                    form.save();
                    if (form.validate()) //will check if our from is legit
                    {

                      StorageTaskSnapshot storageSnapshot =  await _uploadTask.onComplete;
                      dynamic downloadUrl = await storageSnapshot.ref.getDownloadURL();
                      String imageUrl1 = downloadUrl.toString();

                      // if (!model.busy) {
                      dynamic result =
                          await DatabaseService().addPhotographer(Photographer(
                        name: name,
                        documentId: index,
                        descreption: descreption,
                        place: place,
                        rate: 0,
                        area: area,
                        phone_number: phone_number,
                        photographic_still: photographic_still,
                        video: video,
                        imageUrl: imageUrl1,
                        imageFileName: name + filePath,
                      ));
                      Navigator.pop(context);
                      if (result == null) {
                        setState(() => error =
                            'Could not sign in with those credentials'); //TODO check
                      }
                      /* model.addPhotographer(Business_name:name,
                                                documentId: index,
                                                descreption:descreption,
                                                place:place,
                                                area:area,
                                                phone_number:phone_number,
                                                photographic_still:photographic_still,
                                                video: video,
                                                );
                          //}

                        dynamic result = await DatabaseService(uid: widget.user.uid)
                            .addGuestData(index, proximityGroup, last_name,
                            first_name, quantity_invited,phone_number);
                        Navigator.pop(context);
                        if (result == null) {
                          setState(() => error =
                          'Could not sign in with those credentials'); //TODO check
                        }*/
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {//Capture image from gallery and allow to user to crop or resize it
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  
  Future<void> _pickImage(ImageSource source) async{
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = selected;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


