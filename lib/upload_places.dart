import 'package:flutter/material.dart';

import 'drawer_page.dart';

class UploadPlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Places'),
        centerTitle: true, // Center the title horizontally
      ),
      drawer: DrawerPage(),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          PlaceCard(
            cardWidth: 100, // Adjust card width as needed
            cardHeight: 150, // Adjust card height as needed
            imageUrl: 'url_to_image',
            placeName: 'Place Name 1',
            locationName: 'Location Name 1',
            rating: 4.5,
          ),
          SizedBox(
            height: 20,
          ),
          PlaceCard(
            cardWidth: 300, // Adjust card width as needed
            cardHeight: 150, // Adjust card height as needed
            imageUrl: 'url_to_image',
            placeName: 'Place Name 2',
            locationName: 'Location Name 2',
            rating: 3.8,
          ),
          // Add more PlaceCard widgets here
        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final String imageUrl;
  final String placeName;
  final String locationName;
  final double rating;

  PlaceCard({
    required this.cardWidth,
    required this.cardHeight,
    required this.imageUrl,
    required this.placeName,
    required this.locationName,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Handle card click
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: EdgeInsets.all(16.0),
          // ... rest of the card content ...
        ),
      ),
    );
  }
}
