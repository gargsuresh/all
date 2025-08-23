import 'package:all/repository/screens/gamerate.dart';
import 'package:all/repository/screens/logoutscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}
class _NavbarState extends State<Navbar> {
  String userName = "";
  String userPhone = "";
  String userEmail = "";
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final fullName = prefs.getString('full_name') ??
        '${prefs.getString('fname') ?? ''} ${prefs.getString('lname') ?? ''}'.trim();
    setState(() {
      userName = (fullName.isEmpty) ? "Guest User" : fullName;
      userPhone = prefs.getString('mobile') ?? "";
      userEmail = prefs.getString('email') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange.shade100,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userPhone.isNotEmpty ? userPhone : userEmail),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/profile.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.orange,
              image: DecorationImage(
                image: AssetImage("assets/images/all.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            children: [
              ListTile(
              leading: Icon(Icons.star_border_outlined),
              title: Text("Game Rate"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Gamerate()));
              },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text("Term & Condition"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.circle_outlined),
            title: Text("Chart"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.circle_notifications),
            title: Text("Notification"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.lock_open_outlined),
            title: Text("Change Password"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text("Update Pin"),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LogoutPage()));
            },
          ),
        ],
      ),
    );
  }
}


