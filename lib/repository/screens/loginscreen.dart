import 'package:all/repository/screens/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../domain/constants/appcolors.dart';
import '../widgets/uihelper.dart';
import 'bottomnavscreen.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Appcolors.scaffoldbackground,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavscreen()));
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state is LoginLoading;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    UiHelper.CustomImage(img: "all.png"),
                    SizedBox(height: 10),
                    UiHelper.CustomText(
                      text: "LOGIN",
                      color: Colors.black,
                      fontweight: FontWeight.bold,
                      fontsize: 40,
                      fontfamily: "bold",
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0XFFFFDE59),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20),
                            isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                minimumSize: Size(250, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                        phone:
                                        phoneController.text.trim(),
                                        password:
                                        passController.text.trim()));
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Don't Have an Account?"),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Registerscreen(),
                                  ),
                                );
                              },
                              child: Text("Register"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
