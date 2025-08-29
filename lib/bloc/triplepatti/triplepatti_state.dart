import 'package:equatable/equatable.dart';

abstract class TriplepattiState extends Equatable {
  const TriplepattiState();

  @override
  List<Object?> get props => [];
}

class TriplepattiLoading extends TriplepattiState {}

class TriplepattiLoaded extends TriplepattiState {
  final String walletBalance;
  final String marketName;
  final List<Map<String, String>> bids;

  const TriplepattiLoaded({
    required this.walletBalance,
    required this.marketName,
    this.bids = const [],
  });

  TriplepattiLoaded copyWith({
    String? walletBalance,
    String? marketName,
    List<Map<String, String>>? bids,
  }) {
    return TriplepattiLoaded(
      walletBalance: walletBalance ?? this.walletBalance,
      marketName: marketName ?? this.marketName,
      bids: bids ?? this.bids,
    );
  }

  @override
  List<Object?> get props => [walletBalance, marketName, bids];
}

class TriplepattiError extends TriplepattiState {
  final String message;

  const TriplepattiError(this.message);

  @override
  List<Object?> get props => [message];
}
