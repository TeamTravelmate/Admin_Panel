import 'package:flutter/material.dart';
import 'drawer_page.dart';

void main() {
  runApp(MaterialApp(home: ProfileUpgradeRequests()));
}

class ProfileUpgradeRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile Upgrade Requests'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Container(
              padding: EdgeInsets.only(left: 320),
              child: TabBar(
                tabs: [
                  Tab(text: 'Experience Provider'),
                  Tab(text: 'Tour Guide'),
                  // Tab(text: 'Vendor'),
                ],
              ),
            ),
          ),
        ),
        drawer: DrawerPage(),
        body: TabBarView(
          children: [
            RequestList(role: 'Experience Provider'),
            RequestList(role: 'Tour Guide'),
            // RequestList(role: 'Vendor'),
          ],
        ),
      ),
    );
  }
}

class RequestList extends StatelessWidget {
  final String role;

  RequestList({required this.role});

  void showRejectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reject Request'),
          content: Text('Are you sure you want to reject this request?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle Reject
                Navigator.of(context).pop();
              },
              child: Text('Reject'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showAcceptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Accept Request'),
          content: Text('Are you sure you want to accept this request?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle Accept
                Navigator.of(context).pop();
              },
              child: Text('Accept'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requests = [
      {
        'user': 'User 1',
        'NIC': '123456789X',
        'NIC Copy': 'NIC Copy URL',
        'SLTDA Copy': 'SLTDA Copy URL',
        'trips': 10,
        'price': '100 USD',
        'address': '123 Main St, City',
      },
      {
        'user': 'User 2',
        'NIC': '987654321Y',
        'NIC Copy': 'NIC Copy URL',
        'SLTDA Copy': 'SLTDA Copy URL',
        'trips': 5,
        'price': '80 USD',
        'address': '456 Elm St, Town',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        dataRowHeight: 110,
        columns: [
          DataColumn(label: Text('User Name')),
          DataColumn(label: Text('NIC')),
          DataColumn(label: Text('NIC Copy')),
          DataColumn(label: Text('SLTDA Copy')),
          DataColumn(label: Text('No of Trips')),
          DataColumn(label: Text('Price per Day')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Actions')),
        ],
        rows: requests
            .map((request) => DataRow(cells: [
                  DataCell(Text('${request['user']}')),
                  DataCell(Text('NIC: ${request['NIC']}')),
                  DataCell(Text('NIC Copy: ${request['NIC Copy']}')),
                  DataCell(Text('SLTDA Copy: ${request['SLTDA Copy']}')),
                  DataCell(Text(request['trips'].toString())),
                  DataCell(Text(request['price'])),
                  DataCell(Text(request['address'])),
                  DataCell(
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            showRejectDialog(context); // Show the Reject dialog
                          },
                          child: Text('Reject', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            showAcceptDialog(context); // Show the Accept dialog
                          },
                          child: Text('Accept', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ]))
            .toList(),
      ),
    );
  }
}
