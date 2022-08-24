import 'package:la_vie/data/responses/response.dart';
import 'package:la_vie/domain/models/models.dart';

import 'package:la_vie/app/constants.dart';
import 'package:la_vie/app/extentions.dart';

//$$$$$$$$ Mapper File $$$$$$$$
// Conversion from Nullable Customer Response object recieved from api
// to nonNullable Customer object to be sent to Models in the Domin layer
extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
      this?.userId.orEmpty() ?? Constants.empty,
      this?.firstName.orEmpty() ?? Constants.empty,
      this?.lastName.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.imageUrl.orEmpty() ?? Constants.empty,
      this?.address.orEmpty() ?? Constants.empty,
      this?.role.orEmpty() ?? Constants.empty,
    );
  }
}

// extension DataResponseMapper on DataResponse? {
//   Data toDomain() {
//     return Data(
//       this?.userId.orEmpty() ?? Constants.empty,
//       this?.firstName.orEmpty() ?? Constants.empty,
//       this?.lastName.orEmpty() ?? Constants.empty,
//       this?.email.orEmpty() ?? Constants.empty,
//       this?.imageUrl.orEmpty() ?? Constants.empty,
//       this?.address.orEmpty() ?? Constants.empty,
//       this?.role.orEmpty() ?? Constants.empty,
//     );
//   }
// }

extension AuthonticationResponseMapper on AuthonticationResponse? {
  Authontication toDomain() {
    return Authontication(this?.data.toDomain());
    // return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}
