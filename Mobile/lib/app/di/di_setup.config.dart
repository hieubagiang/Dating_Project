// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:event_bus/event_bus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../common/utils/download_manage.dart' as _i4;
import '../common/utils/log_utils.dart' as _i6;
import '../data/provider/notification_api.dart' as _i7;
import 'app_module.dart' as _i8;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.Dio>(appModule.dio());
  gh.factory<_i4.DownloadManager>(() => _i4.DownloadManager());
  gh.singleton<_i5.EventBus>(appModule.eventBus);
  gh.singleton<_i6.LogUtils>(appModule.logger);
  gh.factory<_i7.NotificationApi>(() => _i7.NotificationApi(
        gh<_i3.Dio>(),
        baseUrl: gh<String>(),
      ));
  return getIt;
}

class _$AppModule extends _i8.AppModule {}
