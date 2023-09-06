import 'package:al_quran_apps/common/failure.dart';
import 'package:al_quran_apps/domain/repositories/surah_repositories.dart';
import 'package:dartz/dartz.dart';

class SetReminderAlarm {
  final SurahRepository surahRepository;

  SetReminderAlarm(this.surahRepository);

  Future<Either<Failure, bool>> execute(bool value) async {
    return surahRepository.setReminderAlarm(value);
  }
}
