import 'package:flutter/material.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

  final List<Map<String, String>> categories = const [
    {
      'label': 'Himalayan\nTreks',
      'image': 'assets/images/himalayan.png',
    },
    {
      'label': 'Culture\nHeritage',
      'image': 'assets/images/culture.png',
    },
    {
      'label': 'Lake And\nRivers',
      'image': 'assets/images/lake.png',
    },
    {
      'label': 'Festival And\nEvents',
      'image': 'assets/images/festival.png',
    },
    {
      'label': 'WildLife',
      'image': 'assets/images/wildlife.png',
    },
  ];

  final List<Map<String, String>> topDestinations = const [
    {
      'name': 'Mt. Everest',
      'image': 'assets/images/himalayan.png',
    },
    {
      'name': 'Pashupathinath\nTemple',
      'image': 'assets/images/culture.png',
    },
    {
      'name': 'Bhaktapur\nSquare',
      'image': 'assets/images/bhaktapur.png',
    },
  ];

  final List<Map<String, String>> moreToExplore = const [
    {
      'name': 'Mt. Annapurna',
      'image': 'assets/images/annapurna.png',
    },
    {
      'name': 'Chitwan',
      'image': 'assets/images/wildlife.png',
    },
    {
      'name': 'Muktinath Temple',
      'image': 'assets/images/temple.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xffC8C5C5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: 1,
                  left: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 235, 235),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search destinations',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 120, 118, 118)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Destinations',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Rest of your content remains the same
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: List.generate(
                          categories.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 14),
                            child: Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                    image: DecorationImage(
                                      image: AssetImage(
                                          categories[index]['image']!),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.10),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    categories[index]['label']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Top Destinations Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Top Destination',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: List.generate(
                          topDestinations.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 170,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(
                                    topDestinations[index]['image']!),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topDestinations[index]['name']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // More To Explore Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'More To Explore',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: List.generate(
                          moreToExplore.length,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 16),
                            width: 170,
                            height: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    AssetImage(moreToExplore[index]['image']!),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  moreToExplore[index]['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
