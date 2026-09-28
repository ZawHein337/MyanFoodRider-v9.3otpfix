import 'package:flutter/foundation.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class CustomValidator {

  static Future<PhoneValid> isPhoneValid(String number) async {
    String phone = '';
    String countryCode = '';
    bool isValid = true;
    try {
      PhoneNumber phoneNumber = PhoneNumber.parse(number);
      isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      countryCode = phoneNumber.countryCode;
      if(isValid) {
        phone = '+${phoneNumber.countryCode}${phoneNumber.nsn}';
      }
    } catch (e) {
      debugPrint('Phone Number is not parsing: $e');
    }
    return PhoneValid(isValid: isValid, countryCode: countryCode,  phone: phone);
  }

  /// Numbers that travelled through a route query parameter can lose their
  /// leading `+` to a space, so strip whitespace before restoring the prefix.
  static String normalizePhoneNumber(String number) {
    String phone = number.replaceAll(RegExp(r'\s'), '');
    return phone.startsWith('+') ? phone : '+$phone';
  }

}

class PhoneValid {
  bool isValid;
  String countryCode;
  String phone;
  PhoneValid({required this.isValid, required this.countryCode, required this.phone});
}