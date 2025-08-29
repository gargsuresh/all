import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final cardItems = [
          {"title": "Single Ank", "image": "assets/icons/sing.png"},
          {"title": "Jodi", "image": "assets/icons/jodi.png"},
          {"title": "Single Patti", "image": "assets/icons/single.png"},
          {"title": "Double Patti", "image": "assets/icons/double.png"},
          {"title": "Triple Patti", "image": "assets/icons/triple.png"},
          {"title": "Half Sangam", "image": "assets/icons/half.png"},
          {"title": "Full Sangam", "image": "assets/icons/full.png"},
        ];
        emit(DashboardLoaded(
          cards: cardItems,
          mid: event.mid,
          cmid: event.cmid,
          marketName: event.marketName,
        ));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}
