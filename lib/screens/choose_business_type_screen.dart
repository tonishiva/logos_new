import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/choose_vehicle_screen.dart';
import 'package:logos_new/screens/policy_agreement_screen.dart';
import 'package:provider/provider.dart';
import '../generated/locale_keys.g.dart';
import '../style.dart';

class ChooseBusinessTypeScreen extends StatelessWidget {
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
            if (Provider.of<AuthProvider>(context, listen: false)
                    .businessType !=
                null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setBusinessType(null);
            }
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step5,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              LocaleKeys.create_account_choose_business_type_title,
              style: TextStyle(
                  color: Style.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ).tr(),
            SizedBox(
              height: 60,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .setBusinessType('private-entrepreneur');
                    if (Provider.of<AuthProvider>(context, listen: false)
                            .role ==
                        'sender') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PolicyAgreementScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseVehicleScreen(),
                        ),
                      );
                    }
                  },
                  color: Color(0xff242A38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    LocaleKeys.create_account_private,
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
                        .setBusinessType('company');
                    if (Provider.of<AuthProvider>(context, listen: false)
                            .role ==
                        'sender') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PolicyAgreementScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseVehicleScreen(),
                        ),
                      );
                    }
                  },
                  borderSide: BorderSide(
                    color: Color(0xff242A38),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    LocaleKeys.create_account_company,
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
      ),
    );
  }
}
