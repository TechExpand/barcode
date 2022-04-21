import 'package:barcode/Services/Firebase/General.dart';
import 'package:barcode/Services/Newtork/network.dart';
import 'package:barcode/screens/HomePage.dart';
import 'package:barcode/screens/SignIn.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form_key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  final  scaffoldkey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      return decideFirstWidget(context);
    });
  }


  Future<dynamic> decideFirstWidget(context) async {
    final box = GetStorage();
    var network = Provider.of<WebServices>(context, listen: false);
    var  token = box.read('tokens');
    print(token);
    print(token);
    print(token);
    if (token == null || token =='null;') {

    }else{
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return HomePage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
            (route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.white),),
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
                child: Text('Email', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  controller: email,
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
                child: Text('Name', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  controller: name,
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Name Cannot be Emoty!';
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Name',
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
                child: Text('Password', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
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
                      return 'Password Cannot be Emoty!';
                    }
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: password,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Password',
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
                child: Text('Re-type Password', style: TextStyle(color: Color(0xFF9B049B), fontWeight: FontWeight.bold),),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.2,
                height: 50,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Retype Password Cannot be Emoty!';
                    }
                  },
                  onChanged: (value) {
                    //data.setEmail(value);
                  },
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: rePassword,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Re-type Password',
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
                        onPressed: ()async{
                          WebServices network = Provider.of<WebServices>(context, listen: false);
                          if(form_key.currentState!.validate()) {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if(password.text == rePassword.text) {
                              FirebaseApi.call(context);
                              network.Register(
                                email: email.text,
                                password: password.text,
                                confirm: password.text,
                                name: name.text,
                                context: context,
                              );

                            }else{
                              await showTextToast(
                                text: 'Password Do not Match',
                                context: context,
                              );
                            }
                          }},
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
                              "Sign Up",
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
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation){
                              return SignIn();
                            }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },));

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
                              "Sign In",
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

