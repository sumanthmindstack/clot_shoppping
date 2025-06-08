import '../../domain/entity/user_goals_entity.dart';

class UserGoalsResponseModel extends UserGoalsEntity {
  UserGoalsResponseModel({required super.result});

  factory UserGoalsResponseModel.fromJson(Map<String, dynamic> json) {
    return UserGoalsResponseModel(
      result: (json['result'] as List)
          .map((e) => UserGoalModel.fromJson(e))
          .toList(),
    );
  }
}

class UserGoalModel extends UserGoalEntity {
  UserGoalModel({
    required super.id,
    required super.goalName,
    required super.userId,
    required super.goalId,
    required super.currentCost,
    required super.currentMonthlyExpenses,
    required super.retirementAge,
    required super.lifeExpectancy,
    required super.expectedInflation,
    required super.targetYear,
    required super.expectedReturns,
    required super.createdAt,
    required super.updatedAt,
    required super.isDeleted,
  });

  factory UserGoalModel.fromJson(Map<String, dynamic> json) {
    return UserGoalModel(
      id: json['id'],
      goalName: json['goal_name'],
      userId: json['user_id'],
      goalId: json['goal_id'],
      currentCost: json['current_cost'],
      currentMonthlyExpenses: json['current_monthly_expenses'],
      retirementAge: json['retirement_age'], // can be null
      lifeExpectancy: json['life_expectancy'],
      expectedInflation: json['expected_inflation'],
      targetYear: json['target_year'],
      expectedReturns: json['expected_returns'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isDeleted: json['is_deleted'],
    );
  }
}
