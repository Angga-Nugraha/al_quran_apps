import 'package:al_quran_apps/common/utils.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

import '../../common/routes.dart';
import '../../domain/entities/surah/surah.dart';

class SurahList extends StatelessWidget {
  final List<Surah> surah;
  SurahList({super.key, required this.surah});

  final arabicNumber = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: Text(
                  arabicNumber.convert(listSurah.number),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    fontFamily: 'Uthmanic',
                  ),
                ),
                title: Text(
                  listSurah.name!.transliteration!.id!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
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
              // const Divider(
              //   color: darkColor,
              // ),
            ],
          ),
        );
      },
      itemCount: surah.length,
    );
  }
}
