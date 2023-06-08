import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iranicard_demo/common/exception.dart';
import 'package:iranicard_demo/data/model/AuthInfo.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
import 'package:iranicard_demo/ui/root/RootScreen.dart';

import '../LightThemeColor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: "09901876797");
  final TextEditingController _passwordController =
      TextEditingController(text: "Aref1380@");

  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Theme(
        data: themeData.copyWith(
            inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: LightThemeColor.primaryColor)),
        )),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(),
              ),
              bottomSheet: Padding(
                padding: const EdgeInsets.all(24.0),
                child: InkWell(
                  onTap: () async {
                    try {
                      AuthInfoEntity auth = await authRepository.login(
                        _phoneController.text,
                        _passwordController.text,
                      );
                      if (auth.accessTocken != "") {
                        Fluttertoast.showToast(
                          msg: "خوش آمدی ${auth.name}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: LightThemeColor.primaryColor,
                          textColor: Colors.white,
                          fontSize: 14.0,
                        );
                        _navigateToHomeScreen();
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: (e is AppException) ? e.message : e.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: LightThemeColor.primaryColor,
                    ),
                    child: Text(
                      'ورود کاربران',
                      style: themeData.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: SizedBox(
                        height: 70,
                        width: 150,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ورود به حساب کاربری',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: LightThemeColor.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'با استفاده از شماره موبایل و رمز عبورتان وارد شوید',
                      style: themeData.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              label: Text(
                                'شماره موبایل',
                                style: themeData.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              label: Text(
                                'رمز عبور',
                                style: themeData.textTheme.bodyMedium,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: _togglePasswordVisibility,
                                child: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  debugPrint("forget password clicked.");
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.vpn_key,
                                      color: LightThemeColor.primaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'فراموشی رمز عبور',
                                      style: themeData.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: LightThemeColor.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Text(
                            'ساخت حساب کاربری جدید',
                            textAlign: TextAlign.right,
                            style: themeData.textTheme.bodyMedium?.copyWith(
                              color: LightThemeColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )),
        ));
  }

  void _navigateToHomeScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RootScreen()));
  }
}
