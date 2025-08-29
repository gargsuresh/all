import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../utils/session_manager.dart';
import 'halfsangam_event.dart';
import 'halfsangam_state.dart';

class HalfsangamBloc extends Bloc<HalfsangamEvent, HalfsangamState> {
  HalfsangamBloc() : super(HalfsangamLoading()) {
    on<LoadHalfsangam>(_onLoad);
    on<AddEntry>(_onAddEntry);
    on<RemoveEntry>(_onRemoveEntry);
  }

  Future<void> _onLoad(LoadHalfsangam event, Emitter<HalfsangamState> emit) async {
    emit(HalfsangamLoading());
    try {
      // Wallet balance
      String walletBalance = await SessionManager.getWalletBalance();

      // Market name
      String marketName = "Unknown Market";
      final response = await http.get(Uri.parse("https://www.atozmatka.com/api/get_markets.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final marketsJson = data["markets"] as List;
        final market = marketsJson.firstWhere(
              (m) => m["mid"] == event.mid && m["cmid"] == event.cmid,
          orElse: () => null,
        );
        if (market != null) marketName = market["name"] ?? "Unknown Market";
      }

      emit(HalfsangamLoaded(walletBalance: walletBalance, marketName: marketName, entries: []));
    } catch (e) {
      emit(HalfsangamError("Failed to load data"));
    }
  }

  void _onAddEntry(AddEntry event, Emitter<HalfsangamState> emit) {
    if (state is HalfsangamLoaded) {
      final currentState = state as HalfsangamLoaded;
      final newEntries = List<Map<String, String>>.from(currentState.entries)
        ..add({"Sangam": event.sangam, "Points": event.points, "GameType": "open"});
      emit(currentState.copyWith(entries: newEntries));
    }
  }

  void _onRemoveEntry(RemoveEntry event, Emitter<HalfsangamState> emit) {
    if (state is HalfsangamLoaded) {
      final currentState = state as HalfsangamLoaded;
      final newEntries = List<Map<String, String>>.from(currentState.entries)
        ..removeAt(event.index);
      emit(currentState.copyWith(entries: newEntries));
    }
  }
}
