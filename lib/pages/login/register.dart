import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/Button.dart';
import '../../widgets/login_widgets.dart';
import 'pages/../cubit.dart';
import 'pages/../states.dart';

class Register extends StatelessWidget {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);

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
                      Center(
                        child: Text(
                          'Register',
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 30),
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
                                .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                )
                                .then((value) => print('register success'));
                          } else
                            print('not register');
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
                                  'Register',
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
                      Center(
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
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
