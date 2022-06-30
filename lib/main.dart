import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_challenge/pages/home_page/cubit/cubit.dart';
import 'package:quran_challenge/pages/home_page/progress.dart';
import 'package:quran_challenge/pages/login/LoginScreen.dart';
import 'package:sizer/sizer.dart';

import 'pages/login/cubit.dart';
import 'shared/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() async {
    await Firebase.initializeApp();

    HomePageCubit();
    LoginCubit();
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomePageCubit()
              ..getUserDataFromUsersCollection()
              ,
          ),
          BlocProvider(
            create: (context) => LoginCubit()..isLoggedIn(),
          ),
        ],
        child: Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return MaterialApp(
              title: 'Quran Challenge',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home:
                  LoginCubit.get(context).isLogin ? Progress() : LoginScreen(),
            );
          },
        ));
  }
}
