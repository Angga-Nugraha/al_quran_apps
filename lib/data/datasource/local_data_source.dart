import 'package:al_quran_apps/common/exception.dart';
import 'package:al_quran_apps/data/helpers/database_helper.dart';
import 'package:al_quran_apps/data/models/database_model/surah_tabel.dart';

abstract class SurahLocalDataSource {
  Future<void> cacheGetAllSurah(List<SurahTable> surah);
  Future<List<SurahTable>> getCacheAllSurah();
}

class SurahLocalDataSourceImpl implements SurahLocalDataSource {
  final DatabaseHelper databaseHelper;

  SurahLocalDataSourceImpl({required this.databaseHelper});
  @override
  Future<void> cacheGetAllSurah(List<SurahTable> surah) async {
    await databaseHelper.clearCache('all surah');
    await databaseHelper.insertCacheTransaction(surah, 'all surah');
  }

  @override
  Future<List<SurahTable>> getCacheAllSurah() async {
    final result = await databaseHelper.getCacheAllSurah('all surah');
    if (result.isNotEmpty) {
      return result.map((e) => SurahTable.fromMap(e)).toList();
    } else {
      throw CacheException('Cant get the data');
    }
  }
}
