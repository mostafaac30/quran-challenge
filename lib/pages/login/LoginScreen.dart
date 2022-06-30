import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_challenge/pages/home_page/cubit/cubit.dart';
import 'package:quran_challenge/pages/home_page/progress.dart';
import '../../widgets/Button.dart';
import '../../widgets/login_widgets.dart';
import 'pages/../cubit.dart';
import 'pages/../states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        String uid;
        LoginCubit cubit = LoginCubit.get(context);

        if (state is LoginWithEmailSuccessState) {
          uid = state.props[0] as String;
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            navigateAndfinish(context: context, screen: Progress());
          });
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      defaultTFF(
                          label: 'Email Address',
                          inputType: TextInputType.emailAddress,
                          controller: emailController,
                          validate: (value) {
                            if (value!.isEmpty) return 'not correct';
                            return null;
                          }),
                      SizedBox(height: 15),
                      defaultTFF(
                          isPassword: true,
                          label: 'Password',
                          inputType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validate: (value) {
                            if (value!.isEmpty) return 'not correct';
                            return null;
                          }),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit
                                .loginWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then((value) {
                              print('login success');
                            });
                          } else
                            print('not valid');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 35,
                          ),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
