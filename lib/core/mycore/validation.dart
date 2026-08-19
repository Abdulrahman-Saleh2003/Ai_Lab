// import 'package:get/get.dart';
//
// validate(String value, String type) {
//   if (value.isEmpty) {
//     return 'This field is empty'.tr;
//   }
//   switch (type) {
//     case 'email':
//       return !GetUtils.isEmail(value) ? 'not_valid_email'.tr : null;
//     case 'password':
//       return (value.length < 8) ? 'cant_be_less_than_8_letter'.tr : null;
//     case 'phone':
//       return !GetUtils.isPhoneNumber(value)
//           ? 'not_valid_phone_number'.tr
//           : null;
//     case 'name':
//       return !GetUtils.isUsername(value) ? 'not_valid_Username'.tr : null;
//
//     case 'time':
//       return !GetUtils.isDateTime(value) ? 'GetUtils.isDateTime'.tr : null;
//
//
//     case 'date':
//       //return value == null ? 'GetUtils.isDateTime'.tr : null;
//       return null;
//     case 'age':
//       return !GetUtils.isNum(value) ? 'not_valid_Username'.tr : null;
//     case 'Confirm':
//       return !GetUtils.isNum(value) || value.length != 4
//           ? ' not Confirm The Code'.tr
//           : null;
//     case '':
//       return GetUtils.isTxt("") ? null : "";
//   }
// }
import 'package:get/get.dart';

class ValidationType {
  static const email = 'email';
  static const password = 'password';
  static const phone = 'phone';
  static const name = 'name';
  static const date = 'date';
  static const age = 'age';
  static const confirm = 'confirm';
  static const string = 'string';
  static const nul = 'nul';
}

String? validate(String value, String type) {
  if (value.isEmpty) {
    return 'this_field_is_required'.tr;
  }

  switch (type) {
    case ValidationType.email:
      return GetUtils.isEmail(value) ? null : 'invalid_email_format'.tr;
    case ValidationType.nul:

      return value.isEmpty ?null:null;
    case ValidationType.password:
      return value.length >= 8 ? null : 'password_min_length'.tr;

    case ValidationType.phone:
      return GetUtils.isPhoneNumber(value.removeAllWhitespace)
          ? null
          : 'invalid_phone_number'.tr;

    case ValidationType.name:
      return GetUtils.isUsername(value) ? null : 'invalid_name_format'.tr;
    case ValidationType.string:
      if(value.isNotEmpty &&  !GetUtils.isPhoneNumber(value.removeAllWhitespace)){

      return null; }

      return  'invalid_name_format'.tr;

    case ValidationType.date:
      return _validateDate(value);


    case ValidationType.age:
      return GetUtils.isNumericOnly(value) && int.parse(value) >= 1
          ? null
          : 'invalid_age'.tr;

    case ValidationType.confirm:
      return value.length == 4 && GetUtils.isNumericOnly(value)
          ? null
          : 'invalid_confirmation_code'.tr;

    default:
      throw ArgumentError('Unsupported validation type: $type');
  }
}

String? _validateDate(String value) {
  try {
    final date = DateTime.parse(value);
    final now = DateTime.now();
    return date.isBefore(now) ? null : 'future_date_not_allowed'.tr;
  } catch (e) {
    return 'invalid_date_format'.tr;
  }
}