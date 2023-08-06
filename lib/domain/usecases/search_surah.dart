import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/surah/surah.dart';
import '../repositories/surah_repositories.dart';

class SearchSurah {
  final SurahRepository surahRepository;

  SearchSurah(this.surahRepository);

  Future<Either<Failure, List<Surah>>> execute(String query) {
    return surahRepository.searchSurah(query);
  }
}
