import 'package:flutter/material.dart';
import 'package:travel_mate_admin/complaints.dart';
import 'package:travel_mate_admin/notifications.dart';
import 'package:travel_mate_admin/places_page.dart';
import 'package:travel_mate_admin/featured_places_page.dart';
import 'package:travel_mate_admin/userManagement.dart';
import 'package:travel_mate_admin/responsive_layout.dart';
import 'package:travel_mate_admin/settings.dart';
import 'package:travel_mate_admin/profile_upgrading.dart';
import 'package:travel_mate_admin/upload_places.dart';
import 'package:travel_mate_admin/widget_tree.dart';
import 'package:travel_mate_admin/login.dart';

import 'constants.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class ButtonsInfo {
  String title;
  IconData icon;

  ButtonsInfo({required this.title, required this.icon});
}

class _DrawerPageState extends State<DrawerPage> {
  int _currentIndex = 0;

  List<ButtonsInfo> _buttonNames = [
    ButtonsInfo(title: "Dashboard", icon: Icons.pie_chart),
    // ButtonsInfo(title: "Places", icon: Icons.place),
    // ButtonsInfo(title: "Featured Places", icon: Icons.featured_play_list),
    // ButtonsInfo(title: "Upload Place", icon: Icons.upload),
    ButtonsInfo(title: "Users", icon: Icons.rocket_launch),
    ButtonsInfo(title: "Upgrade Profile", icon: Icons.upload),
    ButtonsInfo(title: "Complaints", icon: Icons.ad_units),
    // ButtonsInfo(title: "Notifications", icon: Icons.notifications),
    // ButtonsInfo(title: "Settings", icon: Icons.settings),
  
        ButtonsInfo(title: "Logout", icon: Icons.logout),

  ];

  List<Widget> _pages = [
    // DashboardPage(),
    WidgetTree(),
    // PlacesPage(),
    // FeaturedPlacesPage(),
    // UploadPlacePage(),
    UsersPage(),
    ProfileUpgradeRequests(),
    ComplaintsPage(),
    // NotificationsPage(),
    // SettingsPage(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: ResponsiveLayout.isComputer(context) ? 300 : null,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.kPadding),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Admin Menu",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: ResponsiveLayout.isComputer(context)
                    ? null
                    : IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
              ),
              ...List.generate(
                _buttonNames.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: index == _currentIndex
                            ? LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 12, 28, 51),
                                  Color.fromARGB(255, 47, 173, 187),
                                ],
                              )
                            : null,
                        color:
                            index == _currentIndex ? null : Colors.transparent,
                      ),
                      child: ListTile(
                        title: Text(
                          _buttonNames[index].title,
                          style: TextStyle(
                            color: index == _currentIndex
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.all(Constants.kPadding),
                          child: Icon(
                            _buttonNames[index].icon,
                            color: index == _currentIndex
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          setState(() {
                            _currentIndex = index;
                          });
                          // Navigate to the relevant page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => _pages[index]),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
