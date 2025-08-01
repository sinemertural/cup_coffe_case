import 'package:cup_coffe_case/data/entity/user.dart';
import 'package:cup_coffe_case/data/repo/auth_repository.dart';
import 'package:cup_coffe_case/data/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> signIn(String email, String password) async{
    emit(AuthLoading());

    try{
      final user = await _authRepository.signIn(email, password);

      if(user != null){
        emit(AuthAuthenticated(user));
      }else{
        emit(AuthError("Failed sign in..."));
      }
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> signUp(String email, String password) async{
    emit(AuthLoading());
    
    try{
      final user = await _authRepository.signUp(email, password);
      
      if(user != null){
        emit(AuthAuthenticated(user));
      }else{
        emit(AuthError("Failed sign up..."));
      }
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    
    try {
      await _authRepository.signOut();
      emit(AuthUnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    
    try {
      final user = await _authRepository.getCurrentUser();
      
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    
    try {
      await _authRepository.resetPassword(email);
      emit(AuthUnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updatePassword(String newPassword) async {
    emit(AuthLoading());
    
    try {
      await _authRepository.updatePassword(newPassword);
      emit(AuthUnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> deleteUser() async {
    emit(AuthLoading());
    
    try {
      await _authRepository.deleteUser();
      emit(AuthUnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}