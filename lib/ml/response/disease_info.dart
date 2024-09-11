class DiseaseInfo {
  final String description;
  final String diseaseName;
  final String prevention;
  final String supplement;

  DiseaseInfo({
    required this.description,
    required this.diseaseName,
    required this.prevention,
    required this.supplement,
  });

  factory DiseaseInfo.fromJson(Map<String, dynamic> json) {
    return DiseaseInfo(
      description: json['description'],
      diseaseName: json['disease_name'],
      prevention: json['prevention'],
      supplement: json['supplement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'disease_name': diseaseName,
      'prevention': prevention,
      'supplement': supplement,
    };
  }
}
