import 'package:equatable/equatable.dart';

abstract class DoublepattiEvent extends Equatable {
  const DoublepattiEvent();
  @override
  List<Object> get props => [];
}

class LoadDoublepatti extends DoublepattiEvent {
  final String mid;
  final String cmid;
  const LoadDoublepatti({required this.mid, required this.cmid});

  @override
  List<Object> get props => [mid, cmid];
}

class AddBid extends DoublepattiEvent {
  final String digit;
  final String points;
  const AddBid({required this.digit, required this.points});

  @override
  List<Object> get props => [digit, points];
}

class RemoveBid extends DoublepattiEvent {
  final int index;
  const RemoveBid({required this.index});

  @override
  List<Object> get props => [index];
}
