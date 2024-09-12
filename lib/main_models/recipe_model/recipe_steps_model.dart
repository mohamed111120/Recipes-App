class RecipeSteps {
  String? step;
  int? minutes;

  RecipeSteps({
    this.step,
    this.minutes,
  });

  RecipeSteps.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'minutes': minutes,
    };
  }
}