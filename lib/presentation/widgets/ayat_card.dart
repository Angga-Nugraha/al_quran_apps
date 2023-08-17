import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

class CardOfAyat extends StatefulWidget {
  final List<Verses> verses;
  final String? preBismillah;
  const CardOfAyat({super.key, required this.verses, this.preBismillah});

  @override
  State<CardOfAyat> createState() => _CardOfAyatState();
}

class _CardOfAyatState extends State<CardOfAyat> {
  final arabicNumber = ArabicNumbers();

  String allAyat = "";

  Map<int, List<String>> groupedItems = {};

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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/border.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              "${widget.preBismillah ?? ''}\n${result(widget.verses)}",
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
