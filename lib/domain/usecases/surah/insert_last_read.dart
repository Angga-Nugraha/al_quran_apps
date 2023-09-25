import 'package:dartz/dartz.dart';

import '../../../data/common/failure.dart';
import '../../repositories/surah_repositories.dart';

class InsertLastRead {
  final SurahRepository surahRepository;

  InsertLastRead(this.surahRepository);

  Future<Either<Failure, String>> execute(Map<String, dynamic> surah) {
    return surahRepository.insertLastRead(surah);
  }
}
