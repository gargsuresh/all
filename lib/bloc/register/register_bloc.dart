import 'package:bloc/bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());

      try {
        var url = Uri.parse("https://www.atozmatka.com/api/register.php");
        var response = await http.post(url, body: {
          "first_name": event.fname,
          "last_name": event.lname,
          "mobile": event.mobile,
          "password": event.password,
          "referral_code": event.referral,
        });

        var data = jsonDecode(response.body);
        if (data["success"] == true) {
          emit(RegisterSuccess());
        } else {
          emit(RegisterFailure(data["message"] ?? "Registration Failed"));
        }
      } catch (e) {
        emit(RegisterFailure("Error: $e"));
      }
    });
  }
}
