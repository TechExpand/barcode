

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class DataProvider extends ChangeNotifier{

 String  firebaseUserId = '';

  void setUserID(id) {
    firebaseUserId = id;
    notifyListeners();
  }

 final ImagePicker _picker = ImagePicker();

 XFile?  selectedImage;
 Future selectImage({ source, context}) async {
   final XFile? image = await _picker.pickImage(source: source);
   selectedImage = image;
   notifyListeners();
 }


}