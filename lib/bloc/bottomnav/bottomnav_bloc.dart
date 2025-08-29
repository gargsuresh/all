import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavState {
  final int currentIndex;
  BottomNavState(this.currentIndex);
}

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState(2)); // default Home index

  void updateIndex(int index) => emit(BottomNavState(index));
}
