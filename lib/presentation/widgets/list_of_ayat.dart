part of 'components_helpers.dart';

class ListOfAyat extends StatefulWidget {
  const ListOfAyat({this.detailSurah, this.juz, super.key});

  final DetailSurah? detailSurah;
  final Juz? juz;

  @override
  State<ListOfAyat> createState() => _ListOfAyatState();
}

class _ListOfAyatState extends State<ListOfAyat> {
  final arabicNumber = ArabicNumbers();
  bool? isLastRead;
  List<Verses> verses = [];
  String? preBismillah;

  @override
  void initState() {
    Future.microtask(() => BlocProvider.of<LastReadBloc>(context, listen: false)
        .add(GetLastReadEvent()));
    verses = widget.detailSurah == null
        ? widget.juz!.verses
        : widget.detailSurah!.verses;
    preBismillah = widget.detailSurah == null
        ? null
        : widget.detailSurah!.preBismillah.text!.arab;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LastReadBloc, LastReadState>(
      listener: (context, state) {
        if (state is LastReadHasSuccess) {
          mySnackbar(context: context, message: "Add to Last read");
        }
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        children: [
          preBismillah == null
              ? const SizedBox()
              : Text(
                  preBismillah ?? '',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Uthmanic",
                    fontSize: 30,
                  ),
                ),
          Wrap(
            children: List.generate(
              verses.length,
              (index) => Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<LastReadBloc, LastReadState>(
                      builder: (context, state) {
                        if (state is LastReadHasData) {
                          if (widget.detailSurah != null) {
                            checkLastRead(
                                state.result, verses[index].number!.inSurah!);
                          }
                        }

                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          tileColor: isLastRead ?? false
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onPrimary,
                          leading: Text(
                            arabicNumber.convert(verses[index].number!.inSurah),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Uthmanic",
                              fontSize: 30,
                              color: isLastRead ?? false
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.surface,
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
                                  icon: Icon(
                                    Icons.menu_book_outlined,
                                    color: isLastRead ?? false
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: widget.detailSurah == null
                              ? null
                              : PopupMenuButton(
                                  color: isLastRead ?? false
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.surface,
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
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      verses[index].text!.arab!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        fontFamily: 'Uthmanic',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '"${verses[index].text!.transliteration!.en}"',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '"${verses[index].translation!.id}"',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkLastRead(Map<String, dynamic> data, int numSurah) {
    if (data['surah_number'] == widget.detailSurah!.number &&
        data['ayat'] == numSurah) {
      isLastRead = true;
    } else {
      isLastRead = false;
    }
  }
}
