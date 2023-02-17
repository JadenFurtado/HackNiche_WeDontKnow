import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const PIE_RADIUS = 140.0;

enum SuggestionType {
  safe("Safe"),
  risky("Risky"),
  expenses("Expenses"),
  fuMoney("FU Money");

  final String name;
  const SuggestionType(this.name);
}

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  State<SuggestionsPage> createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _pieChartWidget(),
        ),
        // SliverList(
        //   delegate: SliverChildListDelegate.fixed(
        //     SuggestionType.values
        //         .map((e) => e != SuggestionType.expenses
        //             ? ListTile(
        //                 title: Text("Show ${e.name} investment options"),
        //                 onTap: () {},
        //                 trailing: const Icon(Icons.chevron_right_rounded),
        //               )
        //             : const SizedBox.shrink())
        //         .toList(),
        //   ),
        // ),
      ],
    );
  }

  Widget _pieChartWidget() {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: [
            PieChartSectionData(
              color: Colors.amber,
              value: 40,
              title: 'FU Money\n₹10000',
              radius: PIE_RADIUS,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 40,
              title: 'Expenses\n₹10000',
              radius: PIE_RADIUS,
            ),
            PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: 'Risky\n₹10000',
              radius: PIE_RADIUS,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 40,
              title: 'Safe\n₹10000',
              radius: PIE_RADIUS,
            ),
          ],
        ),
      ),
    );
  }
}
