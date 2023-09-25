import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_tanslate_event.dart';
part 'show_tanslate_state.dart';

class ShowTranslateBloc extends Bloc<ShowTranslateEvent, ShowTranslateState> {
  ShowTranslateBloc() : super(const ShowTranslateInitial()) {
    on<ShowingEvent>((event, emit) async {
      emit(ShowingState(event.value));
    });
  }
}
