import 'package:flutter_bloc/flutter_bloc.dart';
import 'withdraw_event.dart';
import 'withdraw_state.dart';
import '../../utils/api_helper.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  WithdrawBloc() : super(WithdrawInitial()) {
    on<LoadWalletBalance>(_onLoadWalletBalance);
    on<WithdrawAmount>(_onWithdrawAmount);
  }

  Future<void> _onLoadWalletBalance(
      LoadWalletBalance event, Emitter<WithdrawState> emit) async {
    emit(WithdrawLoading());
    try {
      final balance = await ApiHelper.getWalletBalance();
      emit(WithdrawLoaded(walletBalance: balance));
    } catch (e) {
      emit(WithdrawFailure(message: e.toString()));
    }
  }

  Future<void> _onWithdrawAmount(
      WithdrawAmount event, Emitter<WithdrawState> emit) async {
    emit(WithdrawLoading());
    try {
      final success = await ApiHelper.withdrawFunds(event.amount);
      if (success) {
        final balance = await ApiHelper.getWalletBalance();
        emit(WithdrawLoaded(walletBalance: balance));
        emit(WithdrawSuccess());
      } else {
        emit(WithdrawFailure(message: "Withdrawal failed"));
      }
    } catch (e) {
      emit(WithdrawFailure(message: e.toString()));
    }
  }
}
