import 'package:app_hasura/app/shared/widgets/label/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';
import 'auth_controller.dart';

class AuthPage extends StatefulWidget {
  final String title;
  const AuthPage({Key key, this.title = "Auth"}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends ModularState<AuthPage, AuthController> {
  //use 'controller' variable to access controller

  var focusNodeEmail = FocusNode();
  var focusNodeSenha = FocusNode();

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future _login() async {
    var result = await controller.login();
    if (result) {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      showToast("Erro ao tentar efetuar o login! Tente novamente!", position: ToastPosition.bottom);                          
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height - 250,
            right: -50,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.4),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 200,
            right: 50,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 150,
            right: 150,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LabelWidget(
                    title: "Email:",
                  ),
                  Observer(builder: (_){
                    return TextField(
                      onEditingComplete: (){
                        _fieldFocusChange(context, focusNodeEmail, focusNodeSenha);
                      },
                      focusNode: focusNodeEmail,
                      onChanged: controller.setEmail,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "meuemail@email.com",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 2)),
                        errorText: controller.emailError
                      ),                      
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  LabelWidget(
                    title: "Senha:",
                  ),
                  TextField(
                    onEditingComplete: () async {
                        _login();
                      },
                    focusNode: focusNodeSenha,
                    obscureText: true,
                    onChanged: controller.setSenha,                    
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "******",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                       _login();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      child: Text("Criar nova Conta", style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/auth/register");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
