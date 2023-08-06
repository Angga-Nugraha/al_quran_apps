import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:al_quran_apps/presentation/widgets/audio_player.dart';
import 'package:al_quran_apps/presentation/widgets/surah_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../domain/entities/detail_surah/detail_surah.dart';
import '../bloc/detail_surah/detail_surah_bloc.dart';
import '../components/components_helpers.dart';
import '../widgets/surah_card.dart';

class DetailSurahPage extends StatefulWidget {
  final int number;
  const DetailSurahPage({super.key, required this.number});

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  List<String> listAudio = [];
  late DetailSurah surah;
  late bool hasBismillah;
  static bool isTranslate = true;
  @override
  void initState() {
    super.initState();

    Future.microtask(() => Provider.of<DetailSurahBloc>(context, listen: false)
        .add(FetchDetailSurah(widget.number)));
  }

  List<String> _getAudio(DetailSurah detailSurah, bool hasBismillah) {
    List<String> result = [];
    if (!hasBismillah) {
      result.add(detailSurah.preBismillah.audio!.primary!);
    }
    for (var list in detailSurah.verses) {
      result.add(list.audio!.primary!);
    }
    return result;
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
          height: 35,
          color: Colors.black,
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
            return BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
              builder: (context, state) {
                if (state is ShowingState) {
                  isTranslate = state.result;
                } else if (state is HiddenState) {
                  isTranslate = state.result;
                }
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${surah.name.transliteration!.id}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                letterSpacing: 3),
                          ),
                          Text(
                            '${surah.name.translation!.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${surah.revelation.id} - ${surah.numberOfVerses} ayat',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Expanded(
                      flex: 4,
                      child: isTranslate
                          ? SurahListcard(verses: surah.verses)
                          : SurahCard(
                              verses: surah.verses,
                              bism: surah.preBismillah.text!.arab ?? '',
                            ),
                    ),
                  ],
                );
              },
            );
          } else if (state is DetailSurahError) {
            final message = state.message;
            return Center(
              child: Text(
                message,
              ),
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
        color: kOxfordBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
              child: Text(
                'Show translate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Flexible(
              child: BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
                builder: (context, state) {
                  if (state is ShowingState) {
                    isTranslate = state.result;
                  } else if (state is HiddenState) {
                    isTranslate = state.result;
                  }
                  return Checkbox(
                    value: isTranslate,
                    onChanged: (value) {
                      if (value!) {
                        context.read<ShowTranslateBloc>().add(ShowingEvent());
                      } else {
                        context.read<ShowTranslateBloc>().add(HiddenEvent());
                      }
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<DetailSurahBloc, DetailSurahState>(
                builder: (context, state) {
                  if (state is DetailSurahHasData) {
                    surah = state.result;
                    final bismillah = surah.preBismillah.text!.arab;
                    hasBismillah = bismillah == null ? true : false;
                    listAudio = _getAudio(surah, hasBismillah);
                  }
                  return AudioHelper(listAudio: listAudio);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
