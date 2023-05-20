import 'base_data_response.dart';

class DummyResponse extends BaseDataResponse {
  CountriesRoute? countriesRoute;

  DummyResponse({this.countriesRoute});

  DummyResponse.fromJson(Map<String, dynamic> json) {
    countriesRoute = json['countriesRoute'] != null
        ? CountriesRoute.fromJson(json['countriesRoute'])
        : null;
  }
}

class CountriesRoute {
  late String name;
  late String description;
  late String path;

  CountriesRoute({this.name = "", this.description = "", this.path = ""});

  CountriesRoute.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    description = json['Description'];
    path = json['Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Description'] = description;
    data['Path'] = path;
    return data;
  }
}
