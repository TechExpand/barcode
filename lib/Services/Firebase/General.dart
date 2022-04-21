import 'dart:io';
import 'package:barcode/Services/Newtork/network.dart';
import 'package:path/path.dart' as Path;
import 'package:barcode/screens/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../DataProvider.dart';

class FirebaseApi {
  static call(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 0,
            child: CupertinoActivityIndicator(
              radius: 40,
            ),
            backgroundColor: Colors.transparent,
          );
        });
  }

  static sendPassWordResetEmail(email, _scaffoldKey, context) {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Sent Successfully. Check your mail inbox')));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('This user does not exist.')));
      }
    }
  }
  static getProductDetail(id){
    var data = FirebaseFirestore.instance
        .collection('Product').doc(id);
    return data.snapshots();
  }


  static getProduct(){
    var data = FirebaseFirestore.instance
        .collection('Product');
    return data.snapshots();
  }


  static getCart(context){
    WebServices network = Provider.of<WebServices>(context, listen: false);
    var data = FirebaseFirestore.instance
        .collection('Cart').where('userid', isEqualTo: network.myemail.toString());
    return data.snapshots();
  }


  static deleteCart(id){
    var data = FirebaseFirestore.instance
        .collection('Cart');
     data.doc(id).delete();
  }


  static cartProduct(product, userid, context){
    final refMessages = FirebaseFirestore.instance.collection('Cart');
    refMessages.doc().set({
      'userid': userid,
      'proName': product['title'],
      'productDiscount':  product['discount'],
      'proDes': product['description'],
      'proPrice': product['price'],
      'picture': 'https://'+product['image_url_1'],
      'createdAt': DateTime.now(),
    });

    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return HomePage();
          },
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ));
  }

  static Future createProduct(String id, proName, proDes, proPrice, context,_scaffoldKey,path, productDiscount,) async {
    final refMessages = FirebaseFirestore.instance.collection('Product');

    Reference storageReferenceImage = FirebaseStorage.instance
        .ref()
        .child('image/${Path.basename(path.path)}');

    UploadTask uploadTask = storageReferenceImage.putFile(File(path.path));
    uploadTask.then((res) {
      storageReferenceImage.getDownloadURL().then((imageurl) async {
        print(imageurl);
         refMessages.doc(id).set({
          'proName': proName,
           'productDiscount':  productDiscount,
          'proDes': proDes,
          'proPrice': proPrice,
          'picture': imageurl,
          'createdAt': DateTime.now(),
        });
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return HomePage();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ));

      });
    });
  }

  static Future Login(String email, password, context, scaffoldkey) async {
    DataProvider provide = Provider.of<DataProvider>(context, listen: false);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.pop(context);
        print(userCredential.user!.uid);
        provide.setUserID(userCredential.user!.uid);
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return HomePage();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ));

        return userCredential.user!.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        scaffoldkey.currentState.showSnackBar(
            SnackBar(content: Text(e.code.toString().replaceAll('-', ' '))));
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        scaffoldkey.currentState.showSnackBar(
            SnackBar(content: Text(e.code.toString().replaceAll('-', ' '))));
      } else {
        Navigator.pop(context);
        scaffoldkey.currentState.showSnackBar(
            SnackBar(content: Text(e.code.toString().replaceAll('-', ' '))));
      }
    }
  }

  static Future register(String email, password, context, _scaffoldkey) async {
    DataProvider provide = Provider.of<DataProvider>(context, listen: false);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Navigator.pop(context);
        print(userCredential.user!.uid);
        provide.setUserID(userCredential.user!.uid);
        //  createProfile(userCredential.user!.uid,username, name , number);
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return HomePage();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ));
        return userCredential.user!.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.code);
        Navigator.pop(context);
        _scaffoldkey.currentState.showSnackBar(
            SnackBar(content: Text('The password provided is too weak.')));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print(e.code);
        Navigator.pop(context);
        _scaffoldkey.currentState.showSnackBar(SnackBar(
            content: Text('The account already exists for that email.')));

        print('The account already exists for that email.');
      } else {
        print(e.code);
        Navigator.pop(context);
        _scaffoldkey.currentState.showSnackBar(
            SnackBar(content: Text(e.code.toString().replaceAll('-', ' '))));
      }
    } catch (e) {
      print(e);
    }
  }
}
