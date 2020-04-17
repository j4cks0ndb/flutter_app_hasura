import 'package:app_hasura/app/modules/add_produto/models/tipo_categoria_produto_dto.dart';
import 'package:app_hasura/app/shared/custom_combobox/custom_combobox_widget.dart';
import 'package:app_hasura/app/shared/widgets/label/label_widget.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
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
              onChanged: controller.setDescricao,
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
            Observer(
              builder: (BuildContext context){

                if (controller.tipoProduto == null){
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      )                    
                    )
                  );
                }

                return CustomComboboxWidget(
                    items: controller.tipoProduto.categoriaProduto.map((data)=>Model(data.id,data.descricao)).toList(),
                    onChange: (item){
                      controller.setSelectedCategoria(TipoECategoriaDto(id: item.id, descricao: item.descricao));
                    },
                    itemSelecionado: null,
                  );
              }
            ),
            LabelWidget(title: "Tipo Produto:"),
            Observer(
              builder: (BuildContext context){

                if (controller.tipoProduto == null){
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      )                    
                    )
                  );
                }

                return CustomComboboxWidget(
                    items: controller.tipoProduto.tipoProduto.map((data)=>Model(data.id,data.descricao)).toList(),
                    onChange: (item){
                      controller.setSelectedTipo(TipoECategoriaDto(id: item.id, descricao: item.descricao));
                    },
                    itemSelecionado: null,
                  );
              }
            ),
            LabelWidget(title: "Valor:"),
            TextField(
              onChanged: controller.setValor,
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
                onPressed: () async {
                  var result = await controller.salvar();
                  if (result){
                    Navigator.of(context).pop();
                  }else{
                    showDialog(context: context,
                    child: AlertDialog(
                      content: Text("Erro ao tentar salvar o produto!"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Fechar"),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],

                    )
                    );
                  }
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
