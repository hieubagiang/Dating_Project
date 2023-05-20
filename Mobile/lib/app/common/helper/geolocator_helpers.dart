import 'package:dating_app/app/widgets/new_dialog/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationError {
  static String isLocationServiceEnabled = '';
}

class LocationHelper {
  static bool isShowDialog = false;

  static Future<Position?> getPosition(
      {required BuildContext context,
      Function()? onPermissionDeniedForever}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error(LocationPermissionError.permissionDenied);
        if (!isShowDialog) {
          isShowDialog = true;
          await AlertDialogCustom(
            context: context,
            title: 'Quyền truy cập vị trí',
            description: LocationPermissionError.permissionDenied.description,
            onTap: () async {
              Navigator.pop(context);
              isShowDialog = false;
            },
          ).show();
        }
        throw LocationPermissionException(
            LocationPermissionError.permissionDenied.error);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      onPermissionDeniedForever?.call();
      await AlertDialogCustom(
        context: context,
        title: 'Quyền truy cập vị trí',
        description:
            LocationPermissionError.permissionPermanentlyDenied.description,
        onTap: () async {
          Navigator.pop(context);
          isShowDialog = false;
        },
      ).show();

      throw LocationPermissionException(
          LocationPermissionError.permissionPermanentlyDenied.error);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      try {
        return await Geolocator.getCurrentPosition();
      } on Exception catch (_) {
        if (!isShowDialog) {
          isShowDialog = true;
          await AlertDialogCustom(
            context: context,
            title: 'Quyền truy cập vị trí',
            description: LocationPermissionError.serviceDisabled.description,
            onTap: () async {
              Navigator.pop(context);
              isShowDialog = false;
            },
          ).show();

          throw LocationPermissionException(
              LocationPermissionError.serviceDisabled.error);
        }
      }
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String> locationToAddress(
      {required double lat,
      required double long,
      bool isGetDetail = false}) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
    final model = placeMarks.first;
    String address =
        model.street?.contains('+') == false ? '${model.street}, ' : '';
    if (isGetDetail) {
      address = '';
    }
    address += '${model.subAdministrativeArea}, ${model.administrativeArea}';
    return address;
  }
}

class LocationPermissionErrorEnum {
  static LocationPermissionError? getType(int? id) {
    if (id == null) {
      return null;
    }
    return LocationPermissionError.values
        .where((value) => value.id == id)
        .first;
  }
}

enum LocationPermissionError {
  serviceDisabled,
  permissionDenied,
  permissionPermanentlyDenied
}

extension LocationPermissionErrorExtension on LocationPermissionError {
  int get id {
    switch (this) {
      case LocationPermissionError.serviceDisabled:
        return 1;
      case LocationPermissionError.permissionDenied:
        return 2;
      case LocationPermissionError.permissionPermanentlyDenied:
        return 3;
    }
  }

  String get error {
    switch (this) {
      case LocationPermissionError.serviceDisabled:
        return 'serviceDisabled';
      case LocationPermissionError.permissionDenied:
        return 'permissionDenied';
      case LocationPermissionError.permissionPermanentlyDenied:
        return 'permissionPermanentlyDenied';
    }
  }

  String get description {
    switch (this) {
      case LocationPermissionError.serviceDisabled:
        return 'Để tiếp tục vui lòng đồng ý bật chia sẻ vị trí ';
      case LocationPermissionError.permissionDenied:
        return 'Để tiếp tục vui lòng đồng ý cấp quyền vị trí cho ứng dụng';
      case LocationPermissionError.permissionPermanentlyDenied:
        return 'Để tiếp tục ứng dụng vui lòng cho phép quyền vị trí cho ứng dụng trong cài đặt!';
    }
  }
}

class LocationPermissionException implements Exception {
  final String message;

  const LocationPermissionException(this.message);

  @override
  String toString() => 'LocationPermissionException: $message';
}
