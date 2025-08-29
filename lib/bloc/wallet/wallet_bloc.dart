import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/api_helper.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<LoadWallet>(_onLoadWallet);
    on<AddFunds>(_onAddFunds);
  }

  Future<void> _onLoadWallet(
      LoadWallet event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    try {
      final balance = await ApiHelper.getWalletBalance();
      emit(WalletLoaded(walletBalance: balance));
    } catch (e) {
      emit(WalletError(message: "Failed to load wallet balance"));
    }
  }

  Future<void> _onAddFunds(AddFunds event, Emitter<WalletState> emit) async {
    if (state is WalletLoaded) {
      final currentBalance = int.tryParse((state as WalletLoaded).walletBalance) ?? 0;
      emit(WalletLoading());
      try {
        await ApiHelper.addFunds(event.amount); // API call to add funds
        final newBalance = currentBalance + event.amount;
        emit(WalletLoaded(walletBalance: newBalance.toString()));
      } catch (e) {
        emit(WalletError(message: "Failed to add funds"));
      }
    }
  }
}
