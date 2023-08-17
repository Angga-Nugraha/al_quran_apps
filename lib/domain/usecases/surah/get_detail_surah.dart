import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/detail_surah/detail_surah.dart';
import '../../repositories/surah_repositories.dart';

class GetDetailSurah {
  final SurahRepository surahRepository;

  GetDetailSurah(this.surahRepository);

  Future<Either<Failure, DetailSurah>> execute(int number) {
    return surahRepository.getSpecificSurah(number);
  }
}
