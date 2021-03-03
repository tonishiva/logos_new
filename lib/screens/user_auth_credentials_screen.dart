import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/user_auth_password_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class UserAuthCredentialsScreen extends StatefulWidget {
  @override
  _UserAuthCredentialsScreenState createState() =>
      _UserAuthCredentialsScreenState();
}

class _UserAuthCredentialsScreenState extends State<UserAuthCredentialsScreen> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _emailController;
  String _firstName;
  String _lastName;
  String _email;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _firstName = _firstNameController.text;
    _lastNameController = TextEditingController();
    _lastName = _lastNameController.text;
    _emailController = TextEditingController();
    _email = _emailController.text;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
            if (Provider.of<AuthProvider>(context, listen: false).firstName !=
                null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setFirstName(null);
            }
            if (Provider.of<AuthProvider>(context, listen: false).lastName !=
                null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setLastName(null);
            }
            if (Provider.of<AuthProvider>(context, listen: false).email !=
                null) {
              Provider.of<AuthProvider>(context, listen: false).setEmail(null);
            }
            Provider.of<AuthProvider>(context, listen: false).clearErrors();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step3,
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
                      LocaleKeys.create_account_user_credentials_title,
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
                      LocaleKeys.create_account_name,
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
                          _firstName = value;
                        });
                      },
                      keyboardType: TextInputType.name,
                      controller: _firstNameController,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      cursorColor: Style.primaryColor,
                      decoration: InputDecoration(
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
                      height: 10,
                    ),
                    Text(
                      LocaleKeys.create_account_last_name,
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
                          _lastName = value;
                        });
                      },
                      keyboardType: TextInputType.name,
                      controller: _lastNameController,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      cursorColor: Style.primaryColor,
                      decoration: InputDecoration(
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
                      height: 10,
                    ),
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
                          return LocaleKeys.create_account_invalid_email_message
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
                        errorText: Provider.of<AuthProvider>(context)
                                    .errors['email'] !=
                                null
                            ? Provider.of<AuthProvider>(context).errors['email']
                                [0]
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
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        disabledColor: Color(0xffECECEC),
                        elevation: 0,
                        onPressed: _firstName.trim().length < 2 ||
                                _lastName.trim().length < 2 ||
                                _email.trim().length < 1
                            ? null
                            : () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setLoading(true);
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setFirstName(_firstName);
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setLastName(_lastName);
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setEmail(_email);
                                try {
                                  await Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .sendRegistrationRequest(
                                    context: context,
                                    validate: true,
                                  );
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .setLoading(false);
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .clearErrors();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserAuthPasswordScreen(),
                                    ),
                                  );
                                } catch (error) {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .setLoading(false);
                                  if (Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .errors['email'] ==
                                      null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserAuthPasswordScreen(),
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
    );
  }
}
