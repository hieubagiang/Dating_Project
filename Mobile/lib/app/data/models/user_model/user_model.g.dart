// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      gender: $enumDecodeNullable(_$GenderTypeEnumMap, json['gender']),
      birthday: DateTimeUtils.dateTimeFromJson(json['birthday']),
      job: json['job'] as String?,
      avatarUrl: json['avatar_url'] as String,
      photoList: (json['photo_list'] as List<dynamic>?)
          ?.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      hobbies: (json['hobbies'] as List<dynamic>?)
          ?.map((e) => HobbyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      premiumExpireAt:
          DateTimeUtils.dateTimeFromJson(json['premium_expire_at']),
      location: json['location'] == null
          ? null
          : PositionModel.fromJson(json['location'] as Map<String, dynamic>),
      feedFilter: json['feed_filter'] == null
          ? null
          : FeedFilterModel.fromJson(
              json['feed_filter'] as Map<String, dynamic>),
      onlineFlag: json['online_flag'] as bool?,
      lastOnline: DateTimeUtils.dateTimeFromJson(json['lastOnline']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      isFakeData: json['is_fake_data'] as bool? ?? false,
      isAnonymousUser: json['is_anonymous_user'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'username': instance.username,
      'gender': _$GenderTypeEnumMap[instance.gender],
      'birthday': instance.birthday?.toIso8601String(),
      'avatar_url': instance.avatarUrl,
      'job': instance.job,
      'photo_list': instance.photoList?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'hobbies': instance.hobbies?.map((e) => e.toJson()).toList(),
      'premium_expire_at': instance.premiumExpireAt?.toIso8601String(),
      'location': instance.location?.toJson(),
      'feed_filter': instance.feedFilter?.toJson(),
      'online_flag': instance.onlineFlag,
      'lastOnline': instance.lastOnline?.toIso8601String(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': UserModel.coordinatesToJson(instance.updateAt),
      'is_fake_data': instance.isFakeData,
      'is_anonymous_user': instance.isAnonymousUser,
    };

const _$GenderTypeEnumMap = {
  GenderType.male: 'male',
  GenderType.female: 'female',
};
