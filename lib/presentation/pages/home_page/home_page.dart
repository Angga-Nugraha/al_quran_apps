import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/helpers/notification_helper.dart';
import '../../bloc/last_read/last_read_bloc.dart';
import '../../bloc/list_surah/list_surah_bloc.dart';
import '../../bloc/search_surah/search_surah_bloc.dart';
import 'component/last_read_banner.dart';
import 'component/list_of_juz.dart';
import 'component/list_of_surah.dart';
import 'component/tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  late NotificationHelper notificationHelper;

  bool? _isSearching;
  IconData icon = Icons.search_outlined;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 2, vsync: this);

    Future.microtask(() => [
          BlocProvider.of<LastReadBloc>(context, listen: false)
              .add(GetLastReadEvent()),
          BlocProvider.of<ListSurahBloc>(context, listen: false)
              .add(FetchNowListSurah())
        ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BlocConsumer<SearchSurahBloc, SearchSurahState>(
          listener: (context, state) {
            if (state is SearchHasClicked) {
              _isSearching = state.search;
              icon = Icons.cancel_rounded;
            }
            if (state is CancelHasData) {
              _isSearching = state.search;
              icon = Icons.search_outlined;
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isSearching ?? false
                    ? Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
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
                        'Al-Qur\'an Evo',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                IconButton(
                  icon: Icon(
                    icon,
                  ),
                  onPressed: () {
                    if (icon == Icons.cancel_rounded) {
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<LastReadBloc, LastReadState>(
              builder: (context, state) {
                if (state is LastReadHasData) {
                  return LastReadBanner(lastRead: state.result);
                } else if (state is LastReadHasError) {
                  return const LastReadBanner(lastRead: {});
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 10.0),
            MyTabBar(tab: const ['Surah', 'Juz'], controller: _controller),
            const SizedBox(height: 10.0),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                children: [
                  SurahList(),
                  const ListOfJuz(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
