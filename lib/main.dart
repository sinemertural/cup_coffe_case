import 'package:cup_coffe_case/ui/cubit/base_cubit.dart';
import 'package:cup_coffe_case/ui/cubit/home_cubit.dart';
import 'package:cup_coffe_case/ui/cubit/order_cubit.dart';
import 'package:cup_coffe_case/ui/cubit/reserve_cubit.dart';
import 'package:cup_coffe_case/ui/views/base_page.dart';
import 'package:cup_coffe_case/ui/views/home_page.dart';
import 'package:cup_coffe_case/ui/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BaseCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ReserveCubit()),
        BlocProvider(create: (context) => OrderCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
