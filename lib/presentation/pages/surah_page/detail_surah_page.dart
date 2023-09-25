import 'package:al_quran_apps/presentation/bloc/show_translate/show_tanslate_bloc.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/common/routes.dart';
import '../../bloc/detail_surah/detail_surah_bloc.dart';
import '../../widgets/components_helpers.dart';

class DetailSurahPage extends StatefulWidget {
  final int number;
  const DetailSurahPage({
    super.key,
    required this.number,
  });

  @override
  State<DetailSurahPage> createState() => _DetailSurahPageState();
}

class _DetailSurahPageState extends State<DetailSurahPage> {
  bool? _isTranslated;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => BlocProvider.of<DetailSurahBloc>(context, listen: false)
          .add(FetchDetailSurah(widget.number)),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigation.back();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ),
          title: BlocBuilder<DetailSurahBloc, DetailSurahState>(
            builder: (context, state) {
              if (state is DetailSurahHasData) {
                return Text(
                  state.result.name.transliteration!.id!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return const Text('');
            },
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<DetailSurahBloc, DetailSurahState>(
              builder: (context, state) {
                if (state is DetailSurahHasData) {
                  return GestureDetector(
                    onTap: () {
                      myModalBottomSheet(
                        context: context,
                        content: state.result.tafsir.id!,
                      );
                    },
                    child: const Icon(
                      Icons.menu_book_outlined,
                    ),
                  );
                }
                return const Icon(
                  Icons.menu_book_outlined,
                );
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: BlocBuilder<DetailSurahBloc, DetailSurahState>(
          builder: (context, state) {
            if (state is DetailSurahLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailSurahHasData) {
              final surah = state.result;
              return BlocBuilder<ShowTranslateBloc, ShowTranslateState>(
                builder: (context, state) {
                  if (state is ShowingState) {
                    _isTranslated = state.result;
                  }
                  return _isTranslated ?? true
                      ? ListOfAyat(detailSurah: surah)
                      : CardOfAyat(
                          detailSurah: surah,
                        );
                },
              );
            } else if (state is DetailSurahError) {
              final message = state.message;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    IconButton(
                        onPressed: () {
                          context
                              .read<DetailSurahBloc>()
                              .add(FetchDetailSurah(widget.number));
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
              );
            } else {
              return const Text(
                key: Key('error_message'),
                'Failed',
              );
            }
          },
        ),
        bottomNavigationBar: const MyBottomBar(title: 'Surah'),
      ),
    );
  }
}
