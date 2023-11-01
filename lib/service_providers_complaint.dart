import 'package:flutter/material.dart';

class OrganizersTabContent extends StatefulWidget {
  const OrganizersTabContent({Key? key}) : super(key: key);

  @override
  _OrganizersTabContentState createState() => _OrganizersTabContentState();
}

class _OrganizersTabContentState extends State<OrganizersTabContent> {
  String currentSubTab = 'Experience Providers';

  void switchSubTab(String subTabTitle) {
    setState(() {
      currentSubTab = subTabTitle;
    });
  }

  // Function to show the "Take Action" confirmation dialog
  void _showTakeActionConfirmationDialog(BuildContext context, String serviceType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String confirmationMessage = "Are you sure you want to deactivate this $serviceType's account?";
        return AlertDialog(
          title: Text("Take Action Confirmation"),
          content: Text(confirmationMessage),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                // Handle the "Take Action" action here
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
    return Column(
      children: [
        SizedBox(height: 30),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 70),
              buildSubTabButton('Experience Providers'),
              buildSubTabButton('Tour Guides'),
              buildSubTabButton('Vendors'),
            ],
          ),
        ),
        Expanded(
          child: SubTabContent(subTabTitle: currentSubTab, onTakeAction: _showTakeActionConfirmationDialog),
        ),
      ],
    );
  }

  Widget buildSubTabButton(String subTabTitle) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            switchSubTab(subTabTitle);
          },
          child: Text(subTabTitle),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                currentSubTab == subTabTitle ? Colors.cyan : Colors.black),
          ),
        ),
        SizedBox(width: 70),
      ],
    );
  }
}

class SubTabContent extends StatelessWidget {
  final String subTabTitle;
  final Function(BuildContext, String) onTakeAction;

  SubTabContent({required this.subTabTitle, required this.onTakeAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Container(
                      width: 150,
                      height: 100,
                      padding: EdgeInsets.all(8),
                      child: Image.network(
                        'url_to_image',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$subTabTitle: Item $index', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 30),
                            Text(
                              'Description for $subTabTitle item $index',
                              style: TextStyle(color: Colors.black),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirmation"),
                                content: Text("Do you want to ignore this complaint?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      // Handle the "Ignore" action here
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                        child: Text('Ignore'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          onTakeAction(context, subTabTitle);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          side: BorderSide(color: Colors.white, width: 1),
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

void main() {
  runApp(MaterialApp(home: OrganizersTabContent()));
}
