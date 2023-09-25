part of 'components_helpers.dart';

class CardOfAyat extends StatefulWidget {
  final DetailSurah? detailSurah;
  final Juz? juz;

  const CardOfAyat({super.key, this.detailSurah, this.juz});

  @override
  State<CardOfAyat> createState() => _CardOfAyatState();
}

class _CardOfAyatState extends State<CardOfAyat> {
  final arabicNumber = ArabicNumbers();
  bool? isLastRead;
  List<Verses> verses = [];
  String? preBismillah;

  @override
  void initState() {
    super.initState();
    verses = widget.detailSurah == null
        ? widget.juz!.verses
        : widget.detailSurah!.verses;
    preBismillah = widget.detailSurah == null
        ? null
        : widget.detailSurah!.preBismillah.text!.arab;

    Future.microtask(() => BlocProvider.of<LastReadBloc>(context, listen: false)
        .add(GetLastReadEvent()));
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/border.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  preBismillah == null
                      ? const SizedBox()
                      : Text(
                          preBismillah ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Uthmanic",
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  result(verses),
                ],
              ),
            ),
          ),
        ),
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

  Widget result(List<Verses> verses) {
    return Wrap(
      textDirection: TextDirection.rtl,
      alignment: WrapAlignment.center,
      children: List.generate(
        verses.length,
        (index) => BlocBuilder<LastReadBloc, LastReadState>(
          builder: (context, state) {
            if (state is LastReadHasData) {
              widget.detailSurah == null
                  ? () {}
                  : checkLastRead(state.result, verses[index].number!.inSurah!);
            }
            return widget.detailSurah == null
                ? _buildAyah(verses, index)
                : ContextMenuRegion(
                    contextMenu: GenericContextMenu(
                      buttonStyle: ContextMenuButtonStyle(
                          padding: EdgeInsets.zero,
                          bgColor: Theme.of(context).colorScheme.primary),
                      buttonConfigs: [
                        ContextMenuButtonConfig(
                          "Tandai terakhir dibaca",
                          onPressed: () {
                            Map<String, dynamic> values = {
                              "surah_number": widget.detailSurah!.number,
                              "surah_name":
                                  widget.detailSurah!.name.transliteration!.id,
                              "juz": verses[index].meta!.juz,
                              "ayat": verses[index].number!.inSurah
                            };
                            context
                                .read<LastReadBloc>()
                                .add(InsertLastReadEvent(surah: values));
                          },
                        ),
                        ContextMenuButtonConfig("Tafsir", onPressed: () {
                          myModalBottomSheet(
                            context: context,
                            content: verses[index].tafsir!.id.long,
                          );
                        })
                      ],
                    ),
                    child: _buildAyah(verses, index),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildAyah(List<Verses> verses, int index) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: verses[index].text!.arab!,
          ),
          TextSpan(
            text: arabicNumber.convert(verses[index].number!.inSurah!),
          ),
        ],
      ),
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: "Uthmanic",
        fontSize: 30,
        color: isLastRead == true ? Colors.redAccent : null,
      ),
      textAlign: TextAlign.center,
    );
  }
}
