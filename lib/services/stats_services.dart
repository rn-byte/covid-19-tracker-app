import 'package:covid_19_tracker_app/services/utilities/app_url.dart';

import '../model/countries_stats_model.dart';
import '../model/worlds_stats_model.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<Map<String, double>?> fetchWorldStats() async {
    var client = http.Client();
    var uri = Uri.parse(AppUrl.worldStatesApi);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return worldstatsFromJson(json);
    } else {
      return null;
    }
  }

  Future<List<CountriesStats>?> fetchCountriesStats() async {
    var client = http.Client();
    var uri = Uri.parse(AppUrl.countriesList);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return countriesStatsFromJson(json);
    } else {
      return null;
    }
  }
}
