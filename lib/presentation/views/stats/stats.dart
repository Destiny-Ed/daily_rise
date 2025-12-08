// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:daily_rise/core/extensions.dart';
// import 'package:daily_rise/presentation/providers/stats_provider.dart';
// import 'package:daily_rise/presentation/views/stats/bar_chart_widget.dart';

// class StatsScreen extends StatefulWidget {
//   const StatsScreen({super.key});

//   @override
//   State<StatsScreen> createState() => _StatsScreenState();
// }

// class _StatsScreenState extends State<StatsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Your Stats"),
//         automaticallyImplyLeading: false,
//       ),

//       body: Consumer<StatsProvider>(
//         builder: (context, statsProvider, child) {
//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Column(
//                     spacing: 10,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Wrap(
//                         spacing: 8,
//                         children: statsProvider.habitFilters.map((filter) {
//                           final isSelected =
//                               filter == statsProvider.selectedHabitFilter;
//                           return ChoiceChip(
//                             label: Text(filter.cap),
//                             selected: isSelected,
//                             onSelected: (_) =>
//                                 statsProvider.selectedHabitFilter = filter,
//                             selectedColor: Theme.of(context).primaryColor,
//                             backgroundColor: Theme.of(context).cardColor,
//                           );
//                         }).toList(),
//                       ),
//                       Container(
//                         width: context.screenSize().width,
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Theme.of(context).cardColor,
//                         ),
//                         child: Column(
//                           spacing: 10,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Lifetime Total".cap,
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                             Text(
//                               "4,827 push-ups".cap,
//                               style: Theme.of(context).textTheme.headlineLarge,
//                             ),
//                           ],
//                         ),
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           "= 1,205,000 meters scrolled prevented 😂".cap,
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                       ),

//                       ///Display tab
//                       Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Theme.of(context).cardColor,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: List.generate(
//                             statsProvider.statTab.length,
//                             (index) {
//                               final tab = statsProvider.statTab[index];
//                               final isSelected =
//                                   tab == statsProvider.selectedTab;
//                               return Expanded(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     statsProvider.selectedTab = tab;
//                                   },
//                                   child: AnimatedContainer(
//                                     duration: const Duration(milliseconds: 400),
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: isSelected
//                                         ? BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               15,
//                                             ),
//                                             color: Theme.of(
//                                               context,
//                                             ).secondaryHeaderColor,
//                                           )
//                                         : null,
//                                     child: Text(
//                                       tab.cap,
//                                       textAlign: TextAlign.center,
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.titleSmall,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       10.height(),
//                       StatsBarChart(),

//                       //
//                       Text(
//                         "Screen time cost".cap,
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                       10.height(),

//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Theme.of(context).cardColor,
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: Text(
//                             "most expensive app".cap,
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                           subtitle: Text(
//                             "instagram",
//                             style: Theme.of(context).textTheme.titleSmall,
//                           ),
//                           leading: CircleAvatar(
//                             backgroundColor: Theme.of(
//                               context,
//                             ).secondaryHeaderColor,
//                             child: Icon(Icons.camera),
//                           ),
//                           trailing: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "1,240 reps".cap,
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               Text(
//                                 "this month".cap,
//                                 style: Theme.of(context).textTheme.titleSmall,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 5,
//                           horizontal: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Theme.of(context).cardColor,
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(0),
//                           title: Text(
//                             "most used app".cap,
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                           subtitle: Text(
//                             "instagram",
//                             style: Theme.of(context).textTheme.titleSmall,
//                           ),
//                           leading: CircleAvatar(
//                             backgroundColor: Theme.of(
//                               context,
//                             ).secondaryHeaderColor,
//                             child: Icon(Icons.camera),
//                           ),
//                           trailing: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "1,240 reps".cap,
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                               Text(
//                                 "this month".cap,
//                                 style: Theme.of(context).textTheme.titleSmall,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:daily_rise/core/extensions.dart';
import 'package:daily_rise/presentation/providers/stats_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Stats"),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<StatsProvider>(
        builder: (context, sp, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      // Lifetime Total
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              "Lifetime Total".cap,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "${sp.lifetimeTotal} ${sp.unit}",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                      ),

                      Text(
                        "= ${sp.lifetimeTotal * 50} meters scrolled prevented 😂",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      // Habit Filter Chips
                      Wrap(
                        spacing: 10,
                        children: sp.habitFilters.map((filter) {
                          final isSelected = filter == sp.selectedHabitFilter;
                          return ChoiceChip(
                            label: Text(filter.cap),
                            selected: isSelected,
                            onSelected: (_) => sp.selectedHabitFilter = filter,
                            selectedColor: Theme.of(context).primaryColor,
                            backgroundColor: Theme.of(context).cardColor,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : null,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          );
                        }).toList(),
                      ),

                      // Tab Selector
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: sp.statTabs.map((tab) {
                            final isSelected = tab == sp.selectedTab;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => sp.selectedTab = tab,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: isSelected
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Theme.of(
                                            context,
                                          ).secondaryHeaderColor,
                                        )
                                      : null,
                                  child: Text(
                                    tab.cap,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Dynamic Chart + Summary
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            Text(
                              sp.selectedTab == "weekly"
                                  ? "This week"
                                  : "This month".cap,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "${sp.currentPeriodTotal} actions",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  "vs last period ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "${sp.percentageChange > 0 ? '+' : ''}${sp.percentageChange.toStringAsFixed(0)}%",
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: sp.percentageChange > 0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                ),
                              ],
                            ),
                            20.height(),
                            SizedBox(
                              height: 200,
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceAround,
                                  barTouchData: BarTouchData(enabled: false),
                                  titlesData: FlTitlesData(
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          final days = [
                                            'M',
                                            'T',
                                            'W',
                                            'T',
                                            'F',
                                            'S',
                                            'S',
                                          ];
                                          final index = value.toInt();
                                          if (index < 0 || index >= days.length)
                                            return const SizedBox();
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                            ),
                                            child: Text(
                                              days[index],
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  gridData: const FlGridData(show: false),
                                  barGroups: sp
                                      .getChartData()
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                        return BarChartGroupData(
                                          x: entry.key,
                                          barRods: [
                                            BarChartRodData(
                                              toY: entry.value.y,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                              width: 16,
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                    top: Radius.circular(6),
                                                  ),
                                            ),
                                          ],
                                        );
                                      })
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Most Expensive App (Workout)
                      if (sp.selectedHabitFilter == "all" ||
                          sp.selectedHabitFilter == "workout")
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).cardColor,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).secondaryHeaderColor,
                              child: const Icon(Icons.fitness_center),
                            ),
                            title: Text(
                              "most expensive app".cap,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            subtitle: const Text("instagram"),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${sp.lifetimeTotal} reps",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "all time",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
