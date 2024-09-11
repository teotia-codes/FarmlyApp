class CreditPredictionResponse {
  final List<double> prediction;

  CreditPredictionResponse({required this.prediction});

  factory CreditPredictionResponse.fromJson(Map<String, dynamic> json) {
    return CreditPredictionResponse(
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
