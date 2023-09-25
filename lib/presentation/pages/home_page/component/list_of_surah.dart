import 'package:al_quran_apps/presentation/bloc/list_surah/list_surah_bloc.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/common/routes.dart';
import '../../../../domain/entities/surah/surah.dart';
import '../../../bloc/search_surah/search_surah_bloc.dart';

class SurahList extends StatelessWidget {
  SurahList({super.key});

  final arabicNumber = ArabicNumbers();
  static List<Surah> searchListSurah = [];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ListSurahBloc>().add(FetchNowListSurah());
      },
      child: BlocBuilder<ListSurahBloc, ListSurahState>(
        builder: (context, state) {
          if (state is SurahListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SurahListHasData) {
            var listSurah = state.result;
            return BlocConsumer<SearchSurahBloc, SearchSurahState>(
              listener: (context, state) {
                if (state is CancelHasData) {
                  searchListSurah = listSurah;
                } else if (state is SearchSurahHasData) {
                  listSurah = searchListSurah = state.result;
                }
              },
              builder: (context, state) {
                if (listSurah.isEmpty) {
                  return const Center(child: Text('Not Found'));
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final surah = listSurah[index];
                    return InkWell(
                      onTap: () {
                        Navigation.intentWithData(
                          detailPageRoutes,
                          arguments: surah.number!,
                        );
                      },
                      child: ListTile(
                        leading: Text(
                          arabicNumber.convert(surah.number),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'Uthmanic',
                          ),
                        ),
                        title: Text(
                          surah.name!.transliteration!.id!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          '${surah.revelation!.id}, ${surah.numberOfVerses} ayat',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Text(
                          '${surah.name!.short}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'Uthmanic',
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    );
                  },
                  itemCount: listSurah.length,
                );
              },
            );
          } else if (state is SurahListError) {
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
    );
  }
}
