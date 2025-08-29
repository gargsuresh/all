import 'package:equatable/equatable.dart';

abstract class HalfsangamState extends Equatable {
  const HalfsangamState();

  @override
  List<Object?> get props => [];
}

class HalfsangamLoading extends HalfsangamState {}

class HalfsangamLoaded extends HalfsangamState {
  final String walletBalance;
  final String marketName;
  final List<Map<String, String>> entries;

  const HalfsangamLoaded({
    required this.walletBalance,
    required this.marketName,
    required this.entries,
  });

  HalfsangamLoaded copyWith({
    String? walletBalance,
    String? marketName,
    List<Map<String, String>>? entries,
  }) {
    return HalfsangamLoaded(
      walletBalance: walletBalance ?? this.walletBalance,
      marketName: marketName ?? this.marketName,
      entries: entries ?? this.entries,
    );
  }

  @override
  List<Object?> get props => [walletBalance, marketName, entries];
}

class HalfsangamError extends HalfsangamState {
  final String message;

  const HalfsangamError(this.message);

  @override
  List<Object?> get props => [message];
}
