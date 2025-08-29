import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_helper.dart';
import 'triplepatti_event.dart';
import 'triplepatti_state.dart';

class TriplepattiBloc extends Bloc<TriplepattiEvent, TriplepattiState> {
  TriplepattiBloc() : super(TriplepattiLoading()) {
    on<LoadTriplepatti>(_onLoadTriplepatti);
    on<AddBid>(_onAddBid);
    on<RemoveBid>(_onRemoveBid);
  }

  Future<void> _onLoadTriplepatti(
      LoadTriplepatti event, Emitter<TriplepattiState> emit) async {
    emit(TriplepattiLoading());
    try {
      final walletBalance = await ApiHelper.getWalletBalance();
      final marketName = await ApiHelper.getMarketName(event.mid, event.cmid);

      emit(TriplepattiLoaded(
        walletBalance: walletBalance,
        marketName: marketName,
        bids: [],
      ));
    } catch (e) {
      emit(TriplepattiError("Failed to load data"));
    }
  }

  void _onAddBid(AddBid event, Emitter<TriplepattiState> emit) {
    if (state is TriplepattiLoaded) {
      final currentState = state as TriplepattiLoaded;
      final updatedBids = List<Map<String, String>>.from(currentState.bids)
        ..add({"digit": event.digit, "points": event.points, "type": "close"});

      emit(currentState.copyWith(bids: updatedBids));
    }
  }

  void _onRemoveBid(RemoveBid event, Emitter<TriplepattiState> emit) {
    if (state is TriplepattiLoaded) {
      final currentState = state as TriplepattiLoaded;
      final updatedBids = List<Map<String, String>>.from(currentState.bids)
        ..removeAt(event.index);

      emit(currentState.copyWith(bids: updatedBids));
    }
  }
}
