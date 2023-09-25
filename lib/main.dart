import 'dart:io';

import 'package:al_quran_apps/data/common/styles.dart';
import 'package:al_quran_apps/data/helpers/notification_helper.dart';
import 'package:al_quran_apps/data/helpers/preference_helper.dart';
import 'package:al_quran_apps/presentation/bloc/reminder_bloc/reminder_bloc.dart';
import 'package:al_quran_apps/presentation/bloc/theme_bloc/theme_bloc.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'data/common/routes.dart';

import 'presentation/bloc/detail_surah/detail_surah_bloc.dart';
import 'presentation/bloc/juz_surah/juz_bloc.dart';
import 'presentation/bloc/last_read/last_read_bloc.dart';
import 'presentation/bloc/list_surah/list_surah_bloc.dart';
import 'presentation/bloc/play_audio/play_audio_bloc.dart';
import 'presentation/bloc/search_surah/search_surah_bloc.dart';
import 'presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'presentation/pages/root_screen.dart';
import 'presentation/pages/juz_page/juz_surah_page.dart';
import 'presentation/pages/surah_page/detail_surah_page.dart';
import 'presentation/pages/home_page/home_page.dart';

import 'injection.dart' as di;
import 'presentation/widgets/components_helpers.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di
      .locator<NotificationHelper>()
      .initNotification(flutterLocalNotificationsPlugin);
  // await di.locator<DatabaseHelper>().clearCache('Last_read', 'last read');

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioHandler audioHandler;
  bool? isDarkTheme;

  Future<bool>? isFirstTime() async {
    await Future.delayed(const Duration(seconds: 5));
    return await di.locator<PreferencesHelper>().isFirstTime;
  }

  void close() async {
    await audioHandler.customAction("dispose");
  }

  @override
  void initState() {
    audioHandler = di.locator<AudioHandler>();
    super.initState();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<ListSurahBloc>()),
        BlocProvider(create: (_) => di.locator<DetailSurahBloc>()),
        BlocProvider(create: (_) => di.locator<PlayAudioBloc>()),
        BlocProvider(create: (_) => di.locator<ShowTranslateBloc>()),
        BlocProvider(create: (_) => di.locator<SearchSurahBloc>()),
        BlocProvider(create: (_) => di.locator<JuzBloc>()),
        BlocProvider(create: (_) => di.locator<LastReadBloc>()),
        BlocProvider(
          create: (_) => di.locator<ReminderBloc>()..add(GetReminder()),
        ),
        BlocProvider(
          create: (_) => di.locator<ThemeBloc>()..add(GetDarkEvent()),
        ),
      ],
      child: BlocConsumer<ThemeBloc, ThemeState>(
        listener: (context, state) {
          if (state is IsDarkTheme) {
            isDarkTheme = state.value;
          }
          if (state is DarkThemeHasData) {
            isDarkTheme = state.value;
          }
          if (state is DarkThemeHasError) {
            isDarkTheme = false;
          }
        },
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: isDarkTheme ?? false ? darkTheme : lightTheme,
          navigatorObservers: [routeObserver],
          home: FutureBuilder<bool>(
            future: isFirstTime(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  Future.delayed(const Duration(seconds: 3));
                  return const SplashScreen();
                default:
                  if (snapshot.hasData && snapshot.data!) {
                    return const IntroductionScreen();
                  } else {
                    return const RootScreen();
                  }
              }
            },
          ),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case homePageRoutes:
                return MaterialPageRoute(builder: (_) => const HomePage());
              case rootScreenPageRoutes:
                return MaterialPageRoute(builder: (_) => const RootScreen());

              case detailPageRoutes:
                final number = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => DetailSurahPage(number: number),
                  settings: settings,
                );
              case juzPageRoutes:
                final number = settings.arguments as int;
                return MaterialPageRoute(
                    builder: (_) => JuzSurahPage(number: number));
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          },
        ),
      ),
    );
  }
}
