import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/choose_business_type_screen.dart';
import 'package:logos_new/screens/policy_agreement_screen.dart';
import 'package:logos_new/screens/verify_phone_number_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class UserAuthPasswordScreen extends StatefulWidget {
  @override
  _UserAuthPasswordScreenState createState() => _UserAuthPasswordScreenState();
}

class _UserAuthPasswordScreenState extends State<UserAuthPasswordScreen> {
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;
  String _password;
  String _confirmPassword;
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _passwordMatch = false;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _password = _passwordController.text;
    _confirmPasswordController = TextEditingController();
    _confirmPassword = _confirmPasswordController.text;
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    Pattern pattern = r'^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%&*]{6,}$';
    final regexp = RegExp(pattern);
    if (regexp.hasMatch(_password)) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
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
            if (Provider.of<AuthProvider>(context, listen: false).password !=
                null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setPassword(null);
            }
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step4,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: Container(
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
                      LocaleKeys.create_account_choose_password_title,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
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
                      controller: _passwordController,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      obscureText: _hidePassword,
                      cursorColor: Style.primaryColor,
                      decoration: InputDecoration(
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: _isPasswordValid()
                              ? BorderSide(
                                  width: 2,
                                  color: Color(0xff5EE10D),
                                )
                              : BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: _isPasswordValid()
                              ? BorderSide(
                                  width: 2,
                                  color: Color(0xff5EE10D),
                                )
                              : BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: _isPasswordValid()
                              ? BorderSide(
                                  width: 2,
                                  color: Color(0xff5EE10D),
                                )
                              : BorderSide.none,
                        ),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      LocaleKeys.create_account_re_enter_password,
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
                          _confirmPassword = value;
                        });
                      },
                      controller: _confirmPasswordController,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      cursorColor: Style.primaryColor,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {},
                          child: Icon(
                            Icons.visibility_off_outlined,
                            size: 30,
                            color: Color(0xffECECEC),
                          ),
                        ),
                        counterText: '',
                        fillColor: Color(0xffF9F9F9),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: _password == _confirmPassword &&
                                  _password.length > 0
                              ? BorderSide(
                                  width: 2,
                                  color: Color(0xff5EE10D),
                                )
                              : BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: _password == _confirmPassword &&
                                  _password.length > 0
                              ? BorderSide(
                                  width: 2,
                                  color: Color(0xff5EE10D),
                                )
                              : BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: _password == _confirmPassword &&
                                  _password.length > 0
                              ? BorderSide(
                                  width: 2,
                                  color: Color(0xff5EE10D),
                                )
                              : BorderSide.none,
                        ),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      LocaleKeys.create_account_password_hint,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ).tr(),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        disabledColor: Color(0xffECECEC),
                        elevation: 0,
                        onPressed: _password.length < 6 ||
                                _confirmPassword.length < 6 ||
                                _password != _confirmPassword
                            ? null
                            : () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setPassword(_password);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChooseBusinessTypeScreen(),
                                  ),
                                );
                              },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Style.secondaryColor,
                        child: Text(
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
    );
  }
}
