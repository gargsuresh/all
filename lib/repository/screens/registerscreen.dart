import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/constants/appcolors.dart';
import '../widgets/uihelper.dart';
import 'loginscreen.dart';

class Registerscreen extends StatefulWidget {
  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {

  var emailController = TextEditingController();
  var passController = TextEditingController();

  get phoneText => null;

  get passText => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.scaffoldbackground,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Center(
              //   child: SizedBox(
              //       width: 300,
              //       height: 300,
              //       child: Image.asset('assets/images/all.png')),
              // ),
              UiHelper.CustomText(
                text: "SIGN UP",
                color: Color(0XFF000000),
                fontweight: FontWeight.bold,
                fontsize: 40,
                fontfamily: "bold",
              ),
              UiHelper.CustomText(
                text: "Create your new account",
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
                  height: 700,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0XFFFFDE59),
                  ),

                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: phoneText,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.person),
                                    onPressed: () {},
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Center(
                                    child: Text(
                                      "Enter the first name",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: passText,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.person),
                                    onPressed: () {},
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Center(
                                    child: Text(
                                      "Enter the last name",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.mail),
                                    onPressed: () {},
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Center(
                                    child: Text(
                                      "Enter the gmail",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              // TextField(
                              //   controller: passText,
                              //   decoration: InputDecoration(
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.orange,
                              //         width: 2,
                              //       ),
                              //     ),
                              //     suffixIcon: IconButton(
                              //       icon: Icon(Icons.phone_android),
                              //       onPressed: () {},
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //     border: OutlineInputBorder(),
                              //     label: Center(
                              //       child: Text(
                              //         "Enter the mobile number",
                              //         style: TextStyle(
                              //           fontSize: 15,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 15),
                              TextField(
                                controller: passController,
                                obscureText: true,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.lock),
                                    onPressed: () {},
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  label: Center(
                                    child: Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 15),
                              // TextField(
                              //   controller: passText,
                              //   obscureText: true,
                              //   obscuringCharacter: '*',
                              //   decoration: InputDecoration(
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.orange,
                              //         width: 2,
                              //       ),
                              //     ),
                              //     suffixIcon: IconButton(
                              //       icon: Icon(Icons.lock),
                              //       onPressed: () {},
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //     border: OutlineInputBorder(),
                              //     label: Center(
                              //       child: Text(
                              //         "Confirm Password",
                              //         style: TextStyle(
                              //           fontSize: 15,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 15),
                              // TextField(
                              //   controller: passText,
                              //   obscureText: true,
                              //   obscuringCharacter: '*',
                              //   decoration: InputDecoration(
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.orange,
                              //         width: 2,
                              //       ),
                              //     ),
                              //     suffixIcon: IconButton(
                              //       icon: Icon(Icons.link),
                              //       onPressed: () {},
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //       borderSide: BorderSide(
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //     border: OutlineInputBorder(),
                              //     label: Center(
                              //       child: Text(
                              //         "Enter referral code (optional)",
                              //         style: TextStyle(
                              //           fontSize: 15,
                              //           color: Colors.black,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () async {
                                  String mail = emailController.text.trim();
                                  String pass = passController.text.trim();

                                  if(mail.isEmpty || pass.isEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter the Fields")));
                                  }else{
                                    try{
                                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: pass).then((value){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Successfully")));
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Loginscreen(),
                                          ),
                                        );
                                      });

                                    }on FirebaseAuth catch(err){
                                      print(err);
                                    }

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                  minimumSize: Size(250, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                                               child: Text(
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  "Register",
                                ),
                              ),
                              SizedBox(height: 10),
                              Text("Already Have an Account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Loginscreen(),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
