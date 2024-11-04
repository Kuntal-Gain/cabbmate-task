import 'package:cabmate_task/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_format/flutter_datetime_format.dart' as fd;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  DateTime now = DateTime.now();

  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    notifications = [
      NotificationModel(
        label: "why do Service Givers Want a App like This",
        description:
            "The Basic role of an application is the make the life of a user easy.So, if your app is'nt doing that.you are...",
        createAt: fd.FLDateTime.formatWithNames(now, "DD MMMM,YYYY (EEE)"),
        category: Category.News,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            // TabBar inside the body
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Notifications'),
                Tab(text: 'News'),
              ],
            ),
            // Expanded widget to contain TabBarView below the tabs
            Expanded(
              child: TabBarView(
                children: [
                  notificationCard(notifications),
                  notificationCard(notifications
                      .where((x) => x.category == Category.Notifications)
                      .toList()),
                  notificationCard(notifications
                      .where((x) => x.category == Category.News)
                      .toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget notificationCard(List<NotificationModel> notifications) {
  return notifications.isEmpty
      ? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 40),
            Text(
              'No Notification Found',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      : ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (ctx, idx) {
            final notif = notifications[idx];

            return SingleChildScrollView(
              child: Column(
                children: notifications.map((notif) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xffc2c2c2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif.label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          notif.description,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notif.createAt,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Read More',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
}
