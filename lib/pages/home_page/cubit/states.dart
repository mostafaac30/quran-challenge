import 'package:equatable/equatable.dart';

import '../../../models/user_data.dart';

abstract class HomePageStates extends Equatable {}

class HomePageInitial extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageJuzLoading extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageJuzCompleted extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageBtmSheetClosed extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageBtmSheetOpened extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageGetUserDataLoading extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageGetUserDataSuccess extends HomePageStates {
  final UserData userData;
  HomePageGetUserDataSuccess({required this.userData});

  @override
  List<Object> get props => [userData];
}

class HomePageGetPairDataLoading extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageGetPairDataSuccess extends HomePageStates {
  final UserData pairData;
  HomePageGetPairDataSuccess({required this.pairData});

  @override
  List<Object> get props => [pairData];
}

class HomePageUpdateDataLoading extends HomePageStates {
  @override
  List<Object> get props => [];
}

class HomePageUpdateDataSuccess extends HomePageStates {
  @override
  List<Object> get props => [];
}
