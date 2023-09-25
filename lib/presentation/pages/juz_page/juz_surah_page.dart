import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/juz_surah/juz_bloc.dart';
import '../../bloc/show_translate/show_tanslate_bloc.dart';
import '../../widgets/components_helpers.dart';

class JuzSurahPage extends StatefulWidget {
  final int number;
  const JuzSurahPage({required this.number, super.key});

  @override
  State<JuzSurahPage> createState() => _JuzSurahPageState();
}

class _JuzSurahPageState extends State<JuzSurahPage> {
  bool? isTranslate;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<JuzBloc>(context, listen: false)
          .add(FetchSurahJuz(number: widget.number)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ),
          title: Image.asset(
            'assets/images/bismillah.png',
            height: 28,
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<JuzBloc, JuzState>(builder: (context, state) {
              if (state is JuzLoaded) {
                return IconButton(
                  onPressed: () {
                    myModalBottomSheet(
                      context: context,
                      content:
                          "Juz ${state.result.juz} dimulai dari surat ${state.result.juzStartInfo} s/d surat ${state.result.juzEndInfo}, yang terdiri dari ${state.result.totalVerses} ayat",
                    );
                  },
                  icon: const Icon(
                    Icons.menu_book_outlined,
                  ),
                );
              }
              return Container();
            }),
            const SizedBox(width: 20),
          ],
        ),
        body: BlocBuilder<JuzBloc, JuzState>(
          builder: (context, state) {
            if (state is JuzLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is JuzLoaded) {
              final result = state.result;

              return BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
                builder: (context, state) {
                  if (state is ShowingState) {
                    isTranslate = state.result;
                  }
                  return isTranslate == true
                      ? ListOfAyat(juz: result)
                      : CardOfAyat(
                          juz: result,
                        );
                },
              );
            } else if (state is JuzError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Text(
                key: Key("error_message"),
                "Failed",
              );
            }
          },
        ),
        bottomNavigationBar: const MyBottomBar(title: 'Juz'));
  }
}
