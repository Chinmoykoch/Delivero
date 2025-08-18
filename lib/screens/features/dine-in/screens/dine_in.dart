import 'package:delivero/screens/features/dine-in/models/restaurant-models.dart';
import 'package:delivero/screens/features/dine-in/service/restaurant-service.dart';
import 'package:delivero/screens/features/dine-in/widgets/restaurant-cards.dart';
import 'package:flutter/material.dart';

class DineInScreen extends StatefulWidget {
  const DineInScreen({super.key});

  @override
  State<DineInScreen> createState() => _DineInScreenState();
}

class _DineInScreenState extends State<DineInScreen> {
  late Future<List<RestaurantModel>> futureRestaurants;

  @override
  void initState() {
    super.initState();
    futureRestaurants = fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dine Out'),
        backgroundColor: Color(0xFFF7F7F7),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                FutureBuilder(
                  future: futureRestaurants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No restaurants found'));
                    }
                    final restaurants = snapshot.data!;
                    return ListView.separated(
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 20),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: restaurants.length,
                      itemBuilder:
                          (context, index) =>
                              ResCard(restaurant: restaurants[index]),
                    );
                  },
                ),

                // ListView.separated(
                //   separatorBuilder:
                //       (context, index) => const SizedBox(height: 20),
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: reslist.length,
                //   itemBuilder: (context, index) {
                //     return ResCard(
                //       image: reslist[index]["image"]!,
                //       name: reslist[index]["name"]!,
                //       location: reslist[index]["location"]!,
                //       rating: reslist[index]["rating"]!,
                //       distance: reslist[index]["distance"]!,
                //     );
                //   },
                // ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ClipPath(
//   clipper: TrapeziumClipper(),
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     height: 50,
//     color: Colors.teal,
//   ),
// ),
// ClipPath(
//   clipper: RoundedNotchClipper(),
//   child: Container(
//     width: 30,
//     height: 30,
//     color: Color(0xFF8B5C32),
//   ),
// ),

class RoundedNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    double radius = size.width * 0.5;

    // Start from top-left
    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width, 0);

    // Left edge
    path.lineTo(0, size.height - radius);

    // Close the path to top-left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Adjust these values to shape the trapezium
    path.moveTo(size.width * 0.2, 0); // Top-left (inward)
    path.lineTo(size.width * 0.8, 0); // Top-right (inward)
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}










// Stack(
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width * .92,
//                       height: 220,
//                       decoration: BoxDecoration(
//                         color: Color(0xFF00936D),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Column(children: [Text("data")]),
//                     ),
//                     Positioned(
//                       top: 62,
//                       left: 8,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * .88,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFFF7F7),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),