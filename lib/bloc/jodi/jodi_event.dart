import 'package:equatable/equatable.dart';

abstract class JodiEvent extends Equatable {
  const JodiEvent();

  @override
  List<Object> get props => [];
}

class LoadJodi extends JodiEvent {
  final String mid;
  final String cmid;

  const LoadJodi({required this.mid, required this.cmid});

  @override
  List<Object> get props => [mid, cmid];
}

class AddBid extends JodiEvent {
  final String digit;
  final String points;

  const AddBid({required this.digit, required this.points});

  @override
  List<Object> get props => [digit, points];
}

class RemoveBid extends JodiEvent {
  final int index;

  const RemoveBid({required this.index});

  @override
  List<Object> get props => [index];
}
