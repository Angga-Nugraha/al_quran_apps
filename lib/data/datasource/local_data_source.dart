import 'package:al_quran_apps/data/common/exception.dart';
import 'package:al_quran_apps/data/helpers/database_helper.dart';
import 'package:al_quran_apps/data/models/database_model/last_read_table.dart';
import 'package:al_quran_apps/data/models/database_model/surah_tabel.dart';

abstract class SurahLocalDataSource {
  Future<void> cacheGetAllSurah(List<SurahTable> surah);
  Future<List<SurahTable>> getCacheAllSurah();
  Future<void> insertLastRead(LastReadTable surah);
  Future<LastReadTable> getLastRead();
}

class SurahLocalDataSourceImpl implements SurahLocalDataSource {
  final DatabaseHelper databaseHelper;

  SurahLocalDataSourceImpl({required this.databaseHelper});
  @override
  Future<void> cacheGetAllSurah(List<SurahTable> surah) async {
    await databaseHelper.clearCache('Surah', 'all surah');
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

  @override
  Future<void> insertLastRead(LastReadTable surah) async {
    await databaseHelper.clearCache('Last_read', 'last read');
    await databaseHelper.insertlastReadTransaction(surah, 'last read');
  }

  @override
  Future<LastReadTable> getLastRead() async {
    final result = await databaseHelper.getLastRead('last read');
    if (result.isNotEmpty) {
      final data = result.map((e) => LastReadTable.fromMap(e)).first;

      return data;
    } else {
      throw CacheException('');
    }
  }
}
