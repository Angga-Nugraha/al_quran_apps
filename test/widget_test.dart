import 'dart:convert';

import 'package:al_quran_apps/common/exception.dart';
import 'package:al_quran_apps/data/datasource/surah_data_source.dart';
import 'package:al_quran_apps/data/models/detail_surah_model/detail_surah_model.dart';
import 'package:al_quran_apps/data/models/surah_responses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'read_json.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([
  SurahDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {
  const baseUrl = "https://api.quran.gading.dev/";

  late SurahDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SurahDataSourceImpl(client: mockHttpClient);
  });

  group('Surah List', () {
    final tSurahList =
        SurahResponse.fromJson(json.decode(readJson('/list_surah.json')))
            .surahList;

    test('Return List Surah when statuscode 200', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/surah'))).thenAnswer(
          (_) async => http.Response(readJson('list_surah.json'), 200));
      final result = await dataSource.getAllSurah();

      expect(result, equals(tSurahList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/surah')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getAllSurah();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Detail Surah', () {
    const tNumber = 4;
    final tDetailSurah =
        DetailSurahModel.fromJson(json.decode(readJson('/detail_surah.json')));

    test('Return Detail Surah when statuscode 200', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/surah/$tNumber'))).thenAnswer(
          (_) async => http.Response(readJson('detail_surah.json'), 200));
      final result = await dataSource.getDetailSurah(tNumber);

      expect(result, equals(tDetailSurah));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/surah/$tNumber')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getDetailSurah(tNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
