import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../data/suggestion/models/suggestion_model.dart';

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
        SliverToBoxAdapter(child: _pieChartWidget()),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Term Life Insurance",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  itemBuilder: (context, index) => _suggestionWidget(
                    const SuggestionModel(
                      name: "name",
                      company: "company",
                      logo: "https://darshanrander.com/darshan.jpg",
                      site: "site",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Health Insurance",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  itemBuilder: (context, index) => _suggestionWidget(
                    const SuggestionModel(
                      name: "name",
                      company: "company",
                      logo: "https://darshanrander.com/darshan.jpg",
                      site: "site",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _suggestionWidget(SuggestionModel suggestion) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              suggestion.logo,
              height: 120,
            ),
          ),
          const SizedBox(height: 4),
          Text(suggestion.name),
        ],
      ),
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
