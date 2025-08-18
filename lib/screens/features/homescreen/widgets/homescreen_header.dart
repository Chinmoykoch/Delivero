import 'package:delivero/utils/location-services.dart';
import 'package:delivero/utils/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenHeader extends StatefulWidget {
  const HomeScreenHeader({super.key});

  @override
  State<HomeScreenHeader> createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top * 0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.home_filled, size: 24, color: Color(0xFF00936D)),
                  const SizedBox(width: 5),
                  Text(
                    "Home",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: LocationServices.getOrFetchLocationDisplay(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 100,
                        height: 16,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white24,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Row(
                      children: [
                        Text(
                          'Location unavailable',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            await PermissionHandler.requestLocationPermission(
                              context,
                            );
                            // Refresh the location display
                            setState(() {});
                          },
                          child: Icon(
                            Icons.location_on,
                            size: 16,
                            color: Color(0xFF00936D),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      snapshot.data ?? 'Location unavailable',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),

          // Profile Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                size: 30,
                color: Color(0xFF00936D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
