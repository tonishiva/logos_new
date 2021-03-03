import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/user_provider.dart';
import 'package:logos_new/screens/user_auth_password_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String _email;
  String _password;
  bool _hidePassword;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _hidePassword = true;
    _passwordController = TextEditingController();
    _password = _passwordController.text;
    _emailController = TextEditingController();
    _email = _emailController.text;
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = Provider.of<AuthProvider>(context).isLoading;
    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        appBar: AppBar(
          backgroundColor: Color(0xffFAFAFA),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xff242A38),
          ),
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Icon(
              CupertinoIcons.back,
              size: 28,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            LocaleKeys.welcome_sign_in,
            style: TextStyle(
              color: Style.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
        ),
        body: Builder(
          builder: (context) => Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 5,
                    color: Color.fromRGBO(229, 229, 229, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.create_account_email,
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ).tr(),
                        SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return LocaleKeys
                                  .create_account_invalid_email_message
                                  .tr();
                            } else {
                              return null;
                            }
                          },
                          controller: _emailController,
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Style.primaryColor,
                          decoration: InputDecoration(
                            errorText:
                                Provider.of<AuthProvider>(context).error != ''
                                    ? Provider.of<AuthProvider>(context).error
                                    : null,
                            counterText: '',
                            fillColor: Color(0xffF9F9F9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          LocaleKeys.create_account_enter_password,
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ).tr(),
                        SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          validator: (value) {
                            Pattern pattern =
                                r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,}$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return LocaleKeys
                                  .create_account_invalid_password_message
                                  .tr();
                            } else {
                              return null;
                            }
                          },
                          obscureText: _hidePassword,
                          controller: _passwordController,
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                          cursorColor: Style.primaryColor,
                          decoration: InputDecoration(
                            errorText:
                                Provider.of<AuthProvider>(context).error != ''
                                    ? Provider.of<AuthProvider>(context).error
                                    : null,
                            suffixIcon: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              child: Icon(
                                _hidePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 30,
                                color: Style.primaryColor,
                              ),
                            ),
                            counterText: '',
                            fillColor: Color(0xffF9F9F9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            disabledColor: Color(0xffECECEC),
                            elevation: 0,
                            onPressed: _email.trim() == '' ||
                                    _password.length < 6
                                ? null
                                : () async {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setLoading(true);
                                    try {
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .login(
                                              context: context,
                                              email: _email,
                                              password: _password);
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .setLoading(false);
                                      Navigator.pop(context);
                                    } catch (error) {
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .setLoading(false);
                                      if (Provider.of<AuthProvider>(context,
                                                  listen: false)
                                              .error ==
                                          '') {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              LocaleKeys.errors_general,
                                            ).tr(),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    }
                                  },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Style.secondaryColor,
                            child: _isLoading
                                ? SpinKitThreeBounce(
                                    color: Style.primaryColor,
                                    size: 25.0,
                                  )
                                : Text(
                                    LocaleKeys.primary_continue,
                                    style: TextStyle(
                                        color: Style.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ).tr(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
