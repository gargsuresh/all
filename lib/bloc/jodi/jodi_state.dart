import 'package:equatable/equatable.dart';

abstract class JodiState extends Equatable {
  const JodiState();

  @override
  List<Object> get props => [];
}

class JodiLoading extends JodiState {}

class JodiLoaded extends JodiState {
  final String walletBalance;
  final String marketName;
  final List<Map<String, String>> bids;

  const JodiLoaded({
    required this.walletBalance,
    required this.marketName,
    required this.bids,
  });

  @override
  List<Object> get props => [walletBalance, marketName, bids];
}

class JodiError extends JodiState {
  final String message;

  const JodiError(this.message);

  @override
  List<Object> get props => [message];
}
