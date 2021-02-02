import 'package:bill_pro_v2/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
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
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '',
      _companyName = '',
      _userPassword = '',
      _gst = '',
      _pan = '',
      _bankAddress = '',
      _bank = '',
      _accountNumber = '',
      _address = '';
  var _isLogin = true;
  var _isLoading = false;
  void _trySubmit() {
    _isLoading = true;
    widget.submitFn(_companyName, _gst, _pan, _address, _userEmail,
        _bankAddress, _bank, _accountNumber, _userPassword, _isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                'billPRO',
                style: GoogleFonts.getFont('Montserrat',
                    fontWeight: FontWeight.w700, fontSize: 30),
              ),
              SizedBox(height: 10),
              if (!_isLogin)
                CustomContainer(
                  child: TextFormField(
                    key: ValueKey('Company'),
                    style: GoogleFonts.getFont('Montserrat'),
                    onChanged: (value) {
                      _companyName = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Company Name',
                      hintStyle: GoogleFonts.getFont('Montserrat'),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
              if (!_isLogin) SizedBox(height: 10),
              CustomContainer(
                child: TextField(
                  key: ValueKey('Email'),
                  style: GoogleFonts.getFont('Montserrat'),
                  onChanged: (value) {
                    _userEmail = value;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white12,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Email Address',
                    hintStyle: GoogleFonts.getFont('Montserrat'),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 10),
              CustomContainer(
                child: TextField(
                  key: ValueKey('Password'),
                  style: GoogleFonts.getFont('Montserrat'),
                  onChanged: (value) {
                    _userPassword = value;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white12,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.getFont('Montserrat'),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: FlatButton(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    _isLogin ? 'Login' : 'Register',
                    style: GoogleFonts.getFont('Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  onPressed: _trySubmit,
                ),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  _isLogin ? 'Create New Account' : 'I already have an account',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
