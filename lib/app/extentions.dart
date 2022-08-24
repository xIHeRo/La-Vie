//Extentions on NonNullable Elements to be used in
// the maping process between the api and UI
//---------------------------------------------------
import 'package:la_vie/app/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

//---------------------------------------------------
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}
//---------------------------------------------------
