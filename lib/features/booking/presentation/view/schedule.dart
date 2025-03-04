import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class Schedule extends StatefulWidget {
  final String userId;

  const Schedule({
    super.key,
    required this.userId,
  });

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  bool _isLoading = true;
  bool _hasError = false;
  List<dynamic> _bookingData = [];

  // Calendar variables
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    _fetchBookingData();
  }

  // Helper method to build the image URL with proper encoding
  String _buildImageUrl(String imagePath) {
    const String baseUrl = 'http://192.168.1.69:3000/uploads/';
    return baseUrl + Uri.encodeComponent(imagePath);
  }

  // Fetch booking data from the API
  Future<void> _fetchBookingData() async {
    final url = 'http://192.168.1.69:3000/api/booking/user/${widget.userId}';
    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _bookingData = json.decode(response.body);
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

  // Get bookings for the selected date
  List<dynamic> _getBookingsForSelectedDay() {
    if (_bookingData.isEmpty) return [];

    return _bookingData.where((booking) {
      // Parse the check-in date from booking
      DateTime? checkInDate;
      try {
        checkInDate = DateTime.parse(booking['checkInDate']);
      } catch (e) {
        return false;
      }

      // Compare year, month, and day
      return checkInDate.year == _selectedDay.year &&
          checkInDate.month == _selectedDay.month &&
          checkInDate.day == _selectedDay.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Schedule"),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchBookingData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Error fetching booking data"),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _fetchBookingData,
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      // Calendar
                      TableCalendar(
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        eventLoader: (day) {
                          // Mark days that have bookings
                          return _bookingData.where((booking) {
                            try {
                              final checkInDate =
                                  DateTime.parse(booking['checkInDate']);
                              return isSameDay(checkInDate, day);
                            } catch (e) {
                              return false;
                            }
                          }).toList();
                        },
                        calendarStyle: const CalendarStyle(
                          markersMaxCount: 3,
                          todayDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "My Schedule",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Booking list
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _bookingData.isEmpty
                              ? const Center(child: Text("No bookings found."))
                              : ListView.builder(
                                  itemCount:
                                      _getBookingsForSelectedDay().length,
                                  itemBuilder: (context, index) {
                                    final booking =
                                        _getBookingsForSelectedDay()[index];
                                    final imagePath = booking['accommodationId']
                                            ?['image'] ??
                                        '';
                                    final imageUrl = imagePath.isNotEmpty
                                        ? _buildImageUrl(imagePath)
                                        : '';

                                    return Card(
                                      elevation: 2.0,
                                      margin:
                                          const EdgeInsets.only(bottom: 16.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // Navigate to booking details
                                        },
                                        child: Row(
                                          children: [
                                            // Thumbnail image
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                                bottomLeft:
                                                    Radius.circular(12.0),
                                              ),
                                              child: SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: imageUrl.isNotEmpty
                                                    ? Image.network(
                                                        imageUrl,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            color: Colors
                                                                .grey[300],
                                                            child: const Icon(Icons
                                                                .image_not_supported),
                                                          );
                                                        },
                                                      )
                                                    : Container(
                                                        color: Colors.grey[300],
                                                        child: const Icon(
                                                            Icons.image),
                                                      ),
                                              ),
                                            ),

                                            // Booking details
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Date
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 16,
                                                            color: Colors
                                                                .grey[600]),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          booking['checkInDate'] ??
                                                              'Unknown',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),

                                                    // Destination
                                                    Text(
                                                      booking['destinationId']
                                                              ?['title'] ??
                                                          'Unknown Destination',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),

                                                    // Location
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_on,
                                                            size: 16,
                                                            color: Colors
                                                                .grey[600]),
                                                        const SizedBox(
                                                            width: 4),
                                                        Expanded(
                                                          child: Text(
                                                            '${booking['destinationId']?['location'] ?? 'Unknown location'}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[600]),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // Navigation icon
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.chevron_right),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
