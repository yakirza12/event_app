
import 'dart:io';

import 'package:eventapp/locator.dart';
import 'package:eventapp/models/BusinessObject.dart';
import 'package:eventapp/models/BusinessesModels/BaseModel.dart';
import 'package:eventapp/services/cloud_storage_service.dart';
import 'package:eventapp/services/database.dart';
import 'package:eventapp/services/dialog_service.dart';
import 'package:eventapp/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:eventapp/locator.dart';
import 'package:eventapp/utils/image_selector.dart';




class PhotoGrafersAddViewModel extends BaseModel{

  final DatabaseService _firestoreService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
  locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Photographer _edittingPotographer;

  bool get _editting => _edittingPotographer != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      notifyListeners();
    }
  }

  Future addPhotographer({@required String Business_name, String documentId,String descreption,String phone_number,String place,
  String video,
  String photographic_still,int area}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_editting) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        business_name: Business_name,
      );
    }

    var result;
/*
Photographer(
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


*/
//not created yet
    /*
    if (!_editting) {
      result = await _firestoreService.addPhotographer(Photographer(
        name: Business_name,
        documentId: documentId,
        descreption:descreption,
        place:place,
        rate:0,
        area:area,
        phone_number:phone_number,
        photographic_still:photographic_still,
        video: video,
        imageUrl: storageResult.imageUrl,
        imageFileName: storageResult.imageFileName,
      ));
    } else {
      result = await _firestoreService.updatePhotographer(Photographer(

        name:Business_name,
        descreption: _edittingPotographer.descreption,
        place: _edittingPotographer.place,
        area: _edittingPotographer.area,
        rate:_edittingPotographer.rate,
        phone_number: _edittingPotographer.phone_number,
        photographic_still: _edittingPotographer.photographic_still,
        video: _edittingPotographer.video,
        documentId: _edittingPotographer.documentId,
        imageUrl: _edittingPotographer.imageUrl,
        imageFileName: _edittingPotographer.imageFileName,
      ));
    }
*/
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create Business Card',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

   // _navigationService.pop();
  }

  void setEdittingPotographer(Photographer edittingPhotographer) {
    _edittingPotographer = edittingPhotographer;
  }


  }