import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/home%20cubit.dart';
import 'package:shop_app/cubit/state.dart';
import 'package:shop_app/share%20pref/cach%20helper.dart';
import 'package:shop_app/shop%20regester%20screen.dart';
import 'package:shop_app/shop_layout.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                  key: "token", value: state.loginModel.data.token).then((value) {
                    ShopCubit.get(context).token=state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                      return ShopLayout();
                    }), (route) => false);

              }).catchError((error){
                print(error);
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                      return ShopLayout();
                    }), (route) => false);

              });
            } else {
              //print(state.loginModel.message);
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: state.loginModel.message,
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                btnOkColor: Colors.red,
                onDissmissCallback: (type) {
                  debugPrint('Dialog Dissmiss from callback $type');
                },
              ).show();
            }
          }
        },
        builder: (context, state) {
          if (state is ShopLoginInitialState) print('initial');
          if (state is ShopLoginLoadingState) print('loading');
          if (state is ShopLoginSuccessState) print('success');
          if (state is ShopLoginErrorState) print('error');

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "login now to browse our hot offers ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          //onFieldSubmitted: ,
                          //onChanged: ,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },

                          decoration: InputDecoration(
                              labelText: "Enter your email",
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder()),
                        ),
                        /*TextField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            prefix: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Enter your email',
                            labelStyle:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                          ),
                        ),*/
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,

                          //onFieldSubmitted: ,
                          //onChanged: ,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short ';
                            }

                            return null;
                          },

                          decoration: InputDecoration(
                              labelText: "password",
                              suffix: Icon(Icons.visibility_off_outlined),
                              prefixIcon: IconButton(
                                icon: Icon(Icons.email_outlined),
                                onPressed: () {},
                              ),
                              border: OutlineInputBorder()),
                        ),
                        /*TextField(
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: false,
                          decoration: InputDecoration(
                            prefix: Icon(Icons.lock_open_outlined),
                            suffix: IconButton(
                              icon: Icon(Icons.visibility_off_outlined),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            labelText: 'Enter your password',
                            labelStyle:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                          ),
                        ),*/
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BuildCondition(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => MaterialButton(
                                textColor: Colors.white,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                color: Colors.blue,
                                height: 50,
                                child: Text(
                                  'login'.toUpperCase(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don\'t have an account?",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RegisterScreen();
                                  }));
                                },
                                child: Text("sign up"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
