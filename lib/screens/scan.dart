import 'package:barcode/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:scan/scan.dart';

import 'ProductDetails.dart';

class Scan extends StatefulWidget {
  bool ?type;
   Scan({this.type});

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    ScanController controller = ScanController();
    String qrcode = 'Unknown';

     return Scaffold(
       body: Center(
        child: ScanView(
          controller: controller,
          scanAreaScale: .7,
          scanLineColor: Colors.green.shade400,
          onCapture: (data) {
            print(data);
            Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation){
                return ProductDetails(id:data, type: widget.type,);
              }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },));
          },
        ),
    ),
     );
  }
}
