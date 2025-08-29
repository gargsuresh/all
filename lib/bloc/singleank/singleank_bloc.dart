import 'package:flutter_bloc/flutter_bloc.dart';
import 'singleank_event.dart';
import 'singleank_state.dart';
import '../../utils/api_helper.dart';

class SingleankBloc extends Bloc<SingleankEvent, SingleankState> {
  SingleankBloc() : super(SingleankLoading()) {
    on<LoadSingleank>((event, emit) async {
      emit(SingleankLoading());
      try {
        final wallet = await ApiHelper.getWalletBalance();
        final market = await ApiHelper.getMarketName(event.mid, event.cmid);
        emit(SingleankLoaded(walletBalance: wallet, marketName: market, bids: []));
      } catch (e) {
        emit(SingleankError("Failed to load data"));
      }
    });

    on<AddBid>((event, emit) {
      if (state is SingleankLoaded) {
        final currentState = state as SingleankLoaded;
        final updatedBids = List<Map<String, String>>.from(currentState.bids);
        updatedBids.add({
          "digit": event.digit,
          "points": event.points,
          "type": "close",
        });
        emit(SingleankLoaded(
          walletBalance: currentState.walletBalance,
          marketName: currentState.marketName,
          bids: updatedBids,
        ));
      }
    });

    on<RemoveBid>((event, emit) {
      if (state is SingleankLoaded) {
        final currentState = state as SingleankLoaded;
        final updatedBids = List<Map<String, String>>.from(currentState.bids);
        updatedBids.removeAt(event.index);
        emit(SingleankLoaded(
          walletBalance: currentState.walletBalance,
          marketName: currentState.marketName,
          bids: updatedBids,
        ));
      }
    });
  }
}
