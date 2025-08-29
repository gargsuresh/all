import 'package:flutter_bloc/flutter_bloc.dart';
import 'jodi_event.dart';
import 'jodi_state.dart';
import '../../utils/api_helper.dart';

class JodiBloc extends Bloc<JodiEvent, JodiState> {
  JodiBloc() : super(JodiLoading()) {
    on<LoadJodi>((event, emit) async {
      emit(JodiLoading());
      try {
        final wallet = await ApiHelper.getWalletBalance();
        final market = await ApiHelper.getMarketName(event.mid, event.cmid);
        emit(JodiLoaded(walletBalance: wallet, marketName: market, bids: []));
      } catch (e) {
        emit(JodiError("Failed to load data"));
      }
    });

    on<AddBid>((event, emit) {
      if (state is JodiLoaded) {
        final currentState = state as JodiLoaded;
        final updatedBids = List<Map<String, String>>.from(currentState.bids);
        updatedBids.add({
          "digit": event.digit,
          "points": event.points,
          "type": "close",
        });
        emit(JodiLoaded(
          walletBalance: currentState.walletBalance,
          marketName: currentState.marketName,
          bids: updatedBids,
        ));
      }
    });

    on<RemoveBid>((event, emit) {
      if (state is JodiLoaded) {
        final currentState = state as JodiLoaded;
        final updatedBids = List<Map<String, String>>.from(currentState.bids);
        updatedBids.removeAt(event.index);
        emit(JodiLoaded(
          walletBalance: currentState.walletBalance,
          marketName: currentState.marketName,
          bids: updatedBids,
        ));
      }
    });
  }
}
