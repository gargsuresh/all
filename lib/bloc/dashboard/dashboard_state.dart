abstract class DashboardState {}

class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final List<Map<String, String>> cards;
  final String mid;
  final String cmid;
  final String marketName;

  DashboardLoaded({
    required this.cards,
    required this.mid,
    required this.cmid,
    required this.marketName,
  });
}
class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
