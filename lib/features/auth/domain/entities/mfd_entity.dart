import 'package:equatable/equatable.dart';

class MfdEntity extends Equatable {
  final String? userId;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MfdEntity({
    this.userId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        userId,
        id,
        createdAt,
        updatedAt,
      ];
}
