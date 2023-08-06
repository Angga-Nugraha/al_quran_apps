import 'dart:io';

import 'package:al_quran_apps/common/network_info.dart';
import 'package:al_quran_apps/data/datasource/local_data_source.dart';
import 'package:al_quran_apps/data/models/database_model/surah_tabel.dart';
import 'package:al_quran_apps/domain/entities/juz.dart';
import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entities/detail_surah/detail_surah.dart';
import '../../domain/entities/surah/surah.dart';
import '../../domain/repositories/surah_repositories.dart';
import '../datasource/surah_data_source.dart';

class SurahRepositoryImpl implements SurahRepository {
  final SurahDataSource surahRemoteDataSource;
  final SurahLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SurahRepositoryImpl({
    required this.surahRemoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Surah>>> getAllSurah() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await surahRemoteDataSource.getAllSurah();
        localDataSource.cacheGetAllSurah(
            result.map((surah) => SurahTable.fromDTO(surah)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCacheAllSurah();
        return Right(result.map((e) => e.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, DetailSurah>> getSpecificSurah(int number) async {
    try {
      final result = await surahRemoteDataSource.getDetailSurah(number);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(
          ConnectionFailure('Failed, try connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Surah>>> searchSurah(String query) async {
    try {
      final result = await localDataSource.getCacheAllSurah();
      final searchResult = result
          .map((element) => element.toEntity())
          .where((element) => element.name!.transliteration!.id!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      return Right(searchResult);
    } on ServerException {
      return const Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Juz>> getSurahJuz(int number) async {
    try {
      final result = await surahRemoteDataSource.getJuzSurah(number);

      return Right(result.toEntity());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
