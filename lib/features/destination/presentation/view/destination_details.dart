import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/accommodation/presentation/view/accommodationlist.dart';
import 'package:voyagevue/features/accommodation/presentation/view_model/bloc/accommodation_bloc.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/presentation/view_model/bloc/destination_bloc.dart';
import 'package:voyagevue/features/guide/presentation/view/guide_list.dart';
import 'package:voyagevue/features/guide/presentation/view_model/bloc/guide_bloc.dart';

class DestinationDetailView extends StatefulWidget {
  final String destinationId;
  final DestinationEntity destination;

  const DestinationDetailView({
    super.key,
    required this.destinationId,
    required this.destination,
  });

  @override
  _DestinationDetailViewState createState() => _DestinationDetailViewState();
}

class _DestinationDetailViewState extends State<DestinationDetailView> {
  late DestinationEntity _destination;
  String? _selectedAccommodation;
  String? _selectedGuide;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _destination = widget.destination;
    _fetchData();
  }

  void _fetchData() {
    context
        .read<DestinationBloc>()
        .add(LoadDestinationByIdEvent(widget.destinationId));
    context
        .read<AccommodationBloc>()
        .add(LoadAccommodationsByDestinationEvent(widget.destinationId));
    context.read<GuideBloc>().add(LoadAllGuideEvent());
  }

  void _onAccommodationSelected(String? accommodationId) {
    setState(() {
      _selectedAccommodation = accommodationId;
    });
  }

  void _onGuideSelected(String? guide) {
    setState(() {
      _selectedGuide = guide;
    });
  }

  void _handleBooking() {
    String message = "Booking Details:\n";
    message += "Destination: ${_destination.title}\n";
    if (_selectedAccommodation != null) {
      message += "Accommodation ID: $_selectedAccommodation\n";
    }
    if (_selectedGuide != null) {
      message += "Guide: $_selectedGuide\n";
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination.title),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 121, 147, 254),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          _buildHeaderImage(),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(),
                      _buildTabNavigation(),
                      _buildTabContent(),
                      SizedBox(height: 20),
                      _buildBookButton(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_buildImageUrl(_destination.image)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _destination.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          _destination.bestTimeToVisit,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildTabNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTabItem(Icons.travel_explore_outlined, "About", 0),
        _buildTabItem(Icons.hotel, "Accommodation", 1),
        _buildTabItem(Icons.map, "Guide", 2),
      ],
    );
  }

  Widget _buildTabItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Column(
        children: [
          Icon(icon,
              size: 30,
              color: _selectedTabIndex == index ? Colors.blue : Colors.black54),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    if (_selectedTabIndex == 1) {
      return AccommodationListView(
        onSelectAccommodation: _onAccommodationSelected,
        selectedAccommodationId: _selectedAccommodation,
      );
    } else if (_selectedTabIndex == 2) {
      return GuideListView(
        onSelectGuide: _onGuideSelected,
        selectedGuideId: _selectedGuide,
      );
    } else {
      return _buildDescriptionSection();
    }
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(_destination.description,
            style: TextStyle(fontSize: 14, color: Colors.grey[800])),
      ],
    );
  }

  Widget _buildBookButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (_selectedAccommodation != null || _selectedGuide != null)
            ? _handleBooking
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text("Book Now",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  String _buildImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return 'https://via.placeholder.com/150';
    }
    if (imagePath.startsWith('http')) return imagePath;
    return 'http://192.168.1.69:3000/destinations_image/$imagePath';
  }
}
