import 'package:al_quran_apps/common/failure.dart';
import 'package:al_quran_apps/domain/repositories/surah_repositories.dart';
import 'package:dartz/dartz.dart';

class GetDarkTheme {
  SurahRepository surahRepository;

  GetDarkTheme(this.surahRepository);

  Future<Either<Failure, bool>> execute() async {
    return surahRepository.getDarkTheme();
  }
}
