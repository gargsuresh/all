import 'package:equatable/equatable.dart';

abstract class SingleankState extends Equatable {
  const SingleankState();

  @override
  List<Object> get props => [];
}

class SingleankLoading extends SingleankState {}

class SingleankLoaded extends SingleankState {
  final String walletBalance;
  final String marketName;
  final List<Map<String, String>> bids;

  const SingleankLoaded({
    required this.walletBalance,
    required this.marketName,
    required this.bids,
  });

  @override
  List<Object> get props => [walletBalance, marketName, bids];
}

class SingleankError extends SingleankState {
  final String message;

  const SingleankError(this.message);

  @override
  List<Object> get props => [message];
}
