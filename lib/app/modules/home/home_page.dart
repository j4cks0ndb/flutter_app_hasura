import 'package:app_hasura/app/modules/home/widgets/card_produto/card_produto_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        bool result = false;
        await showDialog(context: context,
          child: AlertDialog(
            content: Text("Você deseja realmente sair?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Sim"),
                onPressed: (){
                  result = true;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Não"),
                onPressed: (){
                  result = false;
                  Navigator.of(context).pop();
                },
              )
          ],)
        );        
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("token", null);
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/auth');
            })
          ],
        ),
        body: Observer(
          builder: (_){
            if(controller.listaProdutos.hasError){
              return Center(child: Text("Erro ao buscar dados"),);
            }

            if(controller.listaProdutos.value == null){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: controller.listaProdutos.value.length,
              itemBuilder: (BuildContext context, int index){
                return CardProdutoWidget(
                  categoriaProduto: controller.listaProdutos.value[index].categoriaProduto.descricao,
                  nomeProduto: controller.listaProdutos.value[index].nome,
                  tipoProduto: controller.listaProdutos.value[index].tipoProduto.descricao,
                  valor: controller.listaProdutos.value[index].valor.toString(),
                  );
                }
              );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Modular.to.pushNamed("/AddProduto");
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
