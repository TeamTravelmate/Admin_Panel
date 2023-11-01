import 'package:flutter/material.dart';
import 'drawer_page.dart';
import 'service_providers_complaint.dart';
import 'posts_complaint.dart';
import 'comments_complaint.dart';
import 'users_complaint.dart';
import 'trip_organizers_complaint.dart';

void main() {
  runApp(MaterialApp(home: ComplaintsPage()));
}

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Complaints'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Container(
              padding: EdgeInsets.only(left: 320),
              child: TabBar(
                tabs: [
                  Tab(text: 'Posts'),
                  Tab(text: 'Comments'),
                  Tab(text: 'Users'),
                  Tab(text: 'System'),
                  Tab(text: 'Trip Organizers'),
                  // Tab(text: 'More'),
                ],
              ),
            ),
          ),
        ),
        drawer: DrawerPage(),
        body: TabBarView(
          children: [
            PostsComplaint(),
            CommentsComplaint(),
            UsersComplaint(),
            Trip_organizers_Complaint(),
            OrganizersTabContent(),
            // PlaceholderWidget(),
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Placeholder for future tabs'),
    );
  }
}
