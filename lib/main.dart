import 'package:barcode/Services/Newtork/network.dart';
import 'package:barcode/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'DataProvider.dart';

void main() {
  getfireBase()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Provider.debugCheckInvalidValueType = null;
  }
  getfireBase();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
    ),
    ChangeNotifierProvider<WebServices>(
      create: (context) => WebServices(),
    ),
  ], child: MyApp())); // MyApp(widget)));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Shop',
      theme: ThemeData(
        accentColor: Colors.orange,
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SignUp(),
    );
  }
}