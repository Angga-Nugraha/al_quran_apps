import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../components/components_helpers.dart';

class SurahListcard extends StatelessWidget {
  SurahListcard({required this.verses, super.key});

  final List<Verses> verses;

  final arabicNumber = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15.0),
      physics: const BouncingScrollPhysics(),
      itemCount: verses.length,
      itemBuilder: (context, index) {
        final ayat = verses[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              color: kDavysGrey,
              child: ListTile(
                iconColor: darkColor,
                textColor: darkColor,
                leading: Text(
                  arabicNumber.convert(ayat.number!.inSurah),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Uthmanic",
                      fontSize: 28),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        myModalBottomSheet(
                          context: context,
                          content: verses[index].tafsir!.id.long,
                        );
                      },
                      icon: const Icon(
                        Icons.menu_book_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        mySnackbar(context: context, message: 'message');
                      },
                      icon: const Icon(
                        Icons.bookmark_border,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              ayat.text!.arab!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                fontFamily: 'Uthmanic',
              ),
              textDirection: TextDirection.rtl,
              // textAlign: TextAlign.justify,
              textWidthBasis: TextWidthBasis.longestLine,
            ),
            const SizedBox(height: 10),
            Text(
              '"${ayat.text!.transliteration!.en}"',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Text(
              '"${ayat.translation!.id}"',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
