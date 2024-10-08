import 'package:flutter/material.dart';

class Thirdpage extends StatefulWidget {
  const Thirdpage({super.key});

  @override
  State<Thirdpage> createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "My rides",
              style: TextStyle(color: Colors.white),
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Publish Ride',
              ),
              Tab(
                text: 'Booked Ride',
              )
            ]),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2.5), // Border color and width
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 2,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Text(
                          "Booking No.#19044662518",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(9.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngegg.com%2Fen%2Fsearch%3Fq%3Davatars&psig=AOvVaw3AxvtT3VnsjhufxuINt2GA&ust=1726908553934000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCND66eeR0YgDFQAAAAAdAAAAABAE'),
                            ),
                          ),
                          const Text(
                            "Robert",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 85),
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                              width: 100,
                              height: 25,
                              child: const Center(
                                  child: Text(
                                "Completed",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.location_on_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          Text(
                            "Start Location",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 120,
                          ),
                          Text(
                            "11:00 AM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Block-A, Mondeal Square ,Prahlad Nagar,",
                          style: TextStyle(color: Colors.black38),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Ahmedabad,Gujerat 380015,India",
                          style: TextStyle(color: Colors.black38),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.location_on_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          Text(
                            "End Location",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 130,
                          ),
                          Text(
                            "11:08 AM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "41,Science City,Sola,Ahmedabad,Gujarat",
                        style: TextStyle(color: Colors.black38),
                      ),
                      const Text(
                        "380060,India",
                        style: TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Card(
                        elevation: 4,
                        child: Row(children: [
                          Text(
                            "Tue,19thSep23",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Icon(Icons.currency_pound_outlined),
                          Text(
                            "4.00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 40, right: 10),
                            child: Text(
                              "Per Passanger ",
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                              height: 500,
                              width: 450,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 90,
                                      ),

                                      const Text(
                                        'CAR POOL',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  SizedBox(width: 165,),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 60.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();

                                            // Code to execute when the icon is tapped
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 30.0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Get Flat 5% off\nOn Your first Ride',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'COUPON CODE',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      'NEW5',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: 300,
                                      height: 280,
                                      child: Image.network(
                                        'https://www.shutterstock.com/shutterstock/photos/759422134/display_1500/stock-vector-taxi-driver-and-passengers-in-car-front-view-759422134.jpg',
                                        fit: BoxFit.fill,
                                      ))
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(''),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Show Promo Popup'),
                  ),
                ],
              ),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blueAccent,
                //unselectedItemColor: Colors.white.withOpacity(.60),
                selectedFontSize: 14,
                unselectedFontSize: 14,
                onTap: (value) {
                  // Respond to item press.
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.message), label: "Your Rides"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline), label: "publish"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Book a Ride",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],
              )
            ],
          )),
    );
  }
}
