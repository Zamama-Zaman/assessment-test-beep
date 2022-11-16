import 'package:equatable/equatable.dart';

class RechargeModel extends Equatable {
  final double? currentAmount;

  const RechargeModel({this.currentAmount});

  @override
  List<Object?> get props => [currentAmount];
}
