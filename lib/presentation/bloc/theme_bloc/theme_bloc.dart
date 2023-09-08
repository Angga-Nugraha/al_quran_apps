import 'package:al_quran_apps/domain/usecases/theme/get_dark_theme.dart';
import 'package:al_quran_apps/domain/usecases/theme/set_dark_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  SetDarkTheme setDarkTheme;
  GetDarkTheme getDarkTheme;
  ThemeBloc({required this.setDarkTheme, required this.getDarkTheme})
      : super(ThemeInitial()) {
    on<SetDarkEvent>((event, emit) async {
      final result = await setDarkTheme.execute(event.value);
      result.fold(
        (l) => emit(DarkThemeHasError(message: l.message)),
        (r) => emit(IsDarkTheme(value: r)),
      );
    });
    on<GetDarkEvent>((event, emit) async {
      final result = await getDarkTheme.execute();
      result.fold(
        (l) => emit(DarkThemeHasError(message: l.message)),
        (r) => emit(DarkThemeHasData(value: r)),
      );
    });
  }
}
