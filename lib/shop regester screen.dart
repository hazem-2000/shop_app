import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/register%20cubit.dart';
import 'package:shop_app/share%20pref/cach%20helper.dart';
import 'package:shop_app/shop_layout.dart';

import 'cubit/cubit.dart';
import 'cubit/home cubit.dart';
import 'cubit/state.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopLoginState>(
        listener:(context,state)
        {
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
              print(state.loginModel.message);
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
        } ,
        builder:(context,state)=> Scaffold(
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
                        "REGISTER",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "Register now to browse our hot offers ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        //onFieldSubmitted: ,
                        //onChanged: ,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                            labelText: "User Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder()),
                      ),

                      SizedBox(
                        height: 15,
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
                            labelText: "Email",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        //onFieldSubmitted: ,
                        //onChanged: ,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }

                          return null;
                        },

                        decoration: InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder()),
                      ),
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
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text);

                                }
                              },
                              color: Colors.blue,
                              height: 50,
                              child: Text(
                                'register'.toUpperCase(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ,

      ),
    );
  }
}
