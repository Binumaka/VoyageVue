import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/guide/presentation/view_model/bloc/guide_bloc.dart';

class GuideListView extends StatelessWidget {
  final Function(String?) onSelectGuide;
  final String? selectedGuideId;

  const GuideListView({
    super.key,
    required this.onSelectGuide,
    required this.selectedGuideId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuideBloc, GuideState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error.isNotEmpty) {
          return Center(child: Text("Error: ${state.error}"));
        }
        if (state.guide.isEmpty) {
          return const Center(child: Text("No guides available."));
        }

        return Column(
          children: state.guide.map((guide) {
            final isSelected = selectedGuideId == guide.id;

            return ListTile(
              title: Text(guide.name),
              subtitle: Text("Experience: ${guide.experience} years"),
              trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blue) : null,
              onTap: () => onSelectGuide(isSelected ? null : guide.id),
            );
          }).toList(),
        );
      },
    );
  }
}
