import 'package:al_quran_apps/data/datasource/audio_handler.dart';
import 'package:al_quran_apps/common/network_info.dart';
import 'package:al_quran_apps/data/datasource/local_data_source.dart';
import 'package:al_quran_apps/data/helpers/database_helper.dart';
import 'package:al_quran_apps/data/repositories/audio_repositories_impl.dart';
import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';
import 'package:al_quran_apps/domain/usecases/audio/get_playlist.dart';
import 'package:al_quran_apps/domain/usecases/audio/seek_audio.dart';
import 'package:al_quran_apps/domain/usecases/juz/get_surah_juz.dart';
import 'package:al_quran_apps/domain/usecases/audio/play_audio.dart';
import 'package:al_quran_apps/domain/usecases/surah/search_surah.dart';
import 'package:al_quran_apps/presentation/bloc/search_surah/search_surah_bloc.dart';
import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:audio_service/audio_service.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasource/surah_data_source.dart';
import 'data/repositories/surah_repositorieas_impl.dart';
import 'domain/repositories/surah_repositories.dart';
import 'domain/usecases/surah/get_detail_surah.dart';
import 'domain/usecases/surah/get_list_surah.dart';
import 'domain/usecases/audio/pause_audio.dart';
import 'domain/usecases/audio/stop_audio.dart';
import 'presentation/bloc/detail_surah/detail_surah_bloc.dart';
import 'presentation/bloc/juz_surah/juz_bloc.dart';
import 'presentation/bloc/list_surah/list_surah_bloc.dart';
import 'presentation/bloc/play_audio/play_audio_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
//=========================== BLOC ===========================
  locator.registerFactory(() => ListSurahBloc(getListSurah: locator()));
  locator.registerFactory(() => DetailSurahBloc(getDetailSurah: locator()));
  locator.registerFactory(() => PlayAudioBloc(
        getPlaylist: locator(),
        playAudio: locator(),
        pauseAudio: locator(),
        stopAudio: locator(),
        seekAudio: locator(),
        skipToPreviuos: locator(),
        skipToNext: locator(),
      ));
  locator.registerFactory(() => ShowTranslateBloc());
  locator.registerFactory(() => SearchSurahBloc(searchSurah: locator()));
  locator.registerFactory(() => JuzBloc(getSurahJuz: locator()));

// ===================== USECASE ==============================
  locator.registerLazySingleton(() => GetListSurah(locator()));
  locator.registerLazySingleton(() => GetDetailSurah(locator()));
  locator.registerLazySingleton(() => SearchSurah(locator()));
  locator.registerLazySingleton(() => GetSurahJuz(locator()));
  locator.registerLazySingleton(() => GetPlaylist(locator()));
  locator.registerLazySingleton(() => PlayAudio(locator()));
  locator.registerLazySingleton(() => PauseAudio(locator()));
  locator.registerLazySingleton(() => StopAudio(locator()));
  locator.registerLazySingleton(() => SeekAudio(locator()));
  locator.registerLazySingleton(() => SkipToPreviuos(locator()));
  locator.registerLazySingleton(() => SkipToNext(locator()));
  locator.registerLazySingleton(() => DatabaseHelper());

// ===================== REPOSITORY ==========================
  locator.registerLazySingleton<SurahRepository>(
    () => SurahRepositoryImpl(
      surahRemoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<AudioRepositories>(
    () => AudioRepositoriesImpl(
        audioHandler: locator(), surahDataSource: locator()),
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

  locator.registerSingleton<AudioHandler>(await initAudioHandler());
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
