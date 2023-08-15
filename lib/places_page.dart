import 'package:flutter/material.dart';

import 'drawer_page.dart';

class PlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        centerTitle: true,
      ),
      drawer: DrawerPage(),
      body: Container(
        margin: EdgeInsets.only(left: 400.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            _buildPlaceContainer(
              imageName: 'man.png', // Change this to your image file name
              placeName: 'Nuwara-Eliya',
              locationName: 'Nuwara-Eliya, Central Province',
            ),
            SizedBox(
              height: 20,
            ),
            _buildPlaceContainer(
              imageName: 'image2.png', // Change this to your image file name
              placeName: 'Place Name 2',
              locationName: 'Location Name 2',
            ),
            SizedBox(
              height: 20,
            ),
            _buildPlaceContainer(
              imageName: 'image3.png', // Change this to your image file name
              placeName: 'Place Name 3',
              locationName: 'Location Name 3',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceContainer({
    required String imageName,
    required String placeName,
    required String locationName,
  }) {
    return Container(
      width: 800,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                'images/$imageName', // Path to the image in the images folder
                width: 100,
                height: 125,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 100),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    locationName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.edit),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.delete),
              ElevatedButton(
                onPressed: () {
                  // Add to featured functionality here
                },
                child: Text('+ Add to Featured'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PlacesPage(),
  ));
}
