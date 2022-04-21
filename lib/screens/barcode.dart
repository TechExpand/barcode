import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:barcode/Services/Firebase/General.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
// import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../DataProvider.dart';

/// Creates the barcode generator
class BarCode extends StatelessWidget {

  final  _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productdes = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDiscount = TextEditingController();
  final form_key = GlobalKey<FormState>();
  static final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  ScreenshotController controller = ScreenshotController();

  String barValue = getRandomString(12);
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);

    return  Scaffold(
      key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Barcode Generator'),
          ),
          body: Form(
            key: form_key,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Name',
                    style: TextStyle(
                        color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.2,
                    height: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        //data.setEmail(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Product Name Cannot be Empty!';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      controller: productName,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        labelText: 'Product Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Description',
                    style: TextStyle(
                        color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.2,
                    height: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        //data.setEmail(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Product Description Cannot be Empty!';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      controller: productdes,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        labelText: 'Product Description',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Price',
                    style: TextStyle(
                        color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.2,
                    height: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        //data.setEmail(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Product Price Cannot be Empty!';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: productPrice,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        labelText: 'Product Price',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Discount',
                    style: TextStyle(
                        color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.2,
                    height: 50,
                    child: TextFormField(
                      onChanged: (value) {
                        //data.setEmail(value);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Product Discount Cannot be Empty!';
                        }
                      },
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: productDiscount,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        labelText: 'Product Discount',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product BarCode: (Paste this code on the desired product)',
                    style: TextStyle(
                        color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                  ),
                ),
                // Screenshot(
                //   controller: controller,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Center(
                //         child: Container(
                //           height: 100,
                //           child: SfBarcodeGenerator(
                //             value: barValue,
                //             symbology: Code128(),
                //             showValue: false,
                //           ),
                //         )),
                //   ),
                // ),
                TextButton(onPressed: ()async{
                  await controller.capture(delay: const Duration(milliseconds: 10)).
                  then((Uint8List? image) async {
                    if (image != null) {
                      final directory = await getApplicationDocumentsDirectory();
                      final imagePath = await File('${directory.path}/image.png').create();
                      await imagePath.writeAsBytes(image);
                      await Share.shareFiles([imagePath.path]);
                    }
                  });


                }, child: Text('Save/Capture BarCode')),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 100, // card height
                            child: dataProvider.selectedImage == null
                                ? Text('No Image Selected')
                                : Container(
                              width: 100,
                              child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  child: Image.file(
                                    File(
                                      dataProvider.selectedImage!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(26)),
                              child: FlatButton(
                                disabledColor: Color(0xFF9B049B),
                                onPressed: () {
                                  dataProvider
                                      .selectImage(source: ImageSource.gallery)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                color: Color(0xFF9B049B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                        MediaQuery.of(context).size.width / 1.3,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Select/Upload Product Photo",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),


                Padding(
                  padding: EdgeInsets.all(34),
                  child: Container(
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        if(form_key.currentState!.validate()){
                          FirebaseApi.call(context);
                          FirebaseApi.createProduct(
                              barValue,
                              productName.text,
                              productdes.text,
                              productPrice.text,
                              context,
                              _scaffoldKey,
                            dataProvider.selectedImage,
                            productDiscount.text,
                          );
                        }
                      },
                      color: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26)),
                        child: Container(
                          constraints:
                          BoxConstraints(maxWidth: 150.0, minHeight: 53.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Add Product",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
  }
  //
  // saveImage(image)async{
  //   final directory = (await getApplicationDocumentsDirectory ()).path; //from path_provide package
  //   String fileName = DateTime.now().microsecondsSinceEpoch.toString();
  //   final path = '$directory';
  //
  //   controller.captureAndSave(
  //   path,
  //   fileName:fileName
  //   ).then((value){
  //     GallerySaver.saveImage(path).then((path){
  //         print('image saved!');
  //         print(path);
  //     });
  //   });
  // }




}