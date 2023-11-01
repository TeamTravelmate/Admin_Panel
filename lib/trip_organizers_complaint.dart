import 'package:flutter/material.dart';

class   Trip_organizers_Complaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComplaintsTab(complaintType: 'System');
  }
}

class ComplaintsTab extends StatelessWidget {
  final String complaintType;

  ComplaintsTab({required this.complaintType});

  void _showIgnoreConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ignore Confirmation'),
          content: Text('Do you want to ignore this $complaintType complaint?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Remove the complaint and close the dialog
                Navigator.of(context).pop();
                // You can add code here to remove the complaint from your data
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTakeActionConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Take Action Confirmation'),
          content: Text('Are you sure you want to deactivate this trip organizer account?'), // Customize this message for "Posts"
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Implement your take action logic here for the "Posts" complaint
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(left: 320, right: 30),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$complaintType: Item $index', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 20),
                            Text(
                              'Description for $complaintType item $index',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Report: Low Performance than expected',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showIgnoreConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          side: BorderSide(color: Colors.black, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text('Ignore'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          _showTakeActionConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 38, 37, 37),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text('Take Action'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
