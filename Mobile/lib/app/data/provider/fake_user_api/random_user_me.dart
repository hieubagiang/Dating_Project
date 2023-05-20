import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/models/fake_model/fake_user_model.dart';

import '../api_provider.dart';

abstract class RandomUserMeApi {
  factory RandomUserMeApi() = RandomUserMeApiImpl;

  Future<RandomUserModel> getUser({String? gender, int? size});
}

class RandomUserMeApiImpl implements RandomUserMeApi {
  final api = Api(baseUrl: 'https://randomuser.me/api');

  @override
  Future<RandomUserModel> getUser({String? gender, int? size}) async {
    final response = await api.baseRequest(
        url: '/',
        queryParameters: {'gender': gender, 'results': size, 'nat': 'US'}
          ..removeNulls(),
        getRawResponse: true);
    return RandomUserModel.fromJson(response as Map<String, dynamic>);
  }
}
