import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


enum Status { uninitialized, authenticated, authenticating, unauthenticated}

class UserProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  Status _status;
  User? _user;

  Status get status => _status;
  User? get user => _user;


  UserProvider()
  : firebaseAuth = FirebaseAuth.instance,
    _user = FirebaseAuth.instance.currentUser,
  // 삼항연산자로 status 표시
    _status = FirebaseAuth.instance.currentUser != null
        ? Status.authenticated
        : Status.unauthenticated {
    firebaseAuth.authStateChanges().listen(_onStateChanged);
    // FirebaseAuth 인스턴스에서 인증 상태가 변경될 때마다 이를 감지하고, 해당 변경사항에 대응하기 위해 _onStateChanged 메소드를 호출하는 역할
    // 여기서 인증 상태 변경이란 사용자가 로그인하거나 로그아웃하는 행위를 포함, 사용자의 인증 정보에 변동이 있는 경우 호출
  }

  Future<String> signUp(String email, String password) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      if (e.message!.contains("weak-password")){
        return "The password provided is too weak";
      } else if (e.message!.contains("email-already-in-use")){
        return "An account already exists for that email.";
      } else {
        return e.message!;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try{
      _status = Status.authenticating;
      notifyListeners();
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
      return 'Success';
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      if (e.message!.contains("user-not-found")) {
        return "No user found for that email.";
      } else if (e.message!.contains("wrong-password")) {
        return "Wrong password provided for that user.";
      } else {
        return e.message!;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
  }


  Future<void> _onStateChanged(User? user) async {
    if(user == null){
      _status = Status.unauthenticated;
    } else {
      _status = Status.authenticated;
    }
    notifyListeners();
  }

// * notifyListeners() : notifyListeners() 메서드는 Flutter의 상태 관리에서 중요한 역할
// 이 메서드는 주로 ChangeNotifier 클래스를 상속받은 객체 내에서 사용,객체의 상태가 변경되었음을 알리기 위해 호출됩니다.
// 상태가 변경되었다는 것을 알리면, Flutter 프레임워크는 해당 객체를 듣고 있는 위젯들에게 상태 변화를 알리고 위젯 재구성실시

}

