import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/providers/agreements_provider.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/congratulations_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../generated/locale_keys.g.dart';
import '../style.dart';

class PolicyAgreementScreen extends StatelessWidget {
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
            Provider.of<AuthProvider>(context, listen: false).clearErrors();
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: Style.primaryColor,
                size: 50.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  LocaleKeys.errors_general,
                  style: TextStyle(color: Theme.of(context).errorColor),
                ).tr(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.create_account_policy_agreement_prompt,
                    style: TextStyle(
                        color: Style.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ).tr(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                          Provider.of<AgreementProvider>(context, listen: false)
                              .latestAgreement),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AgreementButton(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }
        },
        future: Provider.of<AgreementProvider>(context, listen: false)
            .getLatestAgreement(),
      ),
    );
  }
}

class AgreementButton extends StatefulWidget {
  const AgreementButton({
    Key key,
  }) : super(key: key);

  @override
  _AgreementButtonState createState() => _AgreementButtonState();
}

class _AgreementButtonState extends State<AgreementButton> {
  bool _isLoading;
  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        disabledColor: Color(0xffECECEC),
        elevation: 0,
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          Provider.of<AuthProvider>(context, listen: false).setAgreementId(
              Provider.of<AgreementProvider>(context, listen: false)
                  .agreementId);
          try {
            await Provider.of<AuthProvider>(context, listen: false)
                .sendRegistrationRequest(context: context, validate: false);
            setState(() {
              _isLoading = false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CongratulationsScreen(),
                ),
                (route) => route.isFirst);
          } catch (error) {
            setState(() {
              _isLoading = false;
            });
            print(error);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys.errors_general,
                ).tr(),
                duration: Duration(seconds: 3),
              ),
            );
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
                LocaleKeys.create_account_accept,
                style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ).tr(),
      ),
    );
  }
}
