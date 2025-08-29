import 'package:equatable/equatable.dart';

abstract class TriplepattiEvent extends Equatable {
  const TriplepattiEvent();

  @override
  List<Object?> get props => [];
}

class LoadTriplepatti extends TriplepattiEvent {
  final String mid;
  final String cmid;

  const LoadTriplepatti({required this.mid, required this.cmid});

  @override
  List<Object?> get props => [mid, cmid];
}

class AddBid extends TriplepattiEvent {
  final String digit;
  final String points;

  const AddBid({required this.digit, required this.points});

  @override
  List<Object?> get props => [digit, points];
}

class RemoveBid extends TriplepattiEvent {
  final int index;

  const RemoveBid({required this.index});

  @override
  List<Object?> get props => [index];
}
