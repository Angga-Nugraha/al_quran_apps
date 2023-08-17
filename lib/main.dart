import 'package:al_quran_apps/domain/repositories/audio_repositories.dart';
import 'package:al_quran_apps/presentation/bloc/juz_surah/juz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'common/colors.dart';
import 'common/routes.dart';
import 'common/utils.dart';

import 'presentation/pages/juz_surah_page.dart';
import 'presentation/pages/root_screen.dart';
import 'presentation/widgets/splash.dart';
import 'presentation/bloc/detail_surah/detail_surah_bloc.dart';
import 'presentation/bloc/list_surah/list_surah_bloc.dart';
import 'presentation/bloc/play_audio/play_audio_bloc.dart';
import 'presentation/bloc/search_surah/search_surah_bloc.dart';
import 'presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'presentation/pages/detail_surah_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/landing_page.dart';

import 'injection.dart' as di;

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    di.locator<AudioRepositories>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<ListSurahBloc>()),
        BlocProvider(create: (_) => di.locator<DetailSurahBloc>()),
        BlocProvider(create: (_) => di.locator<PlayAudioBloc>()),
        BlocProvider(create: (_) => di.locator<ShowTranslateBloc>()),
        BlocProvider(create: (_) => di.locator<SearchSurahBloc>()),
        BlocProvider(create: (_) => di.locator<JuzBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,
        ),
        navigatorObservers: [routeObserver],
        home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 5)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            return const LandingPage();
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
    );
  }
}
