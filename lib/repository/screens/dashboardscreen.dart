import 'package:all/repository/screens/doublepatti.dart';
import 'package:all/repository/screens/fullsangam.dart';
import 'package:all/repository/screens/halfsangam.dart';
import 'package:all/repository/screens/singleank.dart';
import 'package:all/repository/screens/singlepatti.dart';
import 'package:all/repository/screens/triplepatti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';
import '../../bloc/dashboard/dashboard_state.dart';
import 'jodi.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final cardItems = [
          {"title": "Single Ank", "image": "assets/icons/sing.png"},
          {"title": "Jodi", "image": "assets/icons/jodi.png"},
          {"title": "Single Patti", "image": "assets/icons/single.png"},
          {"title": "Double Patti", "image": "assets/icons/double.png"},
          {"title": "Triple Patti", "image": "assets/icons/triple.png"},
          {"title": "Half Sangam", "image": "assets/icons/half.png"},
          {"title": "Full Sangam", "image": "assets/icons/full.png"},
        ];
        emit(DashboardLoaded(
          cards: cardItems,
          mid: event.mid,
          cmid: event.cmid,
          marketName: event.marketName,
        ));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}

// ====== DashboardPage ======
class DashboardPage extends StatelessWidget {
  final String mid;
  final String cmid;
  final String marketName;

  const DashboardPage({
    super.key,
    required this.mid,
    required this.cmid,
    required this.marketName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc()
        ..add(LoadDashboard(mid: mid, cmid: cmid, marketName: marketName)),
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "DASHBOARD",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DashboardLoaded) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: state.cards.length,
                  itemBuilder: (context, index) {
                    final card = state.cards[index];
                    return DashboardCard(
                      title: card["title"]!,
                      imagePath: card["image"]!,
                      onTap: () {
                        final title = card["title"]!;
                        if (title == "Single Ank") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Singleank(
                                mid: state.mid,
                                cmid: state.cmid,
                                marketName: state.marketName,
                              ),
                            ),
                          );
                        } else if (title == "Jodi") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Jodi(mid: state.mid, cmid: state.cmid),
                            ),
                          );
                        } else if (title == "Single Patti") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Singlepatti(mid: state.mid, cmid: state.cmid),
                            ),
                          );
                        } else if (title == "Double Patti") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Doublepatti(mid: state.mid, cmid: state.cmid),
                            ),
                          );
                        } else if (title == "Triple Patti") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Triplepatti(mid: state.mid, cmid: state.cmid),
                            ),
                          );
                        } else if (title == "Half Sangam") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  HalfsangamScreen(mid: state.mid, cmid: state.cmid),
                            ),
                          );
                        } else if (title == "Full Sangam") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Fullsangam(mid: state.mid, cmid: state.cmid),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              } else if (state is DashboardError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFA64D),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                imagePath,
                height: 35,
                width: 35,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
