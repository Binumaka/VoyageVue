import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetBookingScreen extends StatefulWidget {
  final String userId;

  const GetBookingScreen({
    super.key,
    required this.userId,
  });

  @override
  State<GetBookingScreen> createState() => _GetBookingScreenState();
}

class _GetBookingScreenState extends State<GetBookingScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  late List<dynamic> _bookingData;

  @override
  void initState() {
    super.initState();
    _fetchBookingData();
  }

  // Helper method to build the image URL
  String _buildImageUrl(String imagePath) {
    const String baseUrl = 'http://192.168.1.69:3000/uploads/';
    return baseUrl + imagePath;
  }

  // Fetch booking data from the API
  Future<void> _fetchBookingData() async {
    final url =
        'http://192.168.1.69:3000/api/booking/user/67c418a5a44c11bcee0a4b4b';
    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _bookingData = json.decode(
              response.body); // Assuming the response is an array of bookings
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        print('Error: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Details")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: const Text("Error fetching booking data"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _bookingData.isEmpty
                      ? const Center(child: Text("No bookings found."))
                      : ListView.builder(
                          itemCount: _bookingData.length,
                          itemBuilder: (context, index) {
                            final booking = _bookingData[index];
                            final imagePath =
                                booking['accommodationId']['image'] ?? '';
                            final imageUrl = imagePath.isNotEmpty
                                ? _buildImageUrl(imagePath)
                                : '';

                            return Card(
                              elevation: 4.0,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image Display
                                    imageUrl.isNotEmpty
                                        ? Image.network(
                                            imageUrl,
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 200,
                                            color: Colors.grey[
                                                300], // Placeholder for missing images
                                            child: const Center(
                                                child:
                                                    Text('No Image Available')),
                                          ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Destination: ${booking['destinationId']['title']}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        "Check-inDate: ${booking['checkInDate']}"),
                                    Text(
                                        "Check-outDate: ${booking['checkOutDate']}"),
                                    Text(
                                        "Total Price: \$${booking['totalPrice']}"),
                                    Text(
                                        "Accommodation: ${booking['accommodationId']['title']}"),
                                    Text(
                                        "Guide: ${booking['guideId']['name']}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
    );
  }
}
