import 'package:al_quran_apps/presentation/bloc/juz_surah/juz_bloc.dart';
import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:al_quran_apps/presentation/components/components_helpers.dart';
import 'package:al_quran_apps/presentation/widgets/audio_manager.dart';
import 'package:al_quran_apps/presentation/widgets/ayat_card.dart';
import 'package:al_quran_apps/presentation/widgets/list_of_ayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/colors.dart';

class JuzSurahPage extends StatefulWidget {
  final int number;
  const JuzSurahPage({required this.number, super.key});

  @override
  State<JuzSurahPage> createState() => _JuzSurahPageState();
}

class _JuzSurahPageState extends State<JuzSurahPage> {
  bool? isTranslate = true;
  List<String> playList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<JuzBloc>(context, listen: false)
              .add(FetchSurahJuz(number: widget.number)),
          BlocProvider.of<ShowTranslateBloc>(context, listen: false)
              .add(ShowingEvent()),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: darkColor,
        elevation: 2,
        shadowColor: darkColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        title: Image.asset(
          'assets/images/bismillah.png',
          height: 28,
          color: darkColor,
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<JuzBloc, JuzState>(builder: (context, state) {
            if (state is JuzLoaded) {
              return IconButton(
                onPressed: () {
                  myModalBottomSheet(
                    context: context,
                    content:
                        "Juz ${state.result.juz} dimulai dari surat ${state.result.juzStartInfo} s/d surat ${state.result.juzEndInfo}, yang terdiri dari ${state.result.totalVerses} ayat",
                  );
                },
                icon: const Icon(
                  Icons.menu_book_outlined,
                ),
              );
            }
            return Container();
          }),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<JuzBloc, JuzState>(
        builder: (context, state) {
          if (state is JuzLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JuzLoaded) {
            final result = state.result;

            return BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
              builder: (context, state) {
                if (state is ShowingState) {
                  return ListOfAyat(juz: result);
                } else if (state is HiddenState) {
                  return CardOfAyat(
                    juz: result,
                  );
                } else {
                  return Container();
                }
              },
            );
          } else if (state is JuzError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Text(
              key: Key("error_message"),
              "Failed",
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        color: kOxfordBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocConsumer<ShowTranslateBloc, ShowTranslateState>(
              listener: (context, state) {
                if (state is ShowingState) {
                  isTranslate = state.result;
                } else if (state is HiddenState) {
                  isTranslate = state.result;
                }
              },
              builder: (context, state) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text('Show translate'),
                    Checkbox(
                      value: isTranslate,
                      onChanged: (value) {
                        if (value!) {
                          context.read<ShowTranslateBloc>().add(ShowingEvent());
                        } else {
                          context.read<ShowTranslateBloc>().add(HiddenEvent());
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<JuzBloc, JuzState>(
              builder: (context, state) {
                if (state is JuzLoaded) {
                  final juz = state.result;
                  playList = juz.verses.map((e) => e.audio!.primary!).toList();
                  // if (juz.preBismillah.audio!.primary == null) {
                  //   playList = listAyat;
                  // } else {
                  //   listAyat.insert(0, juz.preBismillah.audio!.primary!);
                  //   playList = listAyat;
                  // }
                  return AudioManager(
                    title: "${juz.juzStartInfo} s/d ${juz.juzEndInfo}",
                    album: "Juz ${juz.juz} - ${juz.totalVerses} ayat",
                    playList: playList,
                  );
                }
                return const Text('Loading...');
              },
            ),
          ],
        ),
      ),
    );
  }
}
