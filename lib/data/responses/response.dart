import 'package:json_annotation/json_annotation.dart';
import 'package:la_vie/domain/models/models.dart';
part 'response.g.dart';

//-----------------------------------------------------------------------------
//part 'response.g.dart'fsafadfa;
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "message")
  String? message;
}

//------------------------------------------------------------------
@JsonSerializable()
class DataResponse {
  @JsonKey(name: "user")
  UserResponse? user;
  @JsonKey(name: "accessToken")
  String? accessToken;
  @JsonKey(name: "refreshToken")
  String? refreshToken;

  DataResponse(this.user, this.accessToken, this.refreshToken);
  // from Json
  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  Data? toDomain() {
    return null;
  }
}

/**
 * {
  "type": "Success",
  "message": "Logged in Successfully",
 */
//-----------------------------------------------------------------------------
@JsonSerializable()
class UserResponse {
  @JsonKey(name: "userId")
  String? userId;
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "imageUrl")
  String? imageUrl;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "role")
  String? role;

  UserResponse(this.userId, this.firstName, this.lastName, this.email,
      this.imageUrl, this.address, this.role);

// Constructor that recieves map<string , dynmaic >
// and it returns object from this class in the same time
// assigning values from this map keys to the arguments of the object
  // from Json
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
// The next finction will convet an object from that class to map (json)
  // to json
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

//-----------------------------------------------------------------------------
@JsonSerializable()
class AuthonticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  DataResponse data;

  AuthonticationResponse(this.data);

  // from Json
  factory AuthonticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthonticationResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AuthonticationResponseToJson(this);
}
//-----------------------------------------------------------------------------
