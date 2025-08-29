abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String fname;
  final String lname;
  final String mobile;
  final String password;
  final String referral;

  RegisterButtonPressed({
    required this.fname,
    required this.lname,
    required this.mobile,
    required this.password,
    required this.referral,
  });
}
