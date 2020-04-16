import 'package:app_hasura/app/shared/custom_combobox/custom_combobox_widget.dart';
import 'package:app_hasura/app/shared/widgets/label/label_widget.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'add_produto_controller.dart';

class AddProdutoPage extends StatefulWidget {
  final String title;
  const AddProdutoPage({Key key, this.title = "Adicionar Produto"}) : super(key: key);

  @override
  _AddProdutoPageState createState() => _AddProdutoPageState();
}

class _AddProdutoPageState
    extends ModularState<AddProdutoPage, AddProdutoController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabelWidget(title: "Descrição:"),
            TextField(
              decoration: InputDecoration(
                labelText: "Descrição do Produto",
                //hintText: "Descrição do Produto",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                  )
                )
              ),
            ),
            LabelWidget(title: "Categoria do Produo:"),
            CustomComboboxWidget(
              items: [
                Model("01", "Teste01"),
                Model("02", "Teste02"),
                Model("03", "Teste03"),
                Model("04", "Teste04"),
              ],
              onChange: (item){
                print(item.descricao);
              },
              itemSelecionado: Model("01", "Teste01"),
            ),
            LabelWidget(title: "Tipo Produto:"),
            CustomComboboxWidget(
              items: [
                Model("01", "Teste01"),
                Model("02", "Teste02"),
                Model("03", "Teste03"),
                Model("04", "Teste04"),
              ],
              onChange: (item){
                print(item.descricao);
              },
              itemSelecionado: Model("01", "Teste01"),
            ),
            LabelWidget(title: "Valor:"),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Valor",
                //hintText: "Descrição do Produto",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                  )
                )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,              
              padding: EdgeInsets.all(8),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: (){

                },
                child: Text("Salvar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
