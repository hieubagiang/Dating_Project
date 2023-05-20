import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

import '../common/network/dio_builder.dart';
import '../common/utils/log_utils.dart';

@module
abstract class AppModule {
  @singleton
  Dio dio() => DioBuilder().getDio();

  @singleton
  EventBus get eventBus => EventBus();
  @singleton
  LogUtils get logger => LogUtils();
}
