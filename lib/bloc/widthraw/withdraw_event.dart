import 'package:equatable/equatable.dart';

abstract class WithdrawEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWalletBalance extends WithdrawEvent {}

class WithdrawAmount extends WithdrawEvent {
  final int amount;

  WithdrawAmount(this.amount);

  @override
  List<Object?> get props => [amount];
}
