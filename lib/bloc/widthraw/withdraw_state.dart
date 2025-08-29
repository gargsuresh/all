import 'package:equatable/equatable.dart';

abstract class WithdrawState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WithdrawInitial extends WithdrawState {}

class WithdrawLoading extends WithdrawState {}

class WithdrawLoaded extends WithdrawState {
  final String walletBalance;

  WithdrawLoaded({required this.walletBalance});

  @override
  List<Object?> get props => [walletBalance];
}

class WithdrawSuccess extends WithdrawState {}

class WithdrawFailure extends WithdrawState {
  final String message;

  WithdrawFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
