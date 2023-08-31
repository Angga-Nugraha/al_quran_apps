import 'package:al_quran_apps/common/colors.dart';
import 'package:al_quran_apps/domain/entities/detail_surah/detail_surah.dart';
import 'package:al_quran_apps/presentation/bloc/last_read/last_read_bloc.dart';
import 'package:al_quran_apps/presentation/components/components_helpers.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/juz.dart';

class ListOfAyat extends StatefulWidget {
  const ListOfAyat(this.detailSurah, this.juz, {super.key});

  final DetailSurah? detailSurah;
  final Juz? juz;

  @override
  State<ListOfAyat> createState() => _ListOfAyatState();
}

class _ListOfAyatState extends State<ListOfAyat> {
  final arabicNumber = ArabicNumbers();

  @override
  void initState() {
    // Future.microtask(() => BlocProvider.of<LastReadBloc>(context, listen: false)
    //     .add(GetLastReadEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final verses = widget.detailSurah == null
        ? widget.juz!.verses
        : widget.detailSurah!.verses;
    final preBismillah = widget.detailSurah == null
        ? null
        : widget.detailSurah!.preBismillah.text!.arab;
    return Scaffold(
      body: BlocListener<LastReadBloc, LastReadState>(
        listener: (context, state) {
          if (state is LastReadHasSuccess) {
            mySnackbar(context: context, message: "Add to Last read");
            context.read<LastReadBloc>().add(GetLastReadEvent());
          }
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          children: [
            preBismillah == null
                ? const SizedBox()
                : Text(
                    preBismillah,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Uthmanic",
                      fontSize: 28,
                    ),
                  ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Flexible(
                                child: IconButton(
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
                              ),
                            ],
                          ),
                          trailing: widget.detailSurah == null
                              ? null
                              : PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  itemBuilder: (context) {
                                    Map<String, dynamic> values = {
                                      "surah_number":
                                          widget.detailSurah!.number,
                                      "surah_name": widget.detailSurah!.name
                                          .transliteration!.id,
                                      "juz": widget
                                          .detailSurah!.verses[index].meta!.juz,
                                      "ayat": verses[index].number!.inSurah
                                    };

                                    return [
                                      PopupMenuItem(
                                        value: values,
                                        child: const Text(
                                            "Tandai terakhir dibaca"),
                                      ),
                                    ];
                                  },
                                  onSelected: (value) {
                                    context
                                        .read<LastReadBloc>()
                                        .add(InsertLastReadEvent(surah: value));
                                  },
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
              itemCount: verses.length,
            ),
          ],
        ),
      ),
    );
  }
}
