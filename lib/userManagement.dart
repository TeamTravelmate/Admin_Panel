import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Data/env.dart';
import 'drawer_page.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String selectedSortOption = 'Select Sort';
  String selectedFilterOption = 'Select Filter';

  final whiteTextStyle = TextStyle(color: Color.fromARGB(255, 0, 0, 0));

  Future<List<Map>> fetchUsers() async {
    final response = await http.get(Uri.parse('$backendUrl/admin/viewUsers'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      // If the server returns a 200 OK response, parse the JSON.
      return List<Map>.generate(
        (jsonDecode(response.body)['users'].length ~/ 4),
        (index) {
          var start = index * 4;
          return {
            'id': jsonDecode(response.body)['users'][start],
            'name': jsonDecode(response.body)['users'][start + 1],
            'email': jsonDecode(response.body)['users'][start + 2],
            'account_type': jsonDecode(response.body)['users'][start + 3]
          };
        },
      );
    } else {
      // If the server returns an unexpected response, throw an exception.
      throw Exception('Failed to load users');
    }
  }

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
        padding: const EdgeInsets.only(left: 260),
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
                      'Sort by Name',
                      'Sort by Trip Count',
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
                      'Travel Guide',
                      'Service Provider',
                      'Vendor'
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
            FutureBuilder<List<Map>>(
              future: fetchUsers(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return DataTable(
                    columnSpacing: 80,
                    columns: [
                      DataColumn(
                          label: Center(
                              child: Text('User ID', style: whiteTextStyle)),
                          numeric: true),
                      DataColumn(
                          label: Center(
                              child: Text('Name', style: whiteTextStyle))),
                      DataColumn(
                          label: Center(
                              child: Text('Email', style: whiteTextStyle))),
                      DataColumn(
                          label: Center(
                              child:
                                  Text('Account Type', style: whiteTextStyle))),
                      DataColumn(
                        label: Center(
                            child: Text('Action', style: whiteTextStyle)),
                      ),
                    ],
                    rows: snapshot.data!
                        .map((user) => DataRow(cells: [
                              DataCell(Text(user['id'].toString())),
                              DataCell(Text(user['name'])),
                              DataCell(Text(user['email'])),
                              DataCell(Text(user['account_type'])),
                              DataCell(
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        )),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(100, 20)),
                                      ),
                                      onPressed: () {
                                        // View button action
                                      },
                                      icon: Icon(Icons.visibility,
                                          color: Colors.white),
                                      label: Text(
                                        'View',
                                        style: TextStyle(color: Colors.white, fontSize: 11),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        )),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(110, 20)),
                                      ),
                                      onPressed: () {
                                        _showDisableConfirmationDialog(
                                            context); // Show disable confirmation dialog
                                      },
                                      icon: Icon(Icons.block,
                                          color: Colors.white),
                                      label: Text(
                                        'Disable',
                                        style: TextStyle(color: Colors.white, fontSize: 11),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        )),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(110, 20)),
                                      ),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(
                                            context); // Show delete confirmation dialog
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.white),
                                      label: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white, fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
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
