import 'package:barcode/Services/Firebase/General.dart';
import 'package:barcode/model/Product.dart';
import 'package:barcode/screens/Checkout.dart';
import 'package:barcode/screens/ProductDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {

    double totalAmount= 0.0;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Material(
          child: Container(
            height: 60,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10, top: 5),
                      child: Container(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return Checkout(totalAmount);
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
                                "Check-out",
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
                      padding: EdgeInsets.only(top:5),
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
                                "Exit Cart",
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
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Cart', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulBuilder(
          builder: (context, setState) => StreamBuilder(
              stream: FirebaseApi.getCart(context),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<ProductModel> product;
                  product = snapshot.data!.docs
                      .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
                      .toList();

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white10),
                          ));
                    default:
                      if (snapshot.hasError) {
                        return Container(
                            padding:
                            EdgeInsets.only(left: 20, right: 20, top: 15),
                            child: Center(
                                child: Text(
                                  'Something Went Wrong Try later',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )));
                      } else {
                        final verifiedproduct = product;
                        if (verifiedproduct.isEmpty) {
                          return Container(
                              padding:
                              EdgeInsets.only(left: 20, right: 20, top: 15),
                              child: Center(
                                  child: Text(
                                    'No Products Available',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )));
                        } else {
                          return ListView.builder(
                              itemCount: verifiedproduct.length + 1,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                double total = 0.0;
                                for (var v in verifiedproduct)
                                  total = (total + (double.parse(v.proPrice.toString()) * double.parse(v.productDiscount.toString())));
                                 totalAmount = total;
                                return index == verifiedproduct.length
                                    ? Container(
                                  height: 50,
                                  color: Color(0xFFECECEC),
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3.0),
                                        child: Text(
                                          "Grand Total",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 17,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right:3.0),
                                        child: Text(
                                          "₦$total",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 17,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    : Column(
                                  children: [
                                    Container(
                                      color: Color(0xFFECECEC),
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              "Product ${index + 1}",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              FirebaseApi.deleteCart(
                                                  verifiedproduct[index]
                                                      .id);
                                            },
                                            child: Container(
                                              width: 60,
                                              color: Colors.orange,
                                              child: Center(
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0),
                                          child: Text(
                                            'Price',
                                            style: TextStyle(
                                                color: Color(0xFF9B049B),
                                                fontSize: 17,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0),
                                          child: Text(
                                            "₦${verifiedproduct[index].proPrice}",
                                            style: TextStyle(
                                                color: Color(0xFF9B049B),
                                                fontFamily: 'Roboto',
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Quantity',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xFF9B049B),
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xFF9B049B),
                                                  fontFamily: 'Roboto',
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Discount',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xFF9B049B),
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                              "${verifiedproduct[index].productDiscount}%",
                                              style: TextStyle(
                                                  color:
                                                  Color(0xFF9B049B),
                                                  fontFamily: 'Roboto',
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Subtotal',
                                              style: TextStyle(
                                                  color: Color(0xFF9B049B),
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                              "₦${(double.parse(verifiedproduct[index].proPrice.toString()) * double.parse(verifiedproduct[index].productDiscount.toString()))}",
                                              style: TextStyle(
                                                  color: Color(0xFF9B049B),
                                                  fontFamily: 'Roboto',
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                );
                              });
                        }
                      }
                  }
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.white10),
                      ));
                }
              }),
        ),
      ),
    );
  }
}
