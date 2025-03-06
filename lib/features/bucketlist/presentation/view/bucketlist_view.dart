// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart'
//     show SharedPreferences;
// import 'package:voyagevue/features/booking/presentation/view/get_booking.dart';
// import 'package:voyagevue/features/bucketlist/data/repository/bucketlist_remote_repository.dart/bucketlist_remote_repository.dart';
// import 'package:voyagevue/features/bucketlist/presentation/widget/bucketlist_list.dart';
// import 'package:voyagevue/features/dashboard/presentation/view/dashboardview.dart';
// import 'package:voyagevue/features/destination/data/model/destination_api_model.dart';
// import 'package:voyagevue/features/destination/presentation/view/destination_view.dart';
// import 'package:voyagevue/profile/data/data_source/profile_remote_datasource.dart';
// import 'package:voyagevue/profile/data/repository/profile_remote_data_source.dart';
// import 'package:voyagevue/profile/domain/usecase/fetch_users_usecase.dart';
// import 'package:voyagevue/profile/presentation/view/profileview.dart';

// class BucketlistView extends StatefulWidget {
//   const BucketlistView(
//       {super.key,
//       required List<DestinationApiModel> favoriteDestiantion,
//       required BucketlistRemoteRepository bucketlistRepository,
//       required String username});

//   @override
//   _GetBucketlistState createState() => _GetBucketlistState();
// }

// class _GetBucketlistState extends State<BucketlistView> {
//   int _selectedIndex = 1;

//   Future<void> _onItemTapped(int index) async {
//     setState(() {
//       _selectedIndex = index;
//     });

//     if (index == 0) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => const DestinationView()));
//     } else if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const GetBooking()),
//       );
//     } else if (index == 3) {
//       final dio = Dio();
    
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('My Bucketlist'),
//         ),
//         body: const BucketList(),
//         bottomNavigationBar: Dashboardview(
//         ));
//   }
// }
