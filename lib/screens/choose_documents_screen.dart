import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/policy_agreement_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class ChooseDocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _licenseFront = Provider.of<AuthProvider>(context).licenseFront;
    final _licenseBack = Provider.of<AuthProvider>(context).licenseBack;
    final _passportFront = Provider.of<AuthProvider>(context).passportFront;
    final _passportBack = Provider.of<AuthProvider>(context).passportBack;

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
            if (_passportBack != null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setPassportBack(null);
            }
            if (_passportFront != null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setPassportFront(null);
            }
            if (_licenseBack != null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setLiceseBack(null);
            }
            if (_licenseFront != null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setLiceseFront(null);
            }
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step7,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.create_account_docs_upload_title,
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
                  LocaleKeys.create_account_license_upload_prompt,
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ).tr(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setLiceseFront(
                                  File(pickedFile.path),
                                );
                              }
                            },
                            child: Container(
                              width: 124,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Style.primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: _licenseFront == null
                                  ? Center(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Style.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      _licenseFront,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            LocaleKeys.create_account_front_side,
                            style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ).tr(),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setLiceseBack(
                                  File(pickedFile.path),
                                );
                              }
                            },
                            child: Container(
                              width: 124,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Style.primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: _licenseBack == null
                                  ? Center(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Style.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      _licenseBack,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            LocaleKeys.create_account_back_side,
                            style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ).tr(),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  LocaleKeys.create_account_passport_upload_prompt,
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ).tr(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setPassportFront(
                                  File(pickedFile.path),
                                );
                              }
                            },
                            child: Container(
                              width: 124,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Style.primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: _passportFront == null
                                  ? Center(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Style.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      _passportFront,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            LocaleKeys.create_account_front_side,
                            style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ).tr(),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              final picker = ImagePicker();
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setPassportBack(
                                  File(pickedFile.path),
                                );
                              }
                            },
                            child: Container(
                              width: 124,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Style.primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: _passportBack == null
                                  ? Center(
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Style.primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      _passportBack,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            LocaleKeys.create_account_back_side,
                            style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ).tr(),
                        ],
                      ),
                    ],
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PolicyAgreementScreen(),
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
    );
  }
}
