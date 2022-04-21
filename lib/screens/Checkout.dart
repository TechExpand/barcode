

import 'dart:io';

import 'package:barcode/Services/Firebase/General.dart';
import 'package:barcode/Services/Newtork/network.dart';
import 'package:barcode/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  var amount;
   Checkout(this.amount);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var publicKey = 'pk_test_5c965cdcf6402965f3d962d93b1b8edd0fbdcdd1';
  final plugin = PaystackPlugin();

  @override
  void initState(){
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }



  final form_key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  final  scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String _getReference() {
      String platform;
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }
      return 'ChargedFrom${platform}_${DateTime
          .now()
          .millisecondsSinceEpoch}';
    }



    paymentMethod(amount, email)async{
      Charge charge = Charge()
        ..amount = amount
        ..reference = _getReference()
        ..email = email;
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
      );
      if (response.status) {
        print(response.reference);
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
    }




    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Checkout', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: form_key,
          child: ListView(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Full Name', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  controller: fullname,
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Full Name Cannot be Emoty!';
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Full Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Email', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Email Cannot be Emoty!';
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: email,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Mobile Number', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Mobile Number Cannot be Emoty!';
                    }
                  },
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: phone,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Mobile Number',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:8.0, right:8, top:20),
                child: Text('Billing Address', style: TextStyle(color: Color(0xFF9B049B),
                    fontWeight: FontWeight.bold, fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Adreess', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Address Cannot be Emoty!';
                    }
                  },
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: address,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Address',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('City', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'City Cannot be Emoty!';
                    }
                  },
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: city,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'City',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('State', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'State Cannot be Emoty!';
                    }
                  },
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: state,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'State',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Country', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Country Cannot be Emoty!';
                    }
                  },
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: country,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Country',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only( top: 34, right: 10),
                    child: Container(
                      child: FlatButton(
                        onPressed: () {
                          if(form_key.currentState!.validate()) {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            paymentMethod(
                                int.parse(double.parse(widget.amount.toString()+'0').floor().toString()+"00"),
                                email.text);
                          }
                          },
                        color: Color(0xFFFEB904),
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
                              "Make Payment",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( top: 34),
                    child: Container(
                      child: FlatButton(
                        onPressed: () {
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
                        },
                        color: Color(0xFF9B049B).withOpacity(0.3),
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
                              "Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],),
        ),
      ),
    );
  }
}
