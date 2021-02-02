import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  void _submitAuthForm(
    String company,
    String gst,
    String pan,
    String address,
    String email,
    String bankAddress,
    String bank,
    String accountNumber,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.black87,
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          new Text(
            "  Loading...",
            style: GoogleFonts.getFont('Montserrat', color: Colors.white),
          )
        ],
      ),
    ));
    UserCredential userCredential;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'company': company,
          'email': email,
          'address': '',
          'gst': '',
          'pan': '',
          'bankAddress': '',
          'bank': '',
          'accountNumber': ''
        });
      }
    } on PlatformException catch (err) {
      var message = 'Error occurred, Check Credentials.';
      if (err.message != null) {
        message = err.message;
      }
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(message),
      //     backgroundColor: Theme.of(context).errorColor,
      //   ),

      setState(() {
        isLoading = false;
      });
    } catch (err) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.red,
        duration: new Duration(seconds: 4),
        content: new Text(
          "Invalid Username or Password",
          style: GoogleFonts.getFont('Montserrat'),
        ),
      ));
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: AuthForm(
        _submitAuthForm,
        isLoading,
      ),
    );
  }
}
