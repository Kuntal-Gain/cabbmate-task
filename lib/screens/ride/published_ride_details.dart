import 'package:cabmate_task/models/requests.dart';
import 'package:cabmate_task/service/firebase_service.dart';
import 'package:cabmate_task/utils/ride.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_format/flutter_datetime_format.dart' as fd;

class PublishedRideDetails extends StatefulWidget {
  const PublishedRideDetails({super.key, required this.ride});

  final Ride ride;

  @override
  State<PublishedRideDetails> createState() => _PublishedRideDetailsState();
}

class _PublishedRideDetailsState extends State<PublishedRideDetails> {
  List<Requests> requests = [];

  void fetchRequests() async {
    List<Requests> items = [];

    items = await FirebaseService().fetchRequests(widget.ride.rideId);

    setState(() {
      requests = items.where((item) => item.status != "rejected").toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Ride Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Documents",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      // padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // driver

                          verifyTiles('Address Proof', 0),
                          verifyTiles('Driving License', 1),
                          verifyTiles('Vehicle Document', 2),
                          verifyTiles('Vechicle Incentive', 3),

                          // phone number
                        ],
                      ),
                    ),
                  ],
                ),

                // requests section
                if (requests.isNotEmpty)
                  SizedBox(
                    height:
                        mediaQuery.height * 0.3, // or some other fixed value
                    child: ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (ctx, idx) {
                        final request = requests[idx];

                        return Container(
                          height: mediaQuery.height * 0.28,
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffc2c2c2)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    request.imageId.isNotEmpty
                                        ? Image.network(request.imageId)
                                        : Container(
                                            height: 75,
                                            width: 75,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            margin: const EdgeInsets.all(10),
                                          ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          request.passengerName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Payment Mode : ',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  )),
                                              TextSpan(
                                                  text: request.method,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const Text(
                                          'You will get credited after by admin Later',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.people),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${request.total} Passenger(s)',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '\$${request.fare}',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (request.status == "pending")
                                  const Text('Waiting for an Approval'),
                                if (request.status == "pending")
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            FirebaseService()
                                                .rejectRide(request.requestId);
                                            fetchRequests();
                                          },
                                          child: Container(
                                            height: 60,
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black45,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Decline',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            FirebaseService()
                                                .acceptRide(request.requestId);
                                            fetchRequests();
                                          },
                                          child: Container(
                                            height: 60,
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffc2c2c2),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Accept',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (request.status == "accepted")
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Ride Accepted',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (request.status == "rejected")
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Ride Rejected',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Car Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: mediaQuery.height *
                              0.25, // Fixed height based on media query
                          child: Image.network(
                            widget.ride.rideImg.isEmpty
                                ? 'https://img.freepik.com/free-vector/car-free-day-symbol-isolated-icon_18591-83177.jpg'
                                : widget.ride.rideImg,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.ride.brand,
                              style: TextStyle(
                                fontSize: mediaQuery.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.car_rental,
                                    color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  widget.ride.rideModel,
                                  style: TextStyle(
                                    fontSize: mediaQuery.width * 0.045,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.card_travel_rounded,
                                    color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  widget.ride.rideNameplate,
                                  style: TextStyle(
                                    fontSize: mediaQuery.width * 0.045,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text(
                    "Route",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    fd.FLDateTime.formatWithNames(
                        widget.ride.startTime.toDate(), 'EEE, MMMM DD, YYYY'),
                    style: const TextStyle(color: Colors.black45),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Start Location
                          Row(
                            children: [
                              const Icon(Icons.radio_button_checked,
                                  color: Colors.green),
                              const SizedBox(width: 8),
                              Text(
                                'Start Location',
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.ride.startLoc,
                            style: TextStyle(
                              fontSize: mediaQuery.width * 0.04,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${widget.ride.startTime.toDate().hour} : ${widget.ride.startTime.toDate().minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: mediaQuery.width * 0.04,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          // End Location
                          Row(
                            children: [
                              const Icon(Icons.radio_button_checked,
                                  color: Colors.red),
                              const SizedBox(width: 8),
                              Text(
                                'End Location',
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.ride.endLoc,
                            style: TextStyle(
                              fontSize: mediaQuery.width * 0.04,
                            ),
                          ),
                          const SizedBox(height: 5),

                          const SizedBox(height: 10),
                          // Ride Date and Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.ride.startTime.toDate().hour}:${widget.ride.startTime.toDate().minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.045,
                                ),
                              ),
                              Text(
                                '\$${widget.ride.price}',
                                style: TextStyle(
                                  fontSize: mediaQuery.width * 0.045,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            // Navigation Buttons
          ],
        ),
      ),
    );
  }
}

Widget verifyTiles(String type, int num) {
  return Container(
    height: 60,
    // margin: const EdgeInsets.all(5),
    width: double.infinity,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft:
              num == 0 ? const Radius.circular(16) : const Radius.circular(0),
          topRight:
              num == 0 ? const Radius.circular(16) : const Radius.circular(0),
          bottomLeft:
              num == 3 ? const Radius.circular(16) : const Radius.circular(0),
          bottomRight:
              num == 3 ? const Radius.circular(16) : const Radius.circular(0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffc2c2c2),
            spreadRadius: 2,
            blurRadius: 2,
          )
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}
