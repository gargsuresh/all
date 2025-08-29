import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/api_helper.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../utils/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      var response = await ApiHelper.login(event.phone, event.password);

      if (response['success'] == true) {
        final user = Map<String, dynamic>.from(response['user'] ?? {});
        await _storeUser(user);

        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure(response['message'] ?? "Login Failed"));
      }
    } catch (e) {
      emit(LoginFailure("Error: $e"));
    }
  }

  Future<void> _storeUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', int.tryParse(user['id'].toString()) ?? 0);
    await prefs.setString('fname', user['fname'] ?? '');
    await prefs.setString('lname', user['lname'] ?? '');
    await prefs.setString('mobile', user['mobile'] ?? '');
    await SessionManager.setWalletBalance(user['credit'].toString());

    final fullName = '${user['fname'] ?? ''} ${user['lname'] ?? ''}'.trim();
    await prefs.setString('full_name', fullName);
  }
}
