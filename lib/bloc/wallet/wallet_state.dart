import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  const WalletState();
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final String walletBalance;
  const WalletLoaded({required this.walletBalance});
  @override
  List<Object?> get props => [walletBalance];
}

class WalletError extends WalletState {
  final String message;
  const WalletError({required this.message});
  @override
  List<Object?> get props => [message];
}
