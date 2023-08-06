import 'package:al_quran_apps/common/routes.dart';
import 'package:al_quran_apps/domain/entities/surah/surah.dart';
import 'package:al_quran_apps/presentation/bloc/search_surah/search_surah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../bloc/list_surah/list_surah_bloc.dart';
import '../widgets/last_read_banner.dart';
import '../widgets/surah_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);

    Future.microtask(() => Provider.of<ListSurahBloc>(context, listen: false)
        .add(FetchNowListSurah()));
  }

  static bool _isSearching = false;
  IconData icon = Icons.search_outlined;

  List<Surah> listSurah = [];
  List<Surah> searchListSurah = [];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<SearchSurahBloc, SearchSurahState>(
          listener: (context, state) {
            if (state is SearchHasClicked) {
              _isSearching = state.search;
              icon = Icons.cancel_outlined;
            } else if (state is CancelHasData) {
              _isSearching = state.search;
              icon = Icons.search_outlined;
            } else if (state is SearchSurahHasData) {
              searchListSurah = state.result;
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isSearching
                    ? Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Search surah here',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            context
                                .read<SearchSurahBloc>()
                                .add(OnQuerychange(value));
                          },
                        ),
                      )
                    : const Text(
                        'Al-Qur\'an',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: darkColor,
                        ),
                      ),
                IconButton(
                  icon: Icon(
                    icon,
                    color: darkColor,
                  ),
                  onPressed: () {
                    if (icon == Icons.cancel_outlined) {
                      searchListSurah = listSurah;
                      context
                          .read<SearchSurahBloc>()
                          .add(const CancelClicked());
                    } else {
                      context
                          .read<SearchSurahBloc>()
                          .add(const SearchClicked());
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LastReadBanner(),
            TabBar(
              splashBorderRadius: BorderRadius.circular(10),
              dividerColor: kDavysGrey,
              indicatorColor: darkColor,
              indicatorWeight: 3,
              controller: _controller,
              labelColor: darkColor,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              tabs: const [
                Tab(
                  text: 'Surah',
                ),
                Tab(
                  text: 'Juz',
                ),
              ],
            ),
            Flexible(
              child: SizedBox(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  children: [
                    BlocBuilder<ListSurahBloc, ListSurahState>(
                      builder: (context, state) {
                        if (state is SurahListLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SurahListHasData) {
                          listSurah = searchListSurah = state.result;
                          return BlocBuilder<SearchSurahBloc, SearchSurahState>(
                            builder: (context, state) {
                              if (state is CancelHasData) {
                                searchListSurah = listSurah;
                              } else if (state is SearchSurahHasData) {
                                searchListSurah = state.result;
                                if (searchListSurah.isEmpty) {
                                  return const Center(
                                    child: Text('Surah not found'),
                                  );
                                }
                              }
                              return SurahList(
                                surah: searchListSurah,
                              );
                            },
                          );
                        } else if (state is SurahListError) {
                          final message = state.message;
                          return Center(
                            child: Text(
                              message,
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
                    GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, juzPageRoutes,
                                arguments: index + 1);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kDavysGrey,
                            ),
                            child: Center(
                              child: Text(
                                'Juz ${(index + 1)}',
                                style: const TextStyle(
                                  color: darkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
