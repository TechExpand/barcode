import 'dart:io';
import 'package:barcode/screens/Cart.dart';
import 'package:barcode/screens/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Draw extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: Container(
          color: Colors.orange,
          child: Column(
            children: [
              DrawerHeader(
                  child: Center(
                    child:  Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Text('BARCODE SHOP', style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),),
                    ),
                  )),

              ListTile(
                onTap: (){
                  Navigator.push(context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Cart();
                        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },));
                },
                leading: Icon(Icons.shopping_cart, color: Colors.white,),
                title: Text(
                  'Cart',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,  fontSize: 16,),
                ),
              ),
              Divider(color: Colors.black26, thickness: 0.3,),
              ListTile(
                onTap: (){
                  exit(0);
                },
                leading: Icon(Icons.exit_to_app, color: Colors.white,),
                title: Text(
                  'Exit',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,  fontSize: 16,),
                ),
              ),

              Divider(color: Colors.black26, thickness: 0.3,),
            ],
          ),
        ),
      ),
    );
  }
}
