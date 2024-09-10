class TrueCredit {
  final List<double> ratings;
  final int cibilScore;

  TrueCredit({required this.ratings, required this.cibilScore});

  // Convert TrueCredit to a map for Firebase Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'ratings': ratings,
      'cibilScore': cibilScore,
    };
  }
 factory TrueCredit.fromFirestore(Map<String, dynamic> data) {
    return TrueCredit(
      ratings: List<double>.from(data['ratings']),
      cibilScore: data['cibilScore'],
    );
  }

  double calculateTrueCreditScore() {
    if (ratings.isEmpty) {
      throw ArgumentError('Ratings list cannot be empty');
    }

    double averageRating = ratings.reduce((a, b) => a + b) / ratings.length;
    averageRating = averageRating.clamp(0.0, 5.0);
    double normalizedCIBILScore = cibilScore / 900 * 100;
    double normalizedRating = averageRating / 5 * 100;

    double ratingWeight = 2;
    double cibilWeight = 1;
    double weightedScore = (normalizedRating * ratingWeight + normalizedCIBILScore * cibilWeight) /
        (ratingWeight + cibilWeight);

    double finalScore = weightedScore / 100 * 800;
    return finalScore;
  }
}
