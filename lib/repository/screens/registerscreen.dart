import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/constants/appcolors.dart';
import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_event.dart';
import '../../bloc/register/register_state.dart';
import '../widgets/uihelper.dart';
import 'loginscreen.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var referralController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Appcolors.scaffoldbackground,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                      width: 200, height: 200, child: Image.asset('assets/images/all.png')),
                ),
                UiHelper.CustomText(
                  text: "SIGN UP",
                  color: Color(0XFF000000),
                  fontweight: FontWeight.bold,
                  fontsize: 40,
                  fontfamily: "bold",
                ),
                UiHelper.CustomText(
                  text: "Create Your New Account",
                  color: Color(0XFF000000),
                  fontweight: FontWeight.normal,
                  fontsize: 20,
                  fontfamily: "bold",
                ),
                SizedBox(height: 20),

                // ==== Registration Form ====
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFFFFDE59),
                    ),
                    child: BlocConsumer<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        } else if (state is RegisterSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Registered Successfully")),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Loginscreen()),
                          );
                        }
                      },
                      builder: (context, state) {
                        bool isLoading = state is RegisterLoading;

                        return Column(
                          children: [
                            TextField(
                              controller: firstNameController,
                              decoration: InputDecoration(labelText: "Enter the first name",border: OutlineInputBorder(),),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: lastNameController,
                              decoration: InputDecoration(labelText: "Enter the last name",border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(labelText: "Enter the mobile number",border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: passController,
                              obscureText: true,
                              decoration: InputDecoration(labelText: "Password",border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: confirmPassController,
                              obscureText: true,
                              decoration: InputDecoration(labelText: "Confirm Password",border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: referralController,
                              decoration: InputDecoration(labelText: "Referral Code (Optional)",border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 20),

                            isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                              onPressed: () {
                                String fname = firstNameController.text.trim();
                                String lname = lastNameController.text.trim();
                                String mobile = mobileController.text.trim();
                                String pass = passController.text.trim();
                                String cpass = confirmPassController.text.trim();
                                String referral = referralController.text.trim();

                                if (fname.isEmpty || lname.isEmpty || mobile.isEmpty || pass.isEmpty || cpass.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Please fill all required fields")),
                                  );
                                  return;
                                }

                                if (pass != cpass) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Passwords do not match")),
                                  );
                                  return;
                                }

                                BlocProvider.of<RegisterBloc>(context).add(
                                  RegisterButtonPressed(
                                    fname: fname,
                                    lname: lname,
                                    mobile: mobile,
                                    password: pass,
                                    referral: referral,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                minimumSize: Size(250, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 20, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Already Have an Account?"),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Loginscreen()),
                                );
                              },
                              child: Text("Log in"),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
