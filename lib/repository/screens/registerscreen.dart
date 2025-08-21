import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../domain/constants/appcolors.dart';
import '../widgets/uihelper.dart';
import 'loginscreen.dart';

class Registerscreen extends StatefulWidget {
  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var referralController = TextEditingController();

  Future<void> registerUser() async {
    String fname = firstNameController.text.trim();
    String lname = lastNameController.text.trim();
    String mobile = mobileController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String cpass = confirmPassController.text.trim();
    String referral = referralController.text.trim();

    print("fname: $fname, lname: $lname, mobile: $mobile, email: $email, pass: $pass, cpass: $cpass");

    if (fname.isEmpty ||
        lname.isEmpty ||
        mobile.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        cpass.isEmpty) {
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

    try {
      var url = Uri.parse("https://atozmatka.com/api/register.php");
      var response = await http.post(url, body: {
        "first_name": fname,
        "last_name": lname,
        "mobile": mobile,
        "email": email,
        "password": pass,
        "referral_code": referral,
      });

      print("API Response: ${response.body}");

      var data = jsonDecode(response.body);
      if (data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Register Successfully")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Registration Failed")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 700,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFFFFDE59),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(labelText: "Enter the first name"),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(labelText: "Enter the last name"),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: "Enter the mobile number"),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: confirmPassController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Confirm Password"),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: referralController,
                        decoration: InputDecoration(labelText: "Referral Code (Optional)"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: registerUser,
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
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Loginscreen()),
                          );
                        },
                        child: Text("Log in"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
