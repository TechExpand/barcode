import 'package:barcode/Services/Firebase/General.dart';
import 'package:barcode/Services/Newtork/network.dart';
import 'package:barcode/model/Product.dart';
import 'package:barcode/screens/ProductDetails.dart';
import 'package:barcode/screens/barcode.dart';
import 'package:barcode/screens/scan.dart';
import 'package:barcode/widget/Drawer.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scafoldKey = GlobalKey<ScaffoldState>();

  var info;

  @override
  void initState() {
    WebServices network = Provider.of<WebServices>(context, listen: false);
    info = network.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listImages = [
      'https://www.foodlocker.com.ng/public/product/hypo.png',
      'https://www.foodlocker.com.ng/public/product/imageedit_7_4095810893.png',
      'https://www.foodlocker.com.ng/public/product/Golden%20Penny%20Spaghetti.png',
    ];
    WebServices network = Provider.of<WebServices>(context, listen: false);
    return Scaffold(
      key: scafoldKey,
      drawer: Draw(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        leading: IconButton(
          onPressed: () {
            scafoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Card(
              child: CarouselImages(
                scaleFactor: 0.1,
                listImages: listImages,
                height: 200.0,
                borderRadius: 10.0,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.topCenter,
                onTap: (index) {
                  print('Tapped on page $index');
                },
              ),
            ),
          ),
          Container(
            height: 170,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Scan();
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
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: Text(
                            'Start Shopping',
                            style: TextStyle(
                                color: Color(0xFF9B049B),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, left: 8),
                          child: Text('Scan Code'),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 6.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black54)),
                                      child: Text(''),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 18),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black54)),
                                        child: Text(''),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: const EdgeInsets.only(right: 6.0),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.black)),
                                child: Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    width: 170,
                    decoration: BoxDecoration(
                        color: Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(3)),
                    margin: EdgeInsets.only(top: 10),
                    height: 150,
                  ),
                ),
              ),
            network.myemail=='admin@gmail.com'?Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Scan(type: true,);
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
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8),
                          child: Text(
                            'Stock Product',
                            style: TextStyle(
                                color: Color(0xFF9B049B),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, left: 8),
                          child: Text('Scan Code'),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 6.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black54)),
                                      child: Text(''),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 18),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black54)),
                                        child: Text(''),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: const EdgeInsets.only(right: 6.0),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.black)),
                                child: Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    width: 170,
                    decoration: BoxDecoration(
                        color: Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(3)),
                    margin: EdgeInsets.only(top: 10),
                    height: 150,
                  ),
                ),
              ):Container()
            ]),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 0, left: 8),
            child: Text(
              'Top Rising Products',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              height: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context, setState) => FutureBuilder(
                  future: info,
                  builder: (context, AsyncSnapshot snapshot) {
                    var data = snapshot.data;
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: data!.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return ProductDetails(
                                              id: data[index]['id'].toString());
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ));
                                },
                                child: Container(
                                  color: Color(0xFFECECEC),
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              data[index]['title'],
                                              style: TextStyle(
                                                  color: Color(0xFF9B049B),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                              "₦${data[index]['price']}",
                                              style: TextStyle(
                                                  color: Color(0xFF9B049B),
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          data[index]['description'],
                                          style: TextStyle(
                                              color: Color(0xFF9B049B)
                                                  .withOpacity(0.6),
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Center(
                            child: Text('No Data'),
                          );
                  }),
            ),
          )
          // Expanded(
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //     //  physics: NeverScrollableScrollPhysics(),
          //       itemBuilder: (context,index){
          //     return Container(
          //        child: Row(
          //          children: [
          //            Text('Start Shopping', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
          //          ],
          //        ),
          //      );
          //   }),
          // )
        ],
      ),
    );
  }
}
