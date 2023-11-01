import 'package:flutter/material.dart';
import 'drawer_page.dart';

class Experience_Provider_Profile_Upgrading extends StatelessWidget {
  final String role;

  Experience_Provider_Profile_Upgrading({required this.role});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requests = [
      {
        'user': 'User 1',
        'NIC': '123456789X',
        'SLTDA Copy': 'SLTDA Copy URL',
        'languages': 'English, Sinhala, Tamil',
        'trips': 10,
        'price': '100 USD',
        'address': '123 Main St, City',
      },
      {
        'user': 'User 2',
        'NIC': '987654321Y',
        'SLTDA Copy': 'SLTDA Copy URL',
        'languages': 'English, Sinhala',
        'trips': 5,
        'price': '80 USD',
        'address': '456 Elm St, Town',
      },
      // Add more requests as needed
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        dataRowHeight: 110, // Adjust as needed
        columns: [
          DataColumn(label: Text('User Name')),
          DataColumn(label: Text('NIC / SLTDA Copy')),
          DataColumn(label: Text('Languages')),
          DataColumn(label: Text('No of Trips')),
          DataColumn(label: Text('Price per Day')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Actions')),
        ],
        rows: requests
            .map((request) => DataRow(cells: [
                  DataCell(Text('${request['user']}')),
                  DataCell(Column(
                    children: [
                      Text('NIC: ${request['NIC']}'),
                      Text('SLTDA Copy: ${request['SLTDA Copy']}'),
                    ],
                  )),
                  DataCell(Text(request['languages'])),
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
                            // Handle Reject
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
                            // Handle Accept
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
