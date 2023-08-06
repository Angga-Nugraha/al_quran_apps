import 'package:al_quran_apps/common/network_info.dart';
import 'package:al_quran_apps/data/datasource/local_data_source.dart';
import 'package:al_quran_apps/data/helpers/database_helper.dart';
import 'package:al_quran_apps/domain/usecases/get_surah_juz.dart';
import 'package:al_quran_apps/domain/usecases/search_surah.dart';
import 'package:al_quran_apps/presentation/bloc/search_surah/search_surah_bloc.dart';
import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasource/surah_data_source.dart';
import 'data/repositories/surah_repositorieas_impl.dart';
import 'domain/repositories/surah_repositories.dart';
import 'domain/usecases/get_detail_surah.dart';
import 'domain/usecases/get_list_surah.dart';
import 'presentation/bloc/detail_surah/detail_surah_bloc.dart';
import 'presentation/bloc/juz_surah/juz_bloc.dart';
import 'presentation/bloc/list_surah/list_surah_bloc.dart';
import 'presentation/bloc/play_audio/play_audio_bloc.dart';

final locator = GetIt.instance;

void init() {
//=========================== BLOC ===========================
  locator.registerFactory(() => ListSurahBloc(getListSurah: locator()));
  locator.registerFactory(() => DetailSurahBloc(getDetailSurah: locator()));
  locator.registerFactory(() => PlayAudioBloc());
  locator.registerFactory(() => ShowTranslateBloc());
  locator.registerFactory(() => SearchSurahBloc(searchSurah: locator()));
  locator.registerFactory(() => JuzBloc(getSurahJuz: locator()));

// ===================== USECASE ==============================
  locator.registerLazySingleton(() => GetListSurah(locator()));
  locator.registerLazySingleton(() => GetDetailSurah(locator()));
  locator.registerLazySingleton(() => SearchSurah(locator()));
  locator.registerLazySingleton(() => GetSurahJuz(locator()));
  locator.registerLazySingleton(() => DatabaseHelper());

// ===================== REPOSITORY ==========================
  locator.registerLazySingleton<SurahRepository>(
    () => SurahRepositoryImpl(
      surahRemoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
// ===================== DATASOURCE =========================
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: locator()),
  );

  locator.registerLazySingleton<SurahDataSource>(
    () => SurahDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<SurahLocalDataSource>(
    () => SurahLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
