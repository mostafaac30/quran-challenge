import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates extends Equatable {} //no content

class LoginInitialState extends LoginStates {
  ///
  ///states hold data >> that's a list of data can be passed
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginErrorState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginStates {
  Map userObj;
  LoginSuccessState({
    required this.userObj,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userObj];
}

class LogOutState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class LoginWithEmailLoadingState extends LoginStates {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

// class LoginWithEmailErrorState extends LoginStates {
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }

class LoginWithEmailSuccessState extends LoginStates {
  String uid;
  LoginWithEmailSuccessState({
    required this.uid,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}

class SignUpWithEmailLoadingState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpWithEmailSuccessState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpWithEmailErrorState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LogOutWithEmailErrorState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VerifyPhoneNumberErrorState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VerifyPhoneNumberSuccessState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VerifyPhoneNumberLoadingState extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
