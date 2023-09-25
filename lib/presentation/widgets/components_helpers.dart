import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audio_service/audio_service.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/common/routes.dart';
import '../../data/helpers/preference_helper.dart';
import '../../domain/entities/detail_surah/detail_surah.dart';
import '../../domain/entities/detail_surah/verses.dart';
import '../../domain/entities/juz.dart';
import '../../injection.dart';
import '../bloc/detail_surah/detail_surah_bloc.dart';
import '../bloc/juz_surah/juz_bloc.dart';
import '../bloc/last_read/last_read_bloc.dart';
import '../bloc/play_audio/play_audio_bloc.dart';
import '../bloc/show_translate/show_tanslate_bloc.dart';

part 'my_modal_bottom_sheet.dart';
part 'my_snackbar.dart';
part 'audio_manager.dart';
part 'ayat_card.dart';
part 'introduction_screen.dart';
part 'list_of_ayat.dart';
part 'splash_screen.dart';
part 'my_bottom_bar.dart';
