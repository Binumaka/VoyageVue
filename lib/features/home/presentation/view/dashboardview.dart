import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:voyagevue/core/common/snackbar/my_snackbar.dart';
import 'package:voyagevue/features/home/presentation/view/bottomview/homeview.dart';
// import 'package:voyagevue/features/home/presentation/view_model/home_cubit.dart';
// import 'package:voyagevue/features/home/presentation/view_model/home_state.dart';
import 'package:voyagevue/view/bookinglistview.dart';
import 'package:voyagevue/view/bucketlistview.dart';
import 'package:voyagevue/view/profileview.dart';
import 'package:voyagevue/view/schedule.dart';

class Dashboardview extends StatelessWidget {
  Dashboardview({super.key});

//   final bool _isDarkTheme = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               // Logout code
//               showMySnackBar(
//                 context: context,
//                 message: 'Logging out...',
//                 color: Colors.red,
//               );

//                 context.read<HomeCubit>().logout(context);
//             },
//           ),
//           Switch(
//             value: _isDarkTheme,
//             onChanged: (value) {
//               // Change theme
//               // setState(() {
//               //   _isDarkTheme = value;
//               // });
//             },
//           ),
//         ],
//       ),
//       // body: _views.elementAt(_selectedIndex),
//       body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
//         return state.views.elementAt(state.selectedIndex);
//       }),
//       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           return BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.book_outlined),
//                 label: 'Bookings',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.calendar_today),
//                 label: 'Schedule',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.favorite_border),
//                 label: 'Bucket-List',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_2_outlined),
//                 label: 'Profile',
//               ),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.white,
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  final List<Widget> _bottomScreens = [
    const Homeview(),
    const Bookinglistview(),
    Schedule(),
    const Bucketlistview(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffC8C5C5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/imgvoyagevue.png",
              height: screenHeight * 0.22,
              width: screenWidth * 0.5,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return _bottomScreens[selectedIndex];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndexNotifier,
        builder: (context, selectedIndex, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 22,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.book_outlined,
                  size: 22,
                ),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  size: 22,
                ),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                  size: 22,
                ),
                label: 'Bucket-List',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                  size: 22,
                ),
                label: 'Profile',
              ),
            ],
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: const Color.fromARGB(255, 57, 57, 57),
            currentIndex: selectedIndex,
            onTap: (index) {
              _selectedIndexNotifier.value = index;
            },
          );
        },
      ),
    );
  }
}
