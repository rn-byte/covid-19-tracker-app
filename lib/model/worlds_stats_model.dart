// To parse this JSON data, do
//
//     final worldDisease = worldDiseaseFromJson(jsonString);

import 'dart:convert';

Map<String, double> worldstatsFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, double>(k, v?.toDouble()));

String worldstatsToJson(Map<String, double> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
