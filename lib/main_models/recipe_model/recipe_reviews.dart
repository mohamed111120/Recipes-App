class RecipeReviews {
  String? userUid;
  String? review;
  int? rating;
  String? date;

  RecipeReviews({
    required this.userUid,
    required this.review,
    required this.rating,
    required this.date,
  });

  RecipeReviews.fromJson(Map<String, dynamic> json) {
    userUid = json['user uid'];
    review = json['review'];
    rating = json['rating'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user uid': userUid,
      'review': review,
      'rating': rating,
      'date': date,
    };
  }
}
