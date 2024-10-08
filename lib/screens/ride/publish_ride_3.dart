import 'package:cabmate_task/screens/ride/publish_ride_4.dart';
import 'package:flutter/material.dart';

class PublishRideScreen3 extends StatefulWidget {
  const PublishRideScreen3({super.key});

  @override
  State<PublishRideScreen3> createState() => _PublishRideScreen3State();
}

class _PublishRideScreen3State extends State<PublishRideScreen3> {
  final DateTime _dateTime = DateTime(2023, 9, 19, 11, 0);
  int _numberOfPassengers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish a Ride'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Ride Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffc2c2c2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date & Time Field
                    const Text('Date & Time *', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffc2c2c2),
                            spreadRadius: 2,
                            blurRadius: 2,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText:
                                '${_dateTime.day} ${_dateTime.month} ${_dateTime.year} ${_dateTime.hour}:${_dateTime.minute} AM',
                            border: InputBorder.none,
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          onTap: () {
                            // Implement date picker here if needed
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Number of Passengers Field
                    const Text('No of Passengers? *',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 10, top: 3, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffc2c2c2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            )
                          ]),
                      child: DropdownButtonFormField<int>(
                        value: _numberOfPassengers,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        items: List.generate(10, (index) => index + 1)
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _numberOfPassengers = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Price per Seat Field
                    const Text('Price per Seat? *',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffc2c2c2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            )
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  suffixText: 'USD',
                                  border: InputBorder.none,
                                  hintText: '12'),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: const Center(
                                child: Text(
                              'USD',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Recommended Price
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RichText(
                        text: const TextSpan(
                          style:
                              TextStyle(color: Colors.black), // Default style
                          children: [
                            TextSpan(
                                text: "Recommended Price : ",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            TextSpan(
                              text: "\$12.24-\$18.37",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Navigation Buttons
          Container(
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
                const Text(
                  'Steps 3/5',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const PublishRideScreen4()));
                      },
                      icon: const Icon(Icons.arrow_forward)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
