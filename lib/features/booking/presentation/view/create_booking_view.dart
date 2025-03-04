// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:voyagevue/features/accommodation/domain/entity/accommodation_entity.dart';
// import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';
// import 'package:voyagevue/features/booking/domain/entity/booking_entity.dart';
// import 'package:voyagevue/features/booking/presentation/view_model/booking_bloc.dart';
// import 'package:voyagevue/features/destination/domain/entity/destination_entity.dart';
// import 'package:voyagevue/features/guide/domain/entity/guide_entity.dart';

// class CreateBookingScreen extends StatefulWidget {
//   final AuthEntity userId;
//   final DestinationEntity destination;
//   final AccommodationEntity selectedAccommodation;
//   final GuideEntity selectedGuide;
//   final DateTime checkInDate;
//   final DateTime checkOutDate;

//   const CreateBookingScreen({
//     super.key,
//     required this.userId,
//     required this.destination,
//     required this.selectedAccommodation,
//     required this.selectedGuide,
//     required this.checkInDate,
//     required this.checkOutDate,
//   });

//   @override
//   State<CreateBookingScreen> createState() => _CreateBookingScreenState();
// }

// class _CreateBookingScreenState extends State<CreateBookingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   double totalPrice = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _calculateTotalPrice();
//   }

//   void _calculateTotalPrice() {
//     int nights = widget.checkOutDate.difference(widget.checkInDate).inDays;
//     // Assuming selectedAccommodation has a price property
//     double accommodationPrice = widget.selectedAccommodation.price * nights;
//     totalPrice = accommodationPrice;
//     setState(() {});
//   }

//   void _submitBooking() {
//     if (_formKey.currentState!.validate()) {
//       final booking = BookingEntity(
//         id: '',
//         userId: widget.userId.id, // Assuming AuthEntity has an id property
//         accommodationId: widget.selectedAccommodation.id, // Assuming AccommodationEntity has an id property
//         destinationId: widget.destination.id, // Assuming DestinationEntity has an id property
//         guideId: widget.selectedGuide.id, // Assuming GuideEntity has an id property
//         checkInDate: widget.checkInDate,
//         checkOutDate: widget.checkOutDate,
//         totalPrice: totalPrice,
//       );

//       context.read<BookingBloc>().add(CreateNewBooking(booking));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Booking")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Text("Total Price: \$${totalPrice.toStringAsFixed(2)}"),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitBooking,
//                 child: const Text("Create Booking"),
//               ),
//               BlocListener<BookingBloc, BookingState>(
//                 listener: (context, state) {
//                   if (state is BookingCreated) { // Assuming there's a BookingCreated state
//                     Navigator.pushReplacementNamed(context, '/bookings');
//                     // Or use MaterialPageRoute if you prefer:
//                     // Navigator.pushReplacement(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const GetBookingScreen(),
//                     //   ),
//                     // );
//                   } else if (state is BookingError) { // Assuming there's a BookingError state
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.message)),
//                     );
//                   }
//                 },
//                 child: Container(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }