class DemandPredictionResponse {
  final List<double> prediction;

  DemandPredictionResponse({required this.prediction});

  factory DemandPredictionResponse.fromJson(Map<String, dynamic> json) {
    return DemandPredictionResponse(
      prediction:
          List<double>.from(json['prediction'].map((x) => x.toDouble())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction': prediction,
    };
  }
}
