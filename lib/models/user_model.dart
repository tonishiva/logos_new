import 'dart:io';

import 'package:logos_new/models/vehicle_model.dart';

class User {
  String phoneNumber;
  String role;
  String firstName;
  String lastName;
  String email;
  String password;
  String businessType;
  int agreementId;
  File driverLicenseFront;
  File driverLicenseBack;
  File passportFront;
  File passportBack;

  User([
    this.businessType,
    this.driverLicenseBack,
    this.driverLicenseFront,
    this.email,
    this.firstName,
    this.lastName,
    this.passportBack,
    this.passportFront,
    this.password,
    this.phoneNumber,
    this.role,
    this.agreementId,
  ]);
}
