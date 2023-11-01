import 'package:flutter/material.dart';
import 'drawer_page.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String selectedSortOption = 'Select Sort';
  String selectedFilterOption = 'Select Filter';

  final whiteTextStyle = TextStyle(color: Color.fromARGB(255, 0, 0, 0));

  // Function to show the confirmation dialog for "Delete" action
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete this account?"),
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
                // Handle the "Delete" action here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show the confirmation dialog for "Disable" action
  void _showDisableConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to disable this account?"),
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
                // Handle the "Disable" action here
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Management'),
        centerTitle: true,
      ),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.only(left: 320),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Text('Sort By:', style: whiteTextStyle),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: selectedSortOption,
                    items: <String>[
                      'Select Sort',
                      'Sort Option 1',
                      'Sort Option 2',
                      'Sort Option 3'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: whiteTextStyle,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSortOption = newValue ?? 'Default Sort';
                      });
                      // Handle sorting based on selectedSortOption
                    },
                  ),
                ),
                SizedBox(width: 20),
                Text('Filter By:', style: whiteTextStyle),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: selectedFilterOption,
                    items: <String>[
                      'Select Filter',
                      'Filter Option 1',
                      'Filter Option 2',
                      'Filter Option 3'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: whiteTextStyle,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilterOption = newValue ?? 'Default Filter';
                      });
                      // Handle filtering based on selectedFilterOption
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            DataTable(
              columnSpacing: 100,
              columns: [
                DataColumn(
                    label:
                        Center(child: Text('User ID', style: whiteTextStyle)),
                    numeric: true),
                DataColumn(
                    label: Center(child: Text('Name', style: whiteTextStyle))),
                DataColumn(
                    label:
                        Center(child: Text('Location', style: whiteTextStyle))),
                DataColumn(
                    label: Center(
                        child: Text('Account Type', style: whiteTextStyle))),
                DataColumn(
                  label: Center(child: Text('Action', style: whiteTextStyle)),
                ),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1', style: whiteTextStyle)),
                  DataCell(Text('John Doe', style: whiteTextStyle)),
                  DataCell(Text('New York', style: whiteTextStyle)),
                  DataCell(Text('Free', style: whiteTextStyle)),
                  DataCell(
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                            fixedSize: MaterialStateProperty.all(Size(150, 20)),
                          ),
                          onPressed: () {
                            // View button action
                          },
                          icon: Icon(Icons.visibility, color: Colors.white),
                          label: Text(
                            'View',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                            fixedSize: MaterialStateProperty.all(Size(150, 20)),
                          ),
                          onPressed: () {
                            _showDisableConfirmationDialog(
                                context); // Show disable confirmation dialog
                          },
                          icon: Icon(Icons.block, color: Colors.white),
                          label: Text(
                            'Disable',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                            fixedSize: MaterialStateProperty.all(Size(150, 20)),
                          ),
                          onPressed: () {
                            _showDeleteConfirmationDialog(
                                context); // Show delete confirmation dialog
                          },
                          icon: Icon(Icons.delete, color: Colors.white),
                          label: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                // Add more rows as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: UsersPage()));
}
