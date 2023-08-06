import 'dart:convert';

import 'package:al_quran_apps/common/exception.dart';
import 'package:al_quran_apps/data/models/detail_surah_model/detail_surah_model.dart';
import 'package:al_quran_apps/data/models/juz_model.dart';
import 'package:al_quran_apps/data/models/surah_model/surah_model.dart';
import 'package:al_quran_apps/data/models/surah_responses.dart';
import 'package:http/http.dart' as http;

abstract class SurahDataSource {
  Future<List<SurahModel>> getAllSurah();
  Future<DetailSurahModel> getDetailSurah(int number);
  Future<JuzModel> getJuzSurah(int juz);
}

class SurahDataSourceImpl implements SurahDataSource {
  static const baseUrl = "https://api.quran.gading.dev";

  final http.Client client;

  SurahDataSourceImpl({required this.client});

  @override
  Future<List<SurahModel>> getAllSurah() async {
    final response = await client.get(Uri.parse('$baseUrl/surah'));
    if (response.statusCode == 200) {
      return SurahResponse.fromJson(json.decode(response.body)).surahList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailSurahModel> getDetailSurah(int number) async {
    final response = await client.get(Uri.parse('$baseUrl/surah/$number'));
    if (response.statusCode == 200) {
      return DetailSurahModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<JuzModel> getJuzSurah(int juz) async {
    final response = await client.get(Uri.parse('$baseUrl/juz/$juz'));
    if (response.statusCode == 200) {
      return JuzModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}
