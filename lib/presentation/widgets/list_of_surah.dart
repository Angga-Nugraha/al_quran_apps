import 'package:al_quran_apps/common/utils.dart';
import 'package:al_quran_apps/presentation/bloc/list_surah/list_surah_bloc.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/routes.dart';
import '../../domain/entities/surah/surah.dart';

class SurahList extends StatelessWidget {
  final List<Surah> surah;
  SurahList({super.key, required this.surah});

  final arabicNumber = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ListSurahBloc>().add(FetchNowListSurah());
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final listSurah = surah[index];
          return InkWell(
            onTap: () {
              Navigation.intentWithData(
                detailPageRoutes,
                listSurah.number!,
              );
            },
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              leading: Text(
                arabicNumber.convert(listSurah.number),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Uthmanic',
                ),
              ),
              title: Text(
                listSurah.name!.transliteration!.id!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${listSurah.revelation!.id}, ${listSurah.numberOfVerses} ayat',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              trailing: Text(
                '${listSurah.name!.short}',
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
        itemCount: surah.length,
      ),
    );
  }
}
