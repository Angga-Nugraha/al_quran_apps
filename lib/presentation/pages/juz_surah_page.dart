import 'package:al_quran_apps/presentation/bloc/juz_surah/juz_bloc.dart';
import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:al_quran_apps/presentation/widgets/surah_card.dart';
import 'package:al_quran_apps/presentation/widgets/surah_card_list.dart';
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
  bool isTranslate = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<JuzBloc>(context, listen: false)
        .add(FetchSurahJuz(number: widget.number)));
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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_book_outlined,
            ),
          ),
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
            final verses = state.result.verses;
            return Column(
              children: [
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(10),
                  shadowColor: kDavysGrey,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Juz ${state.result.juz}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Surat ${state.result.juzStartInfo}\ns/d\nSurat ${state.result.juzEndInfo}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Total Ayat : ${state.result.totalVerses} ayat',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
                  builder: (context, state) {
                    if (state is ShowingState) {
                      isTranslate = state.result;
                    } else if (state is HiddenState) {
                      isTranslate = state.result;
                    }
                    return Expanded(
                        child: isTranslate
                            ? SurahListcard(verses: verses)
                            : SurahCard(verses: verses));
                  },
                ),
              ],
            );
          }
          return Container();
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
            // Expanded(
            //   child: BlocBuilder<DetailSurahBloc, DetailSurahState>(
            //     builder: (context, state) {
            //       // if (state is DetailSurahHasData) {
            //       //   surah = state.result;
            //       //   final bismillah = surah.preBismillah.text!.arab;
            //       //   hasBismillah = bismillah == null ? true : false;
            //       //   listAudio = _getAudio(surah, hasBismillah);
            //       // }
            //       return AudioHelper(listAudio: listAudio);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
