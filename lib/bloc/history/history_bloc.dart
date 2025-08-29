import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/api_helper.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final ApiHelper apiHelper;

  HistoryBloc(this.apiHelper) : super(HistoryLoading()) {
    on<FetchHistoryEvent>((event, emit) async {
      emit(HistoryLoading());
      try {
        final history = await apiHelper.getHistory();
        emit(HistoryLoaded(history));
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });
  }
}
