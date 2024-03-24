import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shiksha_dhra/app/env_config.dart';

part 'appwrite_auth_service.g.dart';

@riverpod
Client client(ClientRef ref) {
  return Client()
      .setEndpoint(EnvironmentConfig.PROJECT_ENDPOINT)
      .setProject(EnvironmentConfig.PROJECT_ID)
      .setSelfSigned(status: true);
}

@riverpod
AppwriteAuthService appwriteAuthService(AppwriteAuthServiceRef ref) {
  return AppwriteAuthService(ref);
}

class AppwriteAuthService {
  final Ref ref;
  final Account _account;
  final GoogleSignIn _googleSignIn;
  AppwriteAuthService(this.ref)
      : _account = Account(ref.read(clientProvider)),
        _googleSignIn = GoogleSignIn(
          clientId: EnvironmentConfig.CLIENT_ID,
          scopes: ['email'],
        );

  Future<User?> getCurrentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() {
    return _account.deleteSession(sessionId: 'current');
  }

  Future<GoogleSignInAuthentication?> _getGoogleSignInCredentials() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    return await googleUser.authentication;
  }

  Future<Session?> signInWithGoogle() async {
    final googleAuthCreds = await _getGoogleSignInCredentials();
    if (googleAuthCreds?.accessToken == null) return null;
    final session = await _account.createSession(
      userId: ID.unique(),
      secret: googleAuthCreds!.accessToken!,
    );
    return session;
  }

  Future<Session?> signInWithGoogleAppWrite() async {
    final session = await _account.createOAuth2Session(
      provider: OAuthProvider.google,
      success: 'http://localhost:5000/splash',
      scopes: ['email'],
    );
    return session;
  }

  Future<Token> createPhoneSession(String phoneNumber) async {
    final session = await _account.createPhoneToken(
      phone: phoneNumber,
      userId: ID.unique(),
    );
    return session;
  }

  Future<Session?> signInWithPhone(String userId, String secret) async {
    final session = await _account.updatePhoneSession(
      userId: userId,
      secret: secret,
    );
    return session;
  }
}
