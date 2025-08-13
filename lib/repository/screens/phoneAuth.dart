import 'package:all/repository/screens/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/constants/appcolors.dart';
import '../widgets/uihelper.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.scaffoldbackground,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              UiHelper.CustomImage(img: "all.png"),
              SizedBox(height: 10),
              UiHelper.CustomText(
                text: "ENTER NUMBER",
                color: Color(0XFF000000),
                fontweight: FontWeight.bold,
                fontsize: 40,
                fontfamily: "bold",
              ),
              UiHelper.CustomText(
                text: "Enter your valid mobile number",
                color: Color(0XFF000000),
                fontweight: FontWeight.normal,
                fontsize: 20,
                fontfamily: "bold",
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFFFFDE59),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly,
                              // ],
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: Icon(Icons.phone),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                border: OutlineInputBorder(),
                                label: Center(
                                  child: Text(
                                    "Enter The Phone Number",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                minimumSize: Size(250, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.verifyPhoneNumber(

                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException ex) {},
                                  codeSent:
                                      (
                                        String verificationid,
                                        int? resendtoken,
                                      ) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen(verificationId: verificationid,)));
                                      },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                  phoneNumber: "+91,$phoneController.text.toString()",
                                );
                              },
                              child: Text(
                                "Get OTP",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
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
