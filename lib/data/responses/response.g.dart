// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..type = json['type'] as String?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
    };

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      json['accessToken'] as String?,
      json['refreshToken'] as String?,
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['userId'] as String?,
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['imageUrl'] as String?,
      json['address'] as String?,
      json['role'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
      'address': instance.address,
      'role': instance.role,
    };

AuthonticationResponse _$AuthonticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthonticationResponse(
      DataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..type = json['type'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthonticationResponseToJson(
        AuthonticationResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'data': instance.data,
    };
