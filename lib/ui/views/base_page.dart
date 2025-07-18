import 'package:cup_coffe_case/core/theme/app_colors.dart';
import 'package:cup_coffe_case/ui/cubit/base_page_cubit.dart';
import 'package:cup_coffe_case/ui/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasePageCubit, int>(
        builder: (context, selectedPage) {
          final pages = [const HomePage()];

          return Scaffold(
            body: pages[selectedPage],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    // çünkü dış container zaten beyaz
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Image(
                            image: AssetImage("assets/icons/vector.png"),
                            width: 24,
                            height: 24,
                          ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/shopping-bag.png"),
                          width: 24,
                          height: 24,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/map-pin.png"),
                          width: 24,
                          height: 24,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/heart.png"),
                          width: 24,
                          height: 24,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/user.png"),
                          width: 24,
                          height: 24,
                        ),
                        label: "",
                      ),
                    ],
                    currentIndex: selectedPage,
                    selectedItemColor: AppColors.primary_green,
                    onTap: (index) {
                      context.read<BasePageCubit>().changePage(index);
                    },
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

