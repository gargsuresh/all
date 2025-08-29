import 'package:equatable/equatable.dart';
import '../../repository/models/models.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<StatementModel> statements;
  HistoryLoaded(this.statements);

  @override
  List<Object?> get props => [statements];
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
