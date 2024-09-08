class TrueCredit {
  final List<double> ratings; // Ratings list
  final int cibilScore; // CIBIL score (out of 900)

  TrueCredit({required this.ratings, required this.cibilScore});

  double calculateTrueCreditScore() {
    if (ratings.isEmpty) {
      throw ArgumentError('Ratings list cannot be empty');
    }

    // Calculate average rating
    double averageRating = ratings.reduce((a, b) => a + b) / ratings.length;

    // Ensure rating is between 0 and 5
    averageRating = averageRating.clamp(0.0, 5.0);

    // Normalize CIBIL score to a 0-100 scale
    double normalizedCIBILScore = cibilScore / 900 * 100;

    // Normalize average rating to a 0-100 scale
    double normalizedRating = averageRating / 5 * 100;

    // Define scaling factors
    double ratingWeight = 2; // Rating is given more weight (2 times)
    double cibilWeight = 1; // CIBIL score weight

    // Calculate weighted average of ratings and CIBIL score
    double weightedScore =
        (normalizedRating * ratingWeight + normalizedCIBILScore * cibilWeight) /
            (ratingWeight + cibilWeight);

    // Scale the final score to 800 scale
    double finalScore = weightedScore / 100 * 800;

    return finalScore;
  }
}

List<double> exRatings = [4.2, 5.0, 3.2, 4.8, 3.5, 4.0, 3.9, 5.0, 5.0];
TrueCredit exampleTrueCredit = TrueCredit(ratings: exRatings, cibilScore: 700);
