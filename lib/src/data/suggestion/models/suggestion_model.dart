import 'dart:convert';

class SuggestionModel {
  final String name;
  final String company;
  final String logo;
  final String site;

  const SuggestionModel({
    required this.name,
    required this.company,
    required this.logo,
    required this.site,
  });

  SuggestionModel copyWith({
    String? name,
    String? company,
    String? logo,
    String? site,
  }) {
    return SuggestionModel(
      name: name ?? this.name,
      company: company ?? this.company,
      logo: logo ?? this.logo,
      site: site ?? this.site,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'company': company,
      'logo': logo,
      'site': site,
    };
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      name: map['name'] ?? '',
      company: map['company'] ?? '',
      logo: map['logo'] ?? '',
      site: map['site'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuggestionModel.fromJson(String source) =>
      SuggestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SuggestionModel(name: $name, company: $company, logo: $logo, site: $site)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuggestionModel &&
        other.name == name &&
        other.company == company &&
        other.logo == logo &&
        other.site == site;
  }

  @override
  int get hashCode {
    return name.hashCode ^ company.hashCode ^ logo.hashCode ^ site.hashCode;
  }
}
