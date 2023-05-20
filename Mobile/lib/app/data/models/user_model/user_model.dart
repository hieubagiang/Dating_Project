import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/helper/geolocator_helpers.dart';
import 'package:dating_app/app/common/utils/date_time.dart';
import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:dating_app/app/data/models/basic_user/basic_user.dart';
import 'package:dating_app/app/data/models/chat/member_model.dart';
import 'package:dating_app/app/data/models/interaction/matched_user_model.dart';
import 'package:dating_app/app/data/models/user_model/photo_model/photo_model.dart';
import 'package:dating_app/app/data/models/user_model/position_model/position_model.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enums/gender_enum.dart';
import 'filter_user_model/filter_user_model.dart';
import 'hobby_model/hobby_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'gender')
  final GenderType? gender;
  @JsonKey(name: 'birthday', fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? birthday;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'job')
  final String? job;
  @JsonKey(name: 'photo_list')
  final List<PhotoModel>? photoList;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'hobbies')
  final List<HobbyModel>? hobbies;
  @JsonKey(name: 'premium_expire_at', fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? premiumExpireAt;
  @JsonKey(name: 'location')
  final PositionModel? location;
  @JsonKey(name: 'feed_filter')
  final FeedFilterModel? feedFilter;
  @JsonKey(name: 'online_flag')
  final bool? onlineFlag;
  @JsonKey(name: 'lastOnline', fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? lastOnline;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;
  @JsonKey(name: "is_fake_data")
  final bool isFakeData;
  @JsonKey(name: "is_anonymous_user")
  final bool isAnonymousUser;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  UserModel({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    this.username,
    required this.gender,
    required this.birthday,
    this.job,
    required this.avatarUrl,
    required this.photoList,
    this.description,
    required this.hobbies,
    this.premiumExpireAt,
    this.location,
    this.feedFilter,
    this.onlineFlag,
    this.lastOnline,
    this.updateAt,
    this.createAt,
    this.isFakeData = false,
    this.isAnonymousUser = false,
  }) : super();

  factory UserModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      UserModel.fromJson(snapshot.data() ?? {});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this)..removeNulls();

  factory UserModel.init() {
    return UserModel(
      premiumExpireAt: DateTime.now(),
      hobbies: [],
      photoList: [],
      avatarUrl: '',
      name: '',
      id: '',
      birthday: DateTime.now(),
      gender: GenderType.male,
      onlineFlag: true,
      isAnonymousUser: false,
      feedFilter: FeedFilterModel.init(),
      isFakeData: false,
    );
  }

  factory UserModel.createGuestUser(String userId) {
    return UserModel(
      premiumExpireAt: DateTime.now(),
      hobbies: [],
      photoList: [],
      avatarUrl: '',
      name: '',
      id: userId,
      birthday: null,
      gender: null,
      onlineFlag: true,
      isFakeData: false,
      isAnonymousUser: true,
      feedFilter: FeedFilterModel.init(),
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? username,
    GenderType? gender,
    String? job,
    DateTime? birthday,
    String? avatarUrl,
    List<PhotoModel>? photoList,
    String? description,
    List<HobbyModel>? hobbies,
    DateTime? premiumExpireAt,
    FeedFilterModel? feedFilter,
    PositionModel? location,
    bool? onlineFlag,
    DateTime? lastOnline,
    DateTime? createAt,
    DateTime? updateAt,
    bool? isFakeData,
    bool? isAnonymousUser,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      photoList: photoList ?? this.photoList,
      description: description ?? this.description,
      hobbies: hobbies ?? this.hobbies,
      premiumExpireAt: premiumExpireAt ?? this.premiumExpireAt,
      location: location ?? this.location,
      job: job ?? this.job,
      feedFilter: feedFilter ?? this.feedFilter,
      onlineFlag: onlineFlag ?? this.onlineFlag,
      lastOnline: lastOnline ?? this.lastOnline,
      createAt: createAt ?? this.createAt,
      isFakeData: isFakeData ?? this.isFakeData,
      isAnonymousUser: isAnonymousUser ?? this.isAnonymousUser,
    );
  }

  MatchedUserModel toMatchedUserModel() {
    return MatchedUserModel(
        id: id!,
        name: name ?? '',
        birthday: birthday!,
        avatarUrl: avatarUrl,
        location: location,
        username: username ?? '',
        createAt: createAt);
  }

  int get age => DateTimeUtils.calculateAge(birthday!);

  Future<String> getAddress() async {
    return await LocationHelper.locationToAddress(
        lat: location!.latitude, long: location!.longitude);
  }

  MemberModel toMember() =>
      MemberModel(id: id, name: name, avatarUrl: avatarUrl);

  bool get isPremiumUser => MainController.isDemoMode
      ? true
      : (premiumExpireAt?.compareTo(DateTime.now()) ?? -1) > -1;

  UserModel addPremium(int days) {
    return copyWith(
        premiumExpireAt: isPremiumUser
            ? premiumExpireAt?.add(Duration(days: days))
            : DateTime.now().add(Duration(days: days)));
  }

  double getDistanceFromLatLng(PositionModel otherPosition) {
    final distance = Geolocator.distanceBetween(
        location?.latitude ?? 0,
        location?.longitude ?? 0,
        otherPosition.latitude,
        otherPosition.longitude);

    return distance;
  }

  bool isMatchFilter(UserModel other) {
    final filter = feedFilter ?? FeedFilterModel();
    bool isMatch = true;
    //Check age
    if (DateTimeUtils.checkAgeInRange(
        other.birthday!.age, filter.ageRange!.toRangeValue())) {
      isMatch = false;
    }
    //Check gender
    if (filter.interestedInGender != 3 &&
        filter.interestedInGender != null &&
        filter.interestedInGender != other.gender) {
      isMatch = false;
    }
    if (other.location != null &&
        getDistanceFromLatLng(other.location!) > filter.distance!.toDouble()) {
      isMatch = false;
    }
    return isMatch;
  }

  @override
  String toString() {
    return 'UserModel{ ${toMatchedUserModel().toString()}';
  }

  BasicUserModel get getBasicInfo =>
      BasicUserModel(id: id ?? '', name: name ?? '', avatar: avatarUrl);
}
