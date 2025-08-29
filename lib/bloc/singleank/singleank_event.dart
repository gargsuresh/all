import 'package:equatable/equatable.dart';

abstract class SingleankEvent extends Equatable {
  const SingleankEvent();

  @override
  List<Object> get props => [];
}

class LoadSingleank extends SingleankEvent {
  final String mid;
  final String cmid;

  const LoadSingleank({required this.mid, required this.cmid});

  @override
  List<Object> get props => [mid, cmid];
}

class AddBid extends SingleankEvent {
  final String digit;
  final String points;

  const AddBid({required this.digit, required this.points});

  @override
  List<Object> get props => [digit, points];
}

class RemoveBid extends SingleankEvent {
  final int index;

  const RemoveBid({required this.index});

  @override
  List<Object> get props => [index];
}
