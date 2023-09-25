import 'package:al_quran_apps/data/common/failure.dart';
import 'package:al_quran_apps/domain/entities/juz.dart';
import 'package:al_quran_apps/domain/repositories/surah_repositories.dart';
import 'package:dartz/dartz.dart';

class GetSurahJuz {
  final SurahRepository surahRepository;

  GetSurahJuz(this.surahRepository);

  Future<Either<Failure, Juz>> execute(int number) {
    return surahRepository.getSurahJuz(number);
  }
}
