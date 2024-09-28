import 'package:cabmate_task/screens/ride/rides_details.dart';
import 'package:flutter/material.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device width for responsive design
    final deviceWidth = MediaQuery.of(context).size.width;

    // Store the values in variables for easy reference
    final cardElevation = 3.0;
    final cardMargin = EdgeInsets.symmetric(vertical: 8.0);
    final borderRadiusValue = 20.0;
    final boxShadowColor = Colors.grey.shade200;
    final boxShadowSpreadRadius = 3.0;
    final boxShadowBlurRadius = 3.0;
    final containerMargin = EdgeInsets.only(left: 10, right: 10, bottom: 12);
    final cardPadding = EdgeInsets.all(5.0);
    final imageSize = deviceWidth * 0.12; // Responsive image size
    final imageRadius = 20.0;
    final fontSizeName = 16.0;
    final fontSizeRideNo = 15.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Rides',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          rideCard(
            context,
            'Emma Brown',
            'Block-A, Mondeal Square, Prahlad Nagar, Ahmedabad, Gujarat 380015, India',
            '41, Science City, Sola, Ahmedabad, Gujarat 380060, India',
            '11:00 AM',
            '11:08 AM',
            '4.00',
            'Tue, 19th Sep 23',
            deviceWidth,
            cardElevation,
            cardMargin,
            borderRadiusValue,
            boxShadowColor,
            boxShadowSpreadRadius,
            boxShadowBlurRadius,
            containerMargin,
            cardPadding,
            imageSize,
            imageRadius,
            fontSizeName,
            fontSizeRideNo,
          ),
          rideCard(
            context,
            'Robert Smith',
            'Block-A, Mondeal Square, Prahlad Nagar, Ahmedabad, Gujarat 380015, India',
            '41, Science City, Sola, Ahmedabad, Gujarat 380060, India',
            '11:00 AM',
            '11:08 AM',
            '4.00',
            'Tue, 19th Sep 23',
            deviceWidth,
            cardElevation,
            cardMargin,
            borderRadiusValue,
            boxShadowColor,
            boxShadowSpreadRadius,
            boxShadowBlurRadius,
            containerMargin,
            cardPadding,
            imageSize,
            imageRadius,
            fontSizeName,
            fontSizeRideNo,
          ),
        ],
      ),
    );
  }

  Widget rideCard(
    BuildContext context,
    String name,
    String startLocation,
    String endLocation,
    String startTime,
    String endTime,
    String fare,
    String date,
    double deviceWidth,
    double cardElevation,
    EdgeInsets cardMargin,
    double borderRadiusValue,
    Color boxShadowColor,
    double boxShadowSpreadRadius,
    double boxShadowBlurRadius,
    EdgeInsets containerMargin,
    EdgeInsets cardPadding,
    double imageSize,
    double imageRadius,
    double fontSizeName,
    double fontSizeRideNo,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RideDetailsScreen(),
          ),
        );
      },
      child: Container(
        margin: containerMargin,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: boxShadowColor,
              spreadRadius: boxShadowSpreadRadius,
              blurRadius: boxShadowBlurRadius,
            )
          ],
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        child: Card(
          elevation: cardElevation,
          margin: cardMargin,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                  child: Text(
                    'Ride No: #123456789',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSizeRideNo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(imageRadius),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          'https://i.postimg.cc/HL5ZHL9y/attractive-1869761-1280.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeName,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                locationInfo('Start Location', startLocation, startTime),
                const SizedBox(height: 10),
                locationInfo('End Location', endLocation, endTime),
                const SizedBox(height: 5),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$$fare',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 130.0),
                          child: Text(
                            'Per Passenger',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget locationInfo(String label, String location, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: Colors.green),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                location,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
