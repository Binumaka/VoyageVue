import 'package:flutter/material.dart';
import 'package:voyagevue/features/booking/presentation/view/getbookingby_id_view.dart';
import 'package:voyagevue/features/booking/presentation/view/schedule.dart';
import 'package:voyagevue/features/destination/presentation/view/destination_view.dart';
import 'package:voyagevue/profile/presentation/view/profileview.dart';
import 'package:voyagevue/view/bucketlistview.dart';

class Dashboardview extends StatelessWidget {
  Dashboardview({super.key});

  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0);

  final List<Widget> _bottomScreens = [
    const DestinationView(),
    const GetBookingScreen(
      userId: '67c418a5a44c11bcee0a4b4b',
    ),
    Schedule(
      userId: '67c418a5a44c11bcee0a4b4b',
    ),
    const Bucketlistview(),
    const ProfileView(),
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
