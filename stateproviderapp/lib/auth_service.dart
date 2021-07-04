import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum KullaniciDurumu{
  OturumAcilmis,
  OturumAcilmamis,
  OturumAciliyor
}

class AuthService with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  KullaniciDurumu _durum = KullaniciDurumu.OturumAcilmamis;
  User _user;


  User get user => _user;
  KullaniciDurumu get durum => _durum;

  set durum(KullaniciDurumu value) {
    _durum = value;
    notifyListeners();
  }

  AuthService(){

    _auth.authStateChanges().listen(_authStateChanged);
  }


  void _authStateChanged(User user) {

    if(user == null){
      _user = null;
      durum = KullaniciDurumu.OturumAcilmamis;
    }else{
      durum = KullaniciDurumu.OturumAcilmis;
      _user = user;
    }
  }

  Future<User> createUserWithEmailAndPassword(String email, String password) async {

    try{
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User _yeniKullanici = _credential.user;
      _user = _yeniKullanici;
      return _yeniKullanici;
    }catch(e) {
      durum = KullaniciDurumu.OturumAcilmamis;
      debugPrint("Hata : $e");
      return null;
    }
  }

  Future<User> signinUserWithEmailAndPassword(String mail, String password) async {

    try{
      durum = KullaniciDurumu.OturumAciliyor;
      UserCredential _credential = await _auth.signInWithEmailAndPassword(email: mail, password: password);
      User _oturumAcanKullanici  = _credential.user;
      _user = _oturumAcanKullanici;
      return _oturumAcanKullanici;
    }catch(e) {
      durum = KullaniciDurumu.OturumAcilmamis;
      debugPrint("Hata: $e");
      return null;
    }
  }

  Future<bool> signOut() async{
    try{
      await _auth.signOut();
      durum = KullaniciDurumu.OturumAcilmamis;
      _user = null;
      return true;
    }catch(e) {
      debugPrint("Hata : $e");
      return false;
    }
  }

}