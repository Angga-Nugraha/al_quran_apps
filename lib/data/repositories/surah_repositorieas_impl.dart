import 'dart:io';

import 'package:al_quran_apps/common/network_info.dart';
import 'package:al_quran_apps/data/datasource/local_data_source.dart';
import 'package:al_quran_apps/data/helpers/background_service.dart';
import 'package:al_quran_apps/data/helpers/date_time_helper.dart';
import 'package:al_quran_apps/data/helpers/preference_helper.dart';
import 'package:al_quran_apps/data/models/database_model/last_read_table.dart';
import 'package:al_quran_apps/data/models/database_model/surah_tabel.dart';
import 'package:al_quran_apps/domain/entities/juz.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

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
  final PreferencesHelper preferencesHelper;

  SurahRepositoryImpl({
    required this.surahRemoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.preferencesHelper,
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

  @override
  Future<Either<Failure, String>> insertLastRead(
      Map<String, dynamic> surah) async {
    try {
      await localDataSource.insertLastRead(LastReadTable.fromMap(surah));
      return const Right("Success");
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getLastRead() async {
    try {
      final result = await localDataSource.getLastRead();
      return Right(result.toJson());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setReminderAlarm(bool value) async {
    try {
      if (value) {
        debugPrint('Reminder active');
        preferencesHelper.setDailyReminder(value);
        return await AndroidAlarmManager.periodic(
          const Duration(hours: 12),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        ).then((value) => const Right(true));
      } else {
        debugPrint('Reminder Canceled');
        preferencesHelper.setDailyReminder(false);
        return await AndroidAlarmManager.cancel(1)
            .then((value) => const Right(false));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getReminder() async {
    try {
      final result = await preferencesHelper.isReminder;
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getDarkTheme() async {
    try {
      final result = await preferencesHelper.isDarkTheme;
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setDarkTheme(bool value) async {
    try {
      preferencesHelper.setDarkTheme(value);
      return Right(value);
    } catch (e) {
      throw Left(CacheFailure(e.toString()));
    }
  }
}
