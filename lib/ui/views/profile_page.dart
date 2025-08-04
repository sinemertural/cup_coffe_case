import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/data/state/auth_state.dart';
import 'package:cup_coffe_case/ui/cubit/auth_cubit.dart';
import 'package:cup_coffe_case/ui/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                if (state is AuthUnAuthenticated) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                  );
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    final user = state.user;
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),

                            // Profile Header
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
                                Icons.person,
                                color: Colors.white,
                                size: 65,
                              ),
                            ),

                            const SizedBox(height: 30),

                            Text(
                              "Merhaba",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Profile Options
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.email_outlined,
                                      color: AppColors.primary,
                                    ),
                                    title: Text(
                                      "E-posta",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      user.email,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: AppColors.txtFieldColorDark,
                                      ),
                                    ),
                                  ),

                                  const Divider(),

                                  ListTile(
                                    leading: Icon(
                                      Icons.calendar_today_outlined,
                                      color: AppColors.primary,
                                    ),
                                    title: Text(
                                      "Hesap Oluşturulma",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: AppColors.txtFieldColorDark,
                                      ),
                                    ),
                                  ),

                                  const Divider(),

                                  // Settings
                                  ListTile(
                                    leading: Icon(
                                      Icons.settings_outlined,
                                      color: AppColors.primary,
                                    ),
                                    title: Text(
                                      "Ayarlar",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: AppColors.txtFieldColorDark,
                                    ),
                                    onTap: () {
                                      // to settings
                                    },
                                  ),

                                  const Divider(),

                                  // Help
                                  ListTile(
                                    leading: Icon(
                                      Icons.help_outline,
                                      color: AppColors.primary,
                                    ),
                                    title: Text(
                                      "Yardım",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: AppColors.txtFieldColorDark,
                                    ),
                                    onTap: () {
                                      //to help
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  // Logout Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<AuthCubit>().signOut();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "Log Out",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text(
                        "Kullanıcı bilgileri yüklenemedi",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                },
              ),
            ),
        ],

      ),
    );
  }
}
