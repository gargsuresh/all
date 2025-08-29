import 'package:equatable/equatable.dart';

abstract class DoublepattiState extends Equatable {
  const DoublepattiState();
  @override
  List<Object> get props => [];
}

class DoublepattiInitial extends DoublepattiState {}

class DoublepattiLoading extends DoublepattiState {}

class DoublepattiLoaded extends DoublepattiState {
  final String walletBalance;
  final String marketName;
  final List<Map<String, String>> bids;

  const DoublepattiLoaded({
    required this.walletBalance,
    required this.marketName,
    required this.bids,
  });

  DoublepattiLoaded copyWith({
    String? walletBalance,
    String? marketName,
    List<Map<String, String>>? bids,
  }) {
    return DoublepattiLoaded(
      walletBalance: walletBalance ?? this.walletBalance,
      marketName: marketName ?? this.marketName,
      bids: bids ?? this.bids,
    );
  }

  @override
  List<Object> get props => [walletBalance, marketName, bids];
}

class DoublepattiError extends DoublepattiState {
  final String message;
  const DoublepattiError(this.message);

  @override
  List<Object> get props => [message];
}
