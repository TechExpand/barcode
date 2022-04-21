import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:barcode/screens/HomePage.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class WebServices extends ChangeNotifier {
  String username = "";
  String myemail = "";
  String myphonenumber = "";
  String wallet = "";
  dynamic points;
  dynamic walletpoints;
  int id = 0;
  String token = "";
  String image = '';
  String editname = "";
  String editphone = "";
  String userType = '';
  final box = GetStorage();
  var path = '';



  setPath(value){
    path = value;
    notifyListeners();
  }

  setUserType(value){
    userType = value;
    notifyListeners();
  }


  setToken(value){
    token = value;
    notifyListeners();
  }






  Future<dynamic> Register({context, email, password, confirm,name}) async {
    try {
      var response = await http.post(
          Uri.parse('https://shopping.app.optimalvisionuk.co.uk/api/register'),
          body: jsonEncode(<String, String>{
            'email': email.toString(),
            'password_confirmation': confirm.toString(),
            'name': name.toString(),
            'password': password.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        // username = body['fullname'];
        // myemail = body['email'];
        // myphonenumber = body['phonenumber'];
        // wallet = body['wallet'];
        // walletpoints = body['walletpoints'];
        // points = body['weight'];
        token = body['token'];
        box.write('tokens', token.toString());

        Navigator.pop(context);
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
          ),
        );
      }
      else {
        print(body);
        Navigator.pop(context);
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print('jaaa');
      Navigator.pop(context);
      print(e);
    }
  }



  Future<dynamic> Login({context, email, password}) async {
    try {
      var response = await http.post(
          Uri.parse('https://shopping.app.optimalvisionuk.co.uk/api/login'),
          body: jsonEncode(<String, String>{
            'email': email.toString(),
            'password': password.toString(),
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //  'Authorization': 'Bearer $bearer',
          });

      var body = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        // username = body['fullname'];

        // myphonenumber = body['phonenumber'];
        // wallet = body['wallet'];
        // walletpoints = body['walletpoints'];
        // points = body['weight'];
        myemail = body['user']['email'];
        token = body['token'];
        box.write('tokens', token.toString());
print(body);
        Navigator.pop(context);
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
          ),
        );
      }else if(body['message'] == 'Your email or password is incorrect'){
        Navigator.pop(context);
        await showTextToast(
          text: 'you entered an invalid credential',
          context: context,
        );
      }
      else {
        print(body);
        Navigator.pop(context);
        await showTextToast(
          text: 'A Problem was Encountered.',
          context: context,
        );
      }
      notifyListeners();
    } catch (e) {
      print('jaaa');
      Navigator.pop(context);
      print(e);
    }
  }







  Future removeProducts(id) async {
    var response = await http.put(
        Uri.parse(
            'https://shopping.app.optimalvisionuk.co.uk/api/products/${id.toString()}/remove-stock'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
    // var body = json.decode(response.body);
    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return 'good';
    } else {
      return 'failed';
    }
  }

  Future addProducts(id) async {
    var response = await http.put(
        Uri.parse(
            'https://shopping.app.optimalvisionuk.co.uk/api/products/${id.toString()}/add-stock'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
    // var body = json.decode(response.body);
    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return 'good';
    } else {
      return 'failed';
    }
  }






  Future getProducts() async {
      var response = await http.get(
          Uri.parse(
              'https://shopping.app.optimalvisionuk.co.uk/api/products'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            //'Authorization': 'Token $token',
          });
      var body = json.decode(response.body);
print(body);
      List body1 = body['data'];
      notifyListeners();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return body1;
      } else {
        return 'failed';
      }
    }


  Future getProductDetail(id) async {
    var response = await http.get(
        Uri.parse(
            'https://shopping.app.optimalvisionuk.co.uk/api/products/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': 'Token $token',
        });
    var body = json.decode(response.body);
    print(body);
    var body1 = body['data'];
    notifyListeners();
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      return body1;
    } else {
      return 'failed';
    }
  }
}