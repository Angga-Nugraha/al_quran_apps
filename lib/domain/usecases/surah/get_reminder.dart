import 'package:al_quran_apps/data/common/failure.dart';
import 'package:al_quran_apps/domain/repositories/surah_repositories.dart';
import 'package:dartz/dartz.dart';

class GetReminderAlarm {
  final SurahRepository surahRepository;

  GetReminderAlarm(this.surahRepository);

  Future<Either<Failure, bool>> execute() async {
    return surahRepository.getReminder();
  }
}
