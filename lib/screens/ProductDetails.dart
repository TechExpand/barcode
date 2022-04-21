
import 'package:barcode/DataProvider.dart';
import 'package:barcode/Services/Firebase/General.dart';
import 'package:barcode/Services/Newtork/network.dart';
import 'package:barcode/model/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

class ProductDetails extends StatefulWidget {
  String ?id;
  bool ?type;
   ProductDetails({this.id, this.type});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {



  var info;

  @override
  void initState(){
    WebServices network = Provider.of<WebServices>(context, listen: false);
    info =  network.getProductDetail(widget.id);
    super.initState();
    print(widget.id.toString());
    print(widget.id.toString());
  }


  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    WebServices network = Provider.of<WebServices>(context, listen: false);
    return  Material(
      child: StatefulBuilder(
          builder:(context, setState)=> FutureBuilder(
              future: info,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white10),
                      ));
                    default:
                      if (snapshot.hasError) {
                        return Container(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                            child: Center(
                                child: Text(
                                  'Something Went Wrong Try later',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                )));
                      } else {
                        return Scaffold(
                          appBar: AppBar(
                            iconTheme: IconThemeData(
                              color: Colors.white, //change your color here
                            ),
                            //centerTitle: true,
                            title: Text(data['title'], style: TextStyle(color: Colors.white),),
                          ),
                          body: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Container(
                                height: 190,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Image.network('https://'+data['image_url_1'], fit: BoxFit.fill,),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Color(0xFFECECEC),
                                  height: 30,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:3.0),
                                      child: Text('Description', style: TextStyle(
                                        fontSize: 17,
                                          color: Color(0xFF9B049B),
                                          fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['description']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Color(0xFFECECEC),
                                  height: 30,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:3.0),
                                      child: Text('Price', style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xFF9B049B),
                                          fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("₦${data['price'].toString()}", style: TextStyle(
                                    fontFamily: 'Roboto',
                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Color(0xFFECECEC),
                                  height: 30,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:3.0),
                                      child: Text('Discount', style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xFF9B049B),
                                          fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${data['discount'].toString()}%"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Color(0xFFECECEC),
                                  height: 30,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:3.0),
                                      child: Text('Amount Payable', style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xFF9B049B),
                                          fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${(double.parse(data['price'].toString())*double.parse(data['discount'].toString()))}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  color: Colors.orange,
                                  height: 1,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 34, right: 10),
                                      child: Container(
                                        child: FlatButton(
                                          onPressed: widget.type==true?()async{
                                             network.addProducts(data['id']);
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
                                             await showTextToast(
                                                 text: 'successfully added to stock.',
                                                 context: context,
                                             );
                                          }:()async{
                                            FirebaseApi.cartProduct(data, network.myemail, context);
                                            network.removeProducts(data['id']);
                                            await showTextToast(
                                                text: 'successfully added to cart.',
                                                context: context,
                                            );
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
                                                "Add to Cart",
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 34),
                                      child: Container(
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
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
                                                style: TextStyle(
                                                    color: Color(0xFF9B049B),
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
                              ),

                            ],
                          ),
                        );
                      }
                  }
                } else {
                  return Center(child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  ));
                }
              }),
        ),
    );
  }
}
