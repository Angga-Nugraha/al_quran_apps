import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../repositories/surah_repositories.dart';

class GetLastRead {
  final SurahRepository surahRepository;

  GetLastRead(this.surahRepository);

  Future<Either<Failure, Map<String, dynamic>>> execute() {
    return surahRepository.getLastRead();
  }
}
