import 'package:flutter_bloc/flutter_bloc.dart';
import 'doublepatti_event.dart';
import 'doublepatti_state.dart';
import '../../utils/session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoublepattiBloc extends Bloc<DoublepattiEvent, DoublepattiState> {
  DoublepattiBloc() : super(DoublepattiInitial()) {
    on<LoadDoublepatti>(_onLoadDoublepatti);
    on<AddBid>(_onAddBid);
    on<RemoveBid>(_onRemoveBid);
  }

  Future<void> _onLoadDoublepatti(
      LoadDoublepatti event, Emitter<DoublepattiState> emit) async {
    emit(DoublepattiLoading());
    try {
      final wallet = await SessionManager.getWalletBalance();

      String marketName = "Unknown Market";
      final response =
      await http.get(Uri.parse("https://www.atozmatka.com/api/get_markets.php"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final marketsJson = data["markets"] as List;
        final market = marketsJson.firstWhere(
                (m) => m["mid"] == event.mid && m["cmid"] == event.cmid,
            orElse: () => null);
        if (market != null) marketName = market["name"] ?? "Unknown Market";
      }

      emit(DoublepattiLoaded(walletBalance: wallet, marketName: marketName, bids: []));
    } catch (e) {
      emit(DoublepattiError("Failed to load data"));
    }
  }

  void _onAddBid(AddBid event, Emitter<DoublepattiState> emit) {
    if (state is DoublepattiLoaded) {
      final current = state as DoublepattiLoaded;
      final updatedBids = List<Map<String, String>>.from(current.bids)
        ..add({"digit": event.digit, "points": event.points, "type": "close"});
      emit(current.copyWith(bids: updatedBids));
    }
  }

  void _onRemoveBid(RemoveBid event, Emitter<DoublepattiState> emit) {
    if (state is DoublepattiLoaded) {
      final current = state as DoublepattiLoaded;
      final updatedBids = List<Map<String, String>>.from(current.bids)
        ..removeAt(event.index);
      emit(current.copyWith(bids: updatedBids));
    }
  }
}
