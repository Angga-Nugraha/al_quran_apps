part of 'components_helpers.dart';

class MyBottomBar extends StatelessWidget {
  final String title;

  const MyBottomBar({required this.title, super.key});

  static bool? _isTranslated;
  static List<String> playList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(5.0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
            builder: (context, state) {
              if (state is ShowTranslateInitial) {
                _isTranslated = state.result;
              }
              if (state is ShowingState) {
                _isTranslated = state.result;
              }
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("Show Translate"),
                  Checkbox(
                    value: _isTranslated ?? true,
                    onChanged: (value) {
                      context
                          .read<ShowTranslateBloc>()
                          .add(ShowingEvent(value!));
                    },
                  ),
                ],
              );
            },
          ),
          Container(
            child: (() {
              switch (title) {
                case 'Surah':
                  return BlocBuilder<DetailSurahBloc, DetailSurahState>(
                    builder: (context, state) {
                      if (state is DetailSurahHasData) {
                        final surah = state.result;
                        final listAyat =
                            surah.verses.map((e) => e.audio!.primary!).toList();
                        if (surah.preBismillah.audio!.primary == null) {
                          playList = listAyat;
                        } else {
                          listAyat.insert(
                              0, surah.preBismillah.audio!.primary!);
                          playList = listAyat;
                        }
                        return AudioManager(
                          title:
                              "${surah.name.transliteration!.id!} 1 - ${surah.verses.length}",
                          album: surah.name.transliteration!.id!,
                          playList: playList,
                        );
                      }
                      return const Text('Loading...');
                    },
                  );
                case 'Juz':
                  return BlocBuilder<JuzBloc, JuzState>(
                    builder: (context, state) {
                      if (state is JuzLoaded) {
                        final juz = state.result;
                        playList =
                            juz.verses.map((e) => e.audio!.primary!).toList();

                        return AudioManager(
                          title: "${juz.juzStartInfo} s/d ${juz.juzEndInfo}",
                          album: "Juz ${juz.juz} - ${juz.totalVerses} ayat",
                          playList: playList,
                        );
                      }
                      return const Text('Loading...');
                    },
                  );
                default:
              }
            }()),
          ),
        ],
      ),
    );
  }
}
