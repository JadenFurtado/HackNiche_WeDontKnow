import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  Future<List<SuggestionModel>> _getSuggestions(String path) async {
    final str = jsonDecode(await rootBundle.loadString(path)) as List;
    return str.map((e) => SuggestionModel.fromMap(e)).toList();
  }

  late final Future<List<SuggestionModel>> _lifeSuggestions, _healthSuggestions;

  @override
  void initState() {
    super.initState();
    _lifeSuggestions = _getSuggestions("assets/data/life_ins.json");
    _healthSuggestions = _getSuggestions("assets/data/health_ins.json");
  }

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
                child: FutureBuilder<List<SuggestionModel>>(
                  future: _lifeSuggestions,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        itemBuilder: (context, index) =>
                            _suggestionWidget(snapshot.data![index]),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
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
                child: FutureBuilder<List<SuggestionModel>>(
                  future: _healthSuggestions,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        itemBuilder: (context, index) =>
                            _suggestionWidget(snapshot.data![index]),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
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
      child: SizedBox(
        width: 140,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => launchUrlString(suggestion.site),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  suggestion.logo,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              suggestion.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
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
