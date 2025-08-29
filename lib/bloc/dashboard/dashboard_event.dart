abstract class DashboardEvent {}

class LoadDashboard extends DashboardEvent {
  final String mid;
  final String cmid;
  final String marketName;

  LoadDashboard({required this.mid, required this.cmid, required this.marketName});
}
