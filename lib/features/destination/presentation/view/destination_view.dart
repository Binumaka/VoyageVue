import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
import 'package:voyagevue/features/destination/presentation/view/category_view.dart';
import 'package:voyagevue/features/destination/presentation/view/destination_details.dart';
import 'package:voyagevue/features/destination/presentation/view_model/bloc/destination_bloc.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({super.key});

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  final List<String> categories = [
    "HimalayanTreks",
    "Cultural Heritage",
    "city",
    "Lake and River",
    "National park",
    "Wild Life",
    "Temple And Monastries",
    "Nature",
    "Adventure",
    "Camping",
    "Festival And Event"
  ];

  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  static const double shakeThreshold = 20.0;
  AccelerometerEvent? _lastEvent;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _initializeShakeDetection();
  }

  void _initializeShakeDetection() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      if (_lastEvent != null) {
        double deltaX = (event.x - _lastEvent!.x).abs();
        double deltaY = (event.y - _lastEvent!.y).abs();
        double deltaZ = (event.z - _lastEvent!.z).abs();

        if ((deltaX + deltaY + deltaZ) > shakeThreshold) {
          _loadInitialData();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Refreshed due to shake!"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
      _lastEvent = event;
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _loadInitialData() {
    Future.microtask(() {
      final bloc = context.read<DestinationBloc>();
      bloc.add(const LoadSectionEvent("TopDestination"));
      bloc.add(const LoadSectionEvent("MoretoExplore"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<DestinationBloc, DestinationState>(
          listener: (context, state) {
            if (state.error.isNotEmpty) {
              context.read<DestinationBloc>().add(ClearErrorEvent());
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async {
                _loadInitialData();
                // Add a delay to give time for the refresh to be visually apparent
                return Future.delayed(const Duration(milliseconds: 800));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategorySection(),
                    const SizedBox(height: 24),
                    _buildTopDestinationSection(state),
                    const SizedBox(height: 24),
                    _buildMoretoExploreSection(state),
                    const SizedBox(height: 50), // Bottom padding
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Builds the category section
  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      final category = categories[index];
                      context
                          .read<DestinationBloc>()
                          .add(LoadCategoryEvent(category));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryDestinationsPage(category: category),
                        ),
                      );
                    },
                    child: _buildCategoryCard(categories[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Builds the Top Destination section with case-insensitive comparison
  Widget _buildTopDestinationSection(DestinationState state) {
    // Filter destinations case-insensitively to avoid missing data
    List<DestinationEntity> topDestinations = state.section
        .where((destination) =>
            destination.section.toLowerCase() == "topdestination".toLowerCase())
        .toList();

    return _buildHorizontalDestinationList(
      "Top Destinations",
      topDestinations,
    );
  }

  // Builds the More to Explore section with case-insensitive comparison
  Widget _buildMoretoExploreSection(DestinationState state) {
    // Filter destinations case-insensitively to avoid missing data
    List<DestinationEntity> moreToExplore = state.section
        .where((destination) =>
            destination.section.toLowerCase() == "moretoexplore".toLowerCase())
        .toList();

    return _buildHorizontalDestinationList(
      "More to Explore",
      moreToExplore,
    );
  }

  // Improved display for destinations with null safety and proper item display
  Widget _buildHorizontalDestinationList(
      String title, List<DestinationEntity> destinations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          destinations.isEmpty
              ? Container(
                  height: 170,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.terrain, size: 40, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        "No destinations available",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: destinations.length,
                    itemBuilder: (context, index) {
                      final destination = destinations[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            // Fixed navigation to details page
                            if (destination.id != null) {
                              // Load the destination details
                              context.read<DestinationBloc>().add(
                                  LoadDestinationByIdEvent(destination.id!));

                              // Navigate to the details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DestinationDetailView(
                                    destinationId: destination.id!,
                                    destination: destination,
                                  ),
                                ),
                              );
                            }
                          },
                          child: _buildDestinationCard(destination),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  // Redesigned category button with better visual style
  Widget _buildCategoryCard(String categoryTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 97, 154, 254),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 97, 154, 254).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          categoryTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Enhanced destination card with improved design
  Widget _buildDestinationCard(DestinationEntity destination) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with improved rounded corners
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 165,
              width: 180,
              color: Colors.grey[200],
              child: _buildDestinationImage(destination),
            ),
          ),
          // Title with improved typography
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Add location if available
                if (destination.location.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          destination.location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationImage(DestinationEntity destination) {
    // Check if image is null or empty
    if (destination.image.isEmpty) {
      return const Center(
        child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
      );
    }

    final imageUrl = _buildImageUrl(destination.image);

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 30, color: Colors.red),
                const SizedBox(height: 8),
                Text(
                  "Image unavailable",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: const Color.fromARGB(255, 97, 154, 254),
              ),
            );
          },
        ),
        // Add a subtle gradient overlay for better text readability if needed
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _buildImageUrl(String imagePath) {
    // Consider making this configurable or getting from environment
    const String baseUrl = 'http://192.168.1.69:3000/destinations_image/';
    return baseUrl + imagePath;
  }
}
