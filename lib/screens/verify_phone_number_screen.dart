import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/user_auth_credentials_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../style.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  @override
  _VerifyPhoneNumberScreenState createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  TextEditingController _controller;
  Timer _timer;
  int _start = 60;
  String _pinCode;
  String _phoneNumber;

  void _startTimer() {
    _start = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    _phoneNumber =
        Provider.of<AuthProvider>(context, listen: false).phoneNumber;
    _controller = TextEditingController();
    _pinCode = _controller.text;
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    _controller.dispose();
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
            Provider.of<AuthProvider>(context, listen: false)
                .clearPhoneVerificationStep();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step2,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.create_account_phone_verification_title_1.tr()}' +
                          '(${_phoneNumber.substring(0, 3)})${_phoneNumber.substring(3, 6)}-${_phoneNumber.substring(6, 8)}-${_phoneNumber.substring(8)} ' +
                          '${LocaleKeys.create_account_phone_verification_title_2.tr()}',
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: PinCodeTextField(
                        enabled:
                            !Provider.of<AuthProvider>(context).isPhoneVerified,
                        validator: (_) {
                          return Provider.of<AuthProvider>(context)
                                      .errors['code'] !=
                                  null
                              ? Provider.of<AuthProvider>(context)
                                  .errors['code'][0]
                              : null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          borderWidth: 0,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 52,
                          fieldWidth: 50,
                          activeFillColor: Color(0xffF9F9F9),
                          activeColor: Color(0xffF9F9F9),
                          selectedColor: Color(0xffF9F9F9),
                          inactiveColor: Color(0xffF9F9F9),
                          disabledColor: Color(0xffF9F9F9),
                          selectedFillColor: Color(0xffF9F9F9),
                          inactiveFillColor: Color(0xffF9F9F9),
                        ),
                        cursorColor: Style.primaryColor,
                        animationDuration: Duration(milliseconds: 300),
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Style.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _pinCode = value;
                          });
                        },
                        controller: _controller,
                        autoDisposeControllers: false,
                        beforeTextPaste: (text) {
                          return true;
                        },
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
                        onPressed: _pinCode.length != 4
                            ? null
                            : () async {
                                if (Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .isPhoneVerified) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserAuthCredentialsScreen(),
                                    ),
                                  );
                                } else {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .setLoading(true);
                                  try {
                                    await Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .verifyPhoneNumber(
                                            context: context,
                                            pinCode: _pinCode);
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setLoading(false);
                                    if (Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .isPhoneVerified) {
                                      _timer.cancel();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserAuthCredentialsScreen(),
                                        ),
                                      );
                                    }
                                  } catch (error) {
                                    print(error);
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setLoading(false);
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
                      height: 25,
                    ),
                    _start != 0 &&
                            !Provider.of<AuthProvider>(context).isPhoneVerified
                        ? Text(
                            '${LocaleKeys.create_account_retry_verification_request_timer.tr()}$_start',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff808080),
                            ),
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_start == 0 &&
                    !Provider.of<AuthProvider>(context, listen: false)
                        .isPhoneVerified) {
                  setState(() {
                    _pinCode = '';
                  });
                  _controller.clear();
                  Provider.of<AuthProvider>(context, listen: false)
                      .clearErrors();
                  Provider.of<AuthProvider>(context, listen: false)
                      .registerPhoneNumber(context: context);
                  _startTimer();
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 40,
                ),
                child: Text(
                  LocaleKeys.create_account_resend_code,
                  style: TextStyle(
                    color: _start != 0 ||
                            Provider.of<AuthProvider>(context).isPhoneVerified
                        ? Color(0xff808080)
                        : Style.secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
