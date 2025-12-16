import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../services/firebase_auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<GoogleSignInRequested>(_googleSignInRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = _authService.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user.uid));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signIn(event.email, event.password);
      final user = _authService.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user.uid));
      } else {
        emit(const AuthError('No se pudo obtener la información del usuario'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signUp(event.email, event.password);
      final user = _authService.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user.uid));
      } else {
        emit(const AuthError('No se pudo obtener la información del usuario'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _googleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authService.signInWithGoogle();
      final user = _authService.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user.uid));
      } else {
        emit(const AuthError('No se pudo obtener la información del usuario'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }
}
