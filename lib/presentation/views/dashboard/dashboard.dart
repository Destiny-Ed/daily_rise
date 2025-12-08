import 'package:flutter/material.dart';
import 'package:daily_rise/core/extensions.dart';
import 'package:daily_rise/presentation/views/dashboard/blocked_apps_details.dart';
import 'package:daily_rise/presentation/views/notifications/notification.dart';
import 'package:daily_rise/presentation/views/workout/workout_screen.dart';
import 'package:daily_rise/presentation/widgets/social_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: Text("Good morning, John"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  ...List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlockedAppsDetailsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                "Reading",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              subtitle: Text(
                                "15/20 minutes today",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(
                                  context,
                                ).secondaryHeaderColor,
                              ),
                              trailing: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.fire_extinguisher,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      "5 day streak",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            CustomButton(text: "Log Reading", padding: 10),
                          ],
                        ),
                      ),
                    );
                  }),

                  ///block app button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'leaderboard live activity'.cap,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ...List.generate(4, (index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        "sarah J. just logged her workout".capitalize,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        "2 minutes ago",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: Icon(Icons.lock),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   enableFeedback: true,
      //   label: Text("Block apps to reduce doomscrolling"),
      // ),
    );
  }
}
