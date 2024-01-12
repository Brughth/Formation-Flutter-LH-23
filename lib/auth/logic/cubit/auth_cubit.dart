import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formation_lh_23/auth/data/auth_services.dart';
import 'package:formation_lh_23/auth/data/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  AuthCubit({
    required this.authService,
  }) : super(AuthState());

  register({
    required String email,
    required String name,
    required String password,
  }) async {
    emit(
      state.copyWith(
        isRegistering: true,
        successRegistering: false,
        errorRegistering: false,
        isLogingIn: false,
        successLogingIn: false,
        errorLogingIn: false,
      ),
    );

    try {
      var user = await authService.registerWithEmailAndPassword(
        email: email,
        name: name,
        password: password,
      );

      emit(
        state.copyWith(
          user: user,
          isRegistering: false,
          successRegistering: true,
          errorRegistering: false,
          isLogingIn: false,
          successLogingIn: false,
          errorLogingIn: false,
        ),
      );
    } on FirebaseAuthException catch (ex) {
      emit(
        state.copyWith(
          isRegistering: false,
          successRegistering: false,
          errorRegistering: true,
          isLogingIn: false,
          successLogingIn: false,
          errorLogingIn: false,
          message: ex.message,
        ),
      );
    } catch (e) {
      state.copyWith(
        isRegistering: false,
        successRegistering: false,
        errorRegistering: true,
        isLogingIn: false,
        successLogingIn: false,
        errorLogingIn: false,
        message: e.toString(),
      );
    }
  }

  login({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        isRegistering: false,
        successRegistering: false,
        errorRegistering: false,
        isLogingIn: true,
        successLogingIn: false,
        errorLogingIn: false,
      ),
    );

    try {
      var user = await authService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(
        state.copyWith(
          user: user,
          isRegistering: false,
          successRegistering: false,
          errorRegistering: false,
          isLogingIn: false,
          successLogingIn: true,
          errorLogingIn: false,
        ),
      );
    } on FirebaseAuthException catch (ex) {
      emit(
        state.copyWith(
          isRegistering: false,
          successRegistering: false,
          errorRegistering: false,
          isLogingIn: false,
          successLogingIn: false,
          errorLogingIn: true,
          message: ex.message,
        ),
      );
    } catch (e) {
      state.copyWith(
        isRegistering: false,
        successRegistering: false,
        errorRegistering: false,
        isLogingIn: false,
        successLogingIn: false,
        errorLogingIn: true,
        message: e.toString(),
      );
    }
  }

  setUSer(UserModel user) {
    emit(
      state.copyWith(
        user: user,
      ),
    );
  }

  logout() async {
    await authService.logout();
    emit(
      AuthState(),
    );
  }
}
