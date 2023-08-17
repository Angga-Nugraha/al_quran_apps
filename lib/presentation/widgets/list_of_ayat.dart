import 'package:al_quran_apps/common/colors.dart';
import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:al_quran_apps/presentation/components/components_helpers.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

class ListOfAyat extends StatelessWidget {
  ListOfAyat({required this.verses, this.preBismillah, super.key});

  final List<Verses> verses;
  final String? preBismillah;

  final arabicNumber = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            preBismillah == null
                ? Container()
                : Text(
                    preBismillah ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Uthmanic",
                      fontSize: 28,
                    ),
                  ),
            Wrap(
              children: List.generate(
                verses.length,
                (index) {
                  final ayat = verses[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
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
                                fontSize: 28,
                              ),
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
                                    mySnackbar(
                                        context: context, message: 'message');
                                  },
                                  splashRadius: 0.1,
                                  icon: const Icon(
                                    Icons.bookmark_border,
                                  ),
                                  tooltip: "Tandai terakhir baca",
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
