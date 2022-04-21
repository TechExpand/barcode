import 'package:barcode/Services/Firebase/General.dart';
import 'package:barcode/Services/Newtork/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final form_key = GlobalKey<FormState>();
  final  scaffoldkey = new GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: form_key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Email',
                  style: TextStyle(
                      color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                ),
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
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Color(0xFF9B049B), fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
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
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 0.0),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: Text(
                      'Remember me',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 34, right: 10),
                    child: Container(
                      child: FlatButton(
                        onPressed: () {
                          WebServices network = Provider.of<WebServices>(context, listen: false);
                          if(form_key.currentState!.validate()){
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            FirebaseApi.call(context);
                            network.Login(email:email.text, password:password.text, context:context);
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
                              "Sign In",
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
                              "Back",
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
    );
  }
}
