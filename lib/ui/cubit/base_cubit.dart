import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit extends Cubit<int> {
  BaseCubit() : super(0);

  void changePage(int index) {
    emit(index);
  }
}