import 'package:all/repository/screens/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/constants/appcolors.dart';
import '../../api_service.dart';
import '../../utils/session_manager.dart';
import '../widgets/uihelper.dart';
import 'bottomnavscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  Future<void> _storeUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', int.tryParse(user['id'].toString()) ?? 0);
    await prefs.setString('fname', user['fname'] ?? '');
    await prefs.setString('lname', user['lname'] ?? '');
    await prefs.setString('mobile', user['mobile'] ?? '');
    await SessionManager.setWalletBalance(user['credit'].toString());

    // convenience: full name
    final fullName = '${user['fname'] ?? ''} ${user['lname'] ?? ''}'.trim();
    await prefs.setString('full_name', fullName);
  }



  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool isLoading = false;

  void loginUser() async {
    String phone = phoneController.text.trim();
    String password = passController.text.trim();



    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter phone and password")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });



    try {
      var response = await ApiService.login(phone, password); // call backend
      //print(" Login API Response: $response");
      if (response['success'] == true) {
        // server se aaya user object store
        await _storeUser(Map<String, dynamic>.from(response['user'] ?? {}));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? "Login failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

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
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: loginUser,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 20, color: Colors.black),
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
      ),
    );
  }
}



















//       Scaffold(
//       backgroundColor: Appcolors.scaffoldbackground,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               UiHelper.CustomImage(img: "all.png"),
//               SizedBox(height: 10),
//               UiHelper.CustomText(
//                 text: "ENTER NUMBER",
//                 color: Color(0XFF000000),
//                 fontweight: FontWeight.bold,
//                 fontsize: 40,
//                 fontfamily: "bold",
//               ),
//               UiHelper.CustomText(
//                 text: "Enter your valid mobile number",
//                 color: Color(0XFF000000),
//                 fontweight: FontWeight.normal,
//                 fontsize: 20,
//                 fontfamily: "bold",
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.only(top: 20),
//                   height: 300,
//                   width: 400,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color(0XFFFFDE59),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 350,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             TextField(
//                               controller: numberController,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly
//                               ],
//                               decoration: InputDecoration(
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: BorderSide(
//                                     color: Colors.orange,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 suffixIcon: Icon(Icons.phone),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 border: OutlineInputBorder(),
//                                 label: Center(
//                                   child: Text(
//                                     "Enter The Phone Number",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 15),
//                             ElevatedButton(
//                               onPressed: () async {
//                                 String number = numberController.text.trim();
//
//                                 if (number.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text("Enter your Phone Number")),
//                                   );
//                                 } else if (number.length != 10) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text("Enter Valid Phone Number")),
//                                   );
//                                 } else {
//                                   try {
//                                     await FirebaseAuth.instance.verifyPhoneNumber(
//                                       phoneNumber: "+91$number",
//                                       verificationCompleted: (PhoneAuthCredential credential) {},
//                                       verificationFailed: (FirebaseAuthException error) {
//                                         print("Verification failed: $error");
//                                         ScaffoldMessenger.of(context).showSnackBar(
//                                           SnackBar(content: Text(error.message ?? "Error occurred")),
//                                         );
//                                       },
//                                       codeSent: (String verificationId,int? resendtoken) {
//                                         Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => OtpScreen(
//                                               verificationId: verificationId,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       codeAutoRetrievalTimeout: (String verificationId) {},
//                                     );
//                                   } on FirebaseAuthException catch (err) {
//                                     print("FirebaseAuthException: $err");
//                                   }
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.lightBlueAccent,
//                                 minimumSize: Size(250, 50),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                               child: Text(
//                                 "Get OTP",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
