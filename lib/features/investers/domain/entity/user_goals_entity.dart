class UserGoalEntity {
  final int id;
  final String goalName;
  final int userId;
  final int goalId;
  final String currentCost;
  final String currentMonthlyExpenses;
  final int? retirementAge; // nullable because it can be null
  final int lifeExpectancy;
  final int expectedInflation;
  final int targetYear;
  final int expectedReturns;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isDeleted;

  UserGoalEntity({
    required this.id,
    required this.goalName,
    required this.userId,
    required this.goalId,
    required this.currentCost,
    required this.currentMonthlyExpenses,
    this.retirementAge,
    required this.lifeExpectancy,
    required this.expectedInflation,
    required this.targetYear,
    required this.expectedReturns,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });
}

class UserGoalsEntity {
  final List<UserGoalEntity> result;

  UserGoalsEntity({
    required this.result,
  });
}
