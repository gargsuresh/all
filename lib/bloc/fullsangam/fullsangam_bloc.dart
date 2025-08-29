import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../utils/api_helper.dart';
import 'fullsangam_event.dart';
import 'fullsangam_state.dart';

class FullsangamBloc extends Bloc<FullsangamEvent, FullsangamState> {
  FullsangamBloc() : super(FullsangamInitial()) {
    on<LoadFullsangam>(_onLoadFullsangam);
    on<AddEntry>(_onAddEntry);
    on<RemoveEntry>(_onRemoveEntry);
    on<SubmitEntries>(_onSubmitEntries);
  }

  Future<void> _onLoadFullsangam(
      LoadFullsangam event, Emitter<FullsangamState> emit) async {
    emit(FullsangamLoading());
    try {
      String balance = await ApiHelper.getWalletBalance();
      emit(FullsangamLoaded(
        walletBalance: balance,
        openPannaController: TextEditingController(),
        closePannaController: TextEditingController(),
        pointsController: TextEditingController(),
        entries: [],
        totalPoints: 0,
      ));
    } catch (e) {
      emit(FullsangamError(message: "Failed to load wallet balance"));
    }
  }

  void _onAddEntry(AddEntry event, Emitter<FullsangamState> emit) {
    final state = this.state;
    if (state is FullsangamLoaded) {
      final open = state.openPannaController.text;
      final close = state.closePannaController.text;
      final points = state.pointsController.text;

      if (open.isNotEmpty && close.isNotEmpty && points.isNotEmpty) {
        final pointValue = int.tryParse(points) ?? 0;
        final newEntry = {
          "Sangam": "$open-$close",
          "Points": pointValue.toString(),
          "GameType": "open"
        };
        final updatedEntries = List<Map<String, String>>.from(state.entries)
          ..add(newEntry);

        emit(state.copyWith(
          entries: updatedEntries,
          totalPoints: updatedEntries.fold(
              0, (sum, e) => sum! + (int.tryParse(e['Points'] ?? '0') ?? 0)),
        ));

        // Clear fields
        state.openPannaController.clear();
        state.closePannaController.clear();
        state.pointsController.clear();
      }
    }
  }

  void _onRemoveEntry(RemoveEntry event, Emitter<FullsangamState> emit) {
    final state = this.state;
    if (state is FullsangamLoaded) {
      final updatedEntries = List<Map<String, String>>.from(state.entries)
        ..remove(event.entry);

      emit(state.copyWith(
        entries: updatedEntries,
        totalPoints: updatedEntries.fold(
            0, (sum, e) => sum! + (int.tryParse(e['Points'] ?? '0') ?? 0)),
      ));
    }
  }

  void _onSubmitEntries(SubmitEntries event, Emitter<FullsangamState> emit) {
    final state = this.state;
    if (state is FullsangamLoaded) {
      // API call logic here
      print(
          "Submitted ${state.entries.length} entries with total points ${state.totalPoints}");
    }
  }
}
