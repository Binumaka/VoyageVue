import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/accommodation/presentation/view_model/bloc/accommodation_bloc.dart';

class AccommodationListView extends StatelessWidget {
  final Function(String?) onSelectAccommodation;
  final String? selectedAccommodationId;

  const AccommodationListView({
    super.key,
    required this.onSelectAccommodation,
    required this.selectedAccommodationId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccommodationBloc, AccommodationState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.error.isNotEmpty) {
          return Center(child: Text("Error: ${state.error}"));
        }
        if (state.accommodationsByDestination.isEmpty) {
          return Center(child: Text("No accommodations available."));
        }

        return Column(
          children: state.accommodationsByDestination.map((accommodation) {
            final isSelected = selectedAccommodationId == accommodation.id;

            return ListTile(
              title: Text(accommodation.title),
              subtitle: Text("\$${accommodation.price.toStringAsFixed(2)} per night"),
              trailing: isSelected ? Icon(Icons.check_circle, color: Colors.blue) : null,
              onTap: () => onSelectAccommodation(isSelected ? null : accommodation.id),
            );
          }).toList(),
        );
      },
    );
  }
}
