import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/references_provider.dart';
import 'package:provider/provider.dart';
import '../generated/locale_keys.g.dart';
import './register_phone_number_screen.dart';
import '../style.dart';

class ChooseRoleScreen extends StatelessWidget {
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
            if (Provider.of<AuthProvider>(context, listen: false).role !=
                null) {
              Provider.of<AuthProvider>(context, listen: false).setRole(null);
            }
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
                size: 50,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                LocaleKeys.errors_general,
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).errorColor),
              ).tr(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.create_account_start,
                    style: TextStyle(
                        color: Style.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ).tr(),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/illustrations/choose-role.svg',
                          width: 189,
                          height: 189,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .setRole('transporter');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPhoneNumberScreen(),
                            ),
                          );
                        },
                        color: Color(0xff242A38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          LocaleKeys.create_account_driver_role_button,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ).tr()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: OutlineButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .setRole('sender');
                          Provider.of<AuthProvider>(context, listen: false)
                              .clearErrors();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPhoneNumberScreen(),
                            ),
                          );
                        },
                        borderSide: BorderSide(
                          color: Color(0xff242A38),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          LocaleKeys.create_account_sender_role_button,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff242A38),
                          ),
                        ).tr()),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          }
        },
        future: Provider.of<ReferencesProvider>(context, listen: false)
            .getReferences(context),
      ),
    );
  }
}
