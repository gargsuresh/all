import 'package:equatable/equatable.dart';

abstract class HalfsangamEvent extends Equatable {
  const HalfsangamEvent();

  @override
  List<Object?> get props => [];
}

// Load initial data (wallet & market)
class LoadHalfsangam extends HalfsangamEvent {
  final String mid;
  final String cmid;

  const LoadHalfsangam({required this.mid, required this.cmid});

  @override
  List<Object?> get props => [mid, cmid];
}

// Add a new entry
class AddEntry extends HalfsangamEvent {
  final String sangam;
  final String points;

  const AddEntry({required this.sangam, required this.points});

  @override
  List<Object?> get props => [sangam, points];
}

// Remove entry
class RemoveEntry extends HalfsangamEvent {
  final int index;

  const RemoveEntry({required this.index});

  @override
  List<Object?> get props => [index];
}
