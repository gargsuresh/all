import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
  @override
  List<Object?> get props => [];
}

class LoadWallet extends WalletEvent {}

class AddFunds extends WalletEvent {
  final int amount;
  const AddFunds(this.amount);
  @override
  List<Object?> get props => [amount];
}
