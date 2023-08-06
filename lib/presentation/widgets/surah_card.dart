import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

class SurahCard extends StatefulWidget {
  final List<Verses> verses;
  final String? bism;
  const SurahCard({super.key, required this.verses, this.bism});

  @override
  State<SurahCard> createState() => _SurahCardState();
}

class _SurahCardState extends State<SurahCard> {
  final arabicNumber = ArabicNumbers();

  String allAyat = "";

  String result(List<Verses> verses) {
    var ayah = '';
    var numb = '';
    for (var ayat in verses) {
      ayah = "${ayat.text!.arab}";
      numb = arabicNumber.convert(ayat.number!.inSurah);
      allAyat = '$allAyat$ayah$numb ';
    }
    return allAyat;
  }

  @override
  void initState() {
    super.initState();
    result(widget.verses);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/border.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
          child: SingleChildScrollView(
            child: Text(
              "${widget.bism ?? ''}\n$allAyat",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.longestLine,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                fontFamily: 'Uthmanic',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
