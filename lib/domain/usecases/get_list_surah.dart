import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/surah/surah.dart';
import '../repositories/surah_repositories.dart';

class GetListSurah {
  final SurahRepository surahRepository;

  GetListSurah(this.surahRepository);

  Future<Either<Failure, List<Surah>>> execute() {
    return surahRepository.getAllSurah();
  }
}
