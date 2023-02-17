import 'dart:convert';
import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:paisa/src/core/common.dart';
import 'package:paisa/src/core/enum/box_types.dart';
import 'package:paisa/src/service_locator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../../../data/suggestion/models/insurance_suggestion_model.dart';

const PIE_RADIUS = 140.0;

const pieChartColors = [
  Color(0xffFF000A),
  Color(0xff8AFF00),
  Color(0xff00FFF5),
  Color(0xff7500FF),
  Color(0xff003FFF),
  Color(0xFFDEF00F),
  Color(0xff81807E)
];

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
  Future<List<InsuranceSuggestionModel>> _getSuggestions(String path) async {
    final str = jsonDecode(await rootBundle.loadString(path)) as List;
    return str.map((e) => InsuranceSuggestionModel.fromMap(e)).toList();
  }

  Future<Map<String, dynamic>> _getBudgetingSuggestions() async {
    final settingsBox =
        locator.get<Box<dynamic>>(instanceName: BoxType.settings.name);

    final age = settingsBox.get(userAgeKey);
    final sex = settingsBox.get(userGenderKey) ? 0 : 1;
    final income = settingsBox.get(userIncomeKey);
    final res = await http.get(Uri.parse(
      "$baseURL/diversifySuggestions?age=$age&sex=$sex&income=$income",
    ));

    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  late final Future<List<InsuranceSuggestionModel>> _lifeSuggestions,
      _healthSuggestions;
  late final Future<Map<String, dynamic>> _budgetingSuggestions;

  @override
  void initState() {
    super.initState();
    _lifeSuggestions = _getSuggestions("assets/data/life_ins.json");
    _healthSuggestions = _getSuggestions("assets/data/health_ins.json");
    _budgetingSuggestions = _getBudgetingSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _pieChartWidget()),
        const SliverToBoxAdapter(child: Divider()),
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
                child: FutureBuilder<List<InsuranceSuggestionModel>>(
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
        const SliverToBoxAdapter(child: Divider()),
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
                child: FutureBuilder<List<InsuranceSuggestionModel>>(
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

  Widget _suggestionWidget(InsuranceSuggestionModel suggestion) {
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
    String snakeCasetoSentenceCase(String str) {
      return "${str[0].toUpperCase()}${str.substring(1)}"
          .replaceAll(RegExp(r'(_|-)+'), ' ');
    }

    bool useWhiteForeground(Color backgroundColor, {double bias = 0.0}) {
      int v = math
          .sqrt(math.pow(backgroundColor.red, 2) * 0.299 +
              math.pow(backgroundColor.green, 2) * 0.587 +
              math.pow(backgroundColor.blue, 2) * 0.114)
          .round();
      return v < 130 + bias ? true : false;
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: _budgetingSuggestions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: snapshot.data!.entries.map(
                      (e) {
                        final color = pieChartColors[
                            snapshot.data!.keys.toList().indexOf(e.key)];
                        return PieChartSectionData(
                          color: color,
                          value: e.value,
                          title: "${((e.value as double) * 100.0).round()}%",
                          radius: PIE_RADIUS,
                          titlePositionPercentageOffset: 0.7,
                          titleStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: useWhiteForeground(color)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0)
                    .copyWith(bottom: 25),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: snapshot.data!.entries.map(
                    (e) {
                      final color = pieChartColors[
                          snapshot.data!.keys.toList().indexOf(e.key)];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              snakeCasetoSentenceCase(e.key),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
