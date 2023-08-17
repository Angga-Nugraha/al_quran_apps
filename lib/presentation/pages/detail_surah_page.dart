import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:al_quran_apps/presentation/widgets/audio_manager.dart';
import 'package:al_quran_apps/presentation/widgets/list_of_ayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/colors.dart';
import '../../domain/entities/detail_surah/detail_surah.dart';
import '../bloc/detail_surah/detail_surah_bloc.dart';
import '../components/components_helpers.dart';
import '../widgets/ayat_card.dart';

class DetailSurahPage extends StatefulWidget {
  final int number;
  const DetailSurahPage({super.key, required this.number});

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  late DetailSurah surah;
  bool? isTranslate = true;
  List<String> playList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => [
        BlocProvider.of<DetailSurahBloc>(context, listen: false)
            .add(FetchDetailSurah(widget.number)),
        BlocProvider.of<ShowTranslateBloc>(context, listen: false)
            .add(ShowingEvent()),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: darkColor,
        elevation: 2,
        shadowColor: darkColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        title: BlocBuilder<DetailSurahBloc, DetailSurahState>(
          builder: (context, state) {
            if (state is DetailSurahHasData) {
              return Text(state.result.name.transliteration!.id!);
            }
            return const Text('');
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              myModalBottomSheet(
                context: context,
                content: surah.tafsir.id!,
              );
            },
            icon: const Icon(
              Icons.menu_book_outlined,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<DetailSurahBloc, DetailSurahState>(
        builder: (context, state) {
          if (state is DetailSurahLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailSurahHasData) {
            surah = state.result;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
                  builder: (context, state) {
                    if (state is ShowingState) {
                      isTranslate = state.result;
                      return ListOfAyat(
                        verses: surah.verses,
                        preBismillah: surah.preBismillah.text!.arab,
                      );
                    } else if (state is HiddenState) {
                      isTranslate = state.result;
                      return CardOfAyat(
                        verses: surah.verses,
                        preBismillah: surah.preBismillah.text!.arab,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            );
          } else if (state is DetailSurahError) {
            final message = state.message;
            return Center(
              child: Text(message),
            );
          } else {
            return const Text(
              key: Key('error_message'),
              'Failed',
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        color: kDavysGrey,
        height: 60,
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
                    const Text("Show Translate"),
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
            BlocBuilder<DetailSurahBloc, DetailSurahState>(
              builder: (context, state) {
                if (state is DetailSurahHasData) {
                  surah = state.result;
                  final listAyat =
                      surah.verses.map((e) => e.audio!.primary!).toList();
                  if (surah.preBismillah.audio!.primary == null) {
                    playList = listAyat;
                  } else {
                    listAyat.insert(0, surah.preBismillah.audio!.primary!);
                    playList = listAyat;
                  }
                  return AudioManager(
                    title:
                        "${surah.name.transliteration!.id!} 1 - ${surah.verses.length}",
                    album: surah.name.transliteration!.id!,
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
