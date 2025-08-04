import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/state/auth_state.dart';
import 'package:cup_coffe_case/ui/cubit/auth_cubit.dart';
import 'package:cup_coffe_case/ui/views/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      context.read<AuthCubit>().signUp(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1,
              ),
              itemCount: 136,
              itemBuilder: (context, index) {
                return Icon(
                  Icons.coffee,
                  size: 30,
                  color: AppColors.primary.withOpacity(0.09),
                );
              },
            ),
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                setState(() => _isLoading = false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BasePage()),
                  (route) => false,
                );
              } else if (state is AuthError) {
                setState(() => _isLoading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                               MediaQuery.of(context).padding.top -
                               MediaQuery.of(context).padding.bottom - 40,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 40),

                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.coffee,
                            color: Colors.white,
                            size: 65,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Column(
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 45,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Create your account",
                              style: TextStyle(
                                color: AppColors.txtFieldColorDark,
                                fontFamily: "Poppins",
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        size: 23,
                                        color: AppColors.txtFieldColorDark,
                                      ),
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 20,
                                        color: AppColors.txtFieldColorDark,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.textFieldColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Email adresi gerekli";
                                      }
                                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(value)) {
                                        return 'Geçerli bir email adresi girin';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: !_isPasswordVisible,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: AppColors.txtFieldColorDark,
                                        size: 23,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: AppColors.txtFieldColorDark,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordVisible = !_isPasswordVisible;
                                          });
                                        },
                                      ),
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        color: AppColors.txtFieldColorDark,
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                      ),
                                      filled: true,
                                      fillColor: AppColors.textFieldColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Şifre gerekli";
                                      }
                                      if (value.length < 6) {
                                        return 'Şifre en az 6 karakter olmalı';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: !_isConfirmPasswordVisible,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: AppColors.txtFieldColorDark,
                                        size: 23,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isConfirmPasswordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: AppColors.txtFieldColorDark,
                                          size: 22,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isConfirmPasswordVisible =
                                                !_isConfirmPasswordVisible;
                                          });
                                        },
                                      ),
                                      labelText: "Confirm Password",
                                      labelStyle: TextStyle(
                                        color: AppColors.txtFieldColorDark,
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                      ),
                                      filled: true,
                                      fillColor: AppColors.textFieldColor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Şifre onayı gerekli";
                                      }
                                      if (value != _passwordController.text) {
                                        return 'Şifreler eşleşmiyor';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // Register Button
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                  child: SizedBox(
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: _isLoading ? null : _handleRegister,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                              ),
                                            )
                                          : const Text(
                                              "Register",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Login Link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        color: AppColors.txtFieldColorDark,
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Log In",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
