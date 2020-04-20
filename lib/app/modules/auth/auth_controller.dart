import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {

  final SharedPreferences shared;
  
  _AuthControllerBase(this.shared);

  @observable
  String email = "";

  @observable
  String senha = "";

    @observable
  String emailError;

  @observable
  String senhaError;

  

  @action
  void setEmail(String _email) {
       email = _email;
  }

  @action
  void setSenha(String _senha) => senha = _senha;

  @action
  Future<bool> login() async {

    email = email.trim();
    senha = senha.trim();

    var valid = true;

    if (email == null || !email.contains("@")){
      emailError = "Email inválido!";
      valid = false;
    }else{
      email = null;
    }

    if (senha == null || senha.length == 0){
      senhaError = "Senha inválido!";
      valid = false;
    }else{
      senha = null;
    }

    if(!valid){
      return false;
    }


    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    )).user;
    var tokenId = await user.getIdToken();
    valid = tokenId != null;
    if (valid){
      shared.setString("token", tokenId.token);
    }

    return valid != null;
  }
}
