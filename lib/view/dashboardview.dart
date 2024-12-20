import 'package:flutter/material.dart';
import 'package:voyagevue/view/bookinglistview.dart';
import 'package:voyagevue/view/bucketlistview.dart';
import 'package:voyagevue/view/homeview.dart';
import 'package:voyagevue/view/profileview.dart';
import 'package:voyagevue/view/schedule.dart';

class Dashboardview extends StatefulWidget {
  const Dashboardview({super.key});

  @override
  State<Dashboardview> createState() => _DashboardviewState();
}

class _DashboardviewState extends State<Dashboardview> {
  int _selectIndex = 0;
  List<Widget> lstBottomScreen = [
    const Homeview(),
    const Bookinglistview(),
    const Schedule(),
    const Bucketlistview(),
    const Profileview(),
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
            )
          ],
        ),
        centerTitle: true,
      ),
      body: lstBottomScreen[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
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
              label: 'Bucket-List'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 22,
              ),
              label: 'Profile'),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 57, 57, 57),
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },
      ),
    );
  }
}
