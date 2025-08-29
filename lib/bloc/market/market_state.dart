part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class MarketInitial extends MarketState {}

class MarketLoading extends MarketState {}

class MarketLoaded extends MarketState {
  final List<Market> markets;
  const MarketLoaded({required this.markets});

  @override
  List<Object> get props => [markets];
}

class MarketError extends MarketState {
  final String message;
  const MarketError({required this.message});

  @override
  List<Object> get props => [message];
}
