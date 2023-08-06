import 'package:al_quran_apps/domain/entities/detail_surah/detail_surah.dart';
import 'package:al_quran_apps/domain/entities/surah/name.dart';
import 'package:al_quran_apps/domain/entities/detail_surah/prebismillah.dart';
import 'package:al_quran_apps/domain/entities/surah/revelation.dart';
import 'package:al_quran_apps/domain/entities/surah/tafsir.dart';
import 'package:al_quran_apps/domain/entities/detail_surah/verses.dart';
import 'package:al_quran_apps/domain/usecases/get_detail_surah.dart';
import 'package:al_quran_apps/presentation/bloc/detail_surah/detail_surah_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_surah_bloc_test.mocks.dart';

@GenerateMocks([GetDetailSurah])
void main() {
  late DetailSurahBloc detailSurahBloc;

  late MockGetDetailSurah mockGetDetailSurah;

  const testDetailSurah = DetailSurah(
    name: Name(
        short: 'short',
        long: 'long',
        transliteration: Transliteration(en: 'en', id: 'id'),
        translation: Translation(en: 'en', id: 'id')),
    number: 1,
    numberOfVerses: 1,
    preBismillah: PreBismillah(),
    revelation: Revelation(),
    sequence: 1,
    tafsir: Tafsir(),
    verses: [Verses()],
  );

  setUp(() {
    mockGetDetailSurah = MockGetDetailSurah();
    detailSurahBloc = DetailSurahBloc(getDetailSurah: mockGetDetailSurah);
  });

  const tId = 1;
  group('GetDetail Surah', () {
    test('Initial state should be empty', () {
      expect(detailSurahBloc.state, DetailSurahEmpty());
    });

    blocTest<DetailSurahBloc, DetailSurahState>(
      'should get detail surah from the usecase',
      build: () {
        when(mockGetDetailSurah.execute(tId))
            .thenAnswer((_) async => const Right(testDetailSurah));
        return detailSurahBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailSurah(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailSurahLoading(),
        const DetailSurahHasData(result: testDetailSurah)
      ],
      verify: (bloc) {
        verify(mockGetDetailSurah.execute(tId));
      },
    );
  });

  // blocTest<DetailSurahBloc, DetailSurahState>(
  //   'Should emit failure when get detail surah unsuccessful',
  //   build: () {
  //     when(mockGetDetailSurah.execute(tId))
  //         .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
  //     return detailSurahBloc;
  //   },
  //   act: (bloc) => bloc.add(const FetchDetailMovie(tId)),
  //   wait: const Duration(milliseconds: 500),
  //   expect: () => [
  //     DetailSurahLoading(),
  //     const DetailMovieError('Server Failure'),
  //   ],
  //   verify: (bloc) {
  //     verify(mockGetDetailSurah.execute(tId));
  //   },
  // );
}
