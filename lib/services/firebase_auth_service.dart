import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  // Iniciar sesión con correo y contraseña
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Error al iniciar sesión');
    }
  }

  // Registrar un nuevo usuario con correo y contraseña
  Future<void> signUp(String email, String password) async {
    try {
      final userCred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCred.user!.uid;
      await _firestore.collection('usuarios').doc(uid).set({
        'email': email,
        'creadoEn': FieldValue.serverTimestamp(),
        'actualizadoEn': FieldValue.serverTimestamp(),
        'usuario': 'Usuario',
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Error al registrar usuario');
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  // Iniciar sesión con Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      // Paso 1: Iniciar el flujo de autenticación con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        throw Exception('Inicio de sesión cancelado por el usuario');
      }

      // Paso 2: Obtener la autenticación del usuario de Google
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Paso 3: Crear la credencial para Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Paso 4: Iniciar sesión con Firebase usando la credencial de Google
      final UserCredential userCred = await _firebaseAuth.signInWithCredential(
        credential,
      );

      final String uid = userCred.user!.uid;
      final String email = userCred.user!.email ?? '';

      // Paso 5: Crear usuario si no existe
      await _firestore.collection('usuarios').doc(uid).set({
        'email': email,
        'creadoEn': FieldValue.serverTimestamp(),
        'actualizadoEn': FieldValue.serverTimestamp(),
        'usuario': 'Usuario',
      });

      return userCred;
    } catch (e) {
      throw Exception('Error al iniciar sesión con Google: $e');
    }
  }
}
