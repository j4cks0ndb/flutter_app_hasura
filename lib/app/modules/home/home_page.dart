import 'package:app_hasura/app/modules/home/widgets/card_produto/card_produto_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_){
          return ListView.builder(
            itemCount: controller.listaProdutos.length,
            itemBuilder: (BuildContext context, int index){
              return CardProdutoWidget(
                categoriaProduto: controller.listaProdutos[index].categoriaProduto.descricao,
                nomeProduto: controller.listaProdutos[index].nome,
                tipoProduto: controller.listaProdutos[index].tipoProduto.descricao,
                valor: controller.listaProdutos[index].valor.toString(),
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
    );
  }
}
