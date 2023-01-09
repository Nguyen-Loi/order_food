import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/core/service/get_navigation.dart';
import 'package:project_order_food/locator.dart';

abstract class BaseAuth {
  Future<String?> signIn(String email, String password);

  Future<UserCredential?> signUp(String email, String password);

  User? getCurrentUser();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<String?> changeEmail(String email);

  Future<void> changePassword(String password);

  Future<void> sendPasswordResetMail(String email);
}

class AuthenticationService implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } catch (e) {
      return 'Tài khoản hoặc mật khẩu không chính xác';
    }
  }

  @override
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential newUser = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return newUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        locator<GetNavigation>().openDialog(title: 'Mật khẩu yếu');
      } else if (e.code == 'email-already-in-use') {
        locator<GetNavigation>().openDialog(title: 'Email đã tồn tại');
      } else {
        locator<GetNavigation>()
            .openDialog(title: 'Thông tin đăng ký không hợp lệ $e');
      }
    } catch (e) {
      locator<GetNavigation>()
          .openDialog(title: 'Thông tin đăng ký không hợp lệ $e');
    }
    return null;
  }

  @override
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isEmailVerified() async {
    User? user = getCurrentUser();
    if (user != null) {
      return user.emailVerified;
    }
    logError('Email chưa đăng nhập');
    return false;
  }

  @override
  Future<String?> changeEmail(String email) async {
    User? user = getCurrentUser();
    if (user != null) {
      user.updateEmail(email).then((_) {
        return 'Thay đổi email thành công';
      }).catchError((error) {
        return 'Có vấn đề khi thay đổi email $error';
      });
    }
    return null;
  }

  @override
  Future<void> changePassword(String password) async {
    User? user = getCurrentUser();
    if (user != null) {
      user.updatePassword(password).then((_) {
        return 'Thay mật khẩu thành công';
      }).catchError((error) {
        return 'Lỗi khi thay đổi mật khẩu $error';
      });
    } else {
      logError('Lỗi chưa đăng nhập với tư cách User');
    }
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return;
  }
}
