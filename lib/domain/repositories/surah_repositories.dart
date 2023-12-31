import 'package:al_quran_apps/domain/entities/juz.dart';
import 'package:dartz/dartz.dart';

import '../../data/common/failure.dart';
import '../entities/detail_surah/detail_surah.dart';
import '../entities/surah/surah.dart';

abstract class SurahRepository {
  Future<Either<Failure, List<Surah>>> getAllSurah();
  Future<Either<Failure, List<Surah>>> searchSurah(String query);
  Future<Either<Failure, DetailSurah>> getSpecificSurah(int number);
  Future<Either<Failure, Juz>> getSurahJuz(int number);
  Future<Either<Failure, String>> insertLastRead(Map<String, dynamic> surah);
  Future<Either<Failure, Map<String, dynamic>>> getLastRead();
  Future<Either<Failure, bool>> setReminderAlarm(bool value);
  Future<Either<Failure, bool>> getReminder();
  Future<Either<Failure, bool>> setDarkTheme(bool value);
  Future<Either<Failure, bool>> getDarkTheme();
}
