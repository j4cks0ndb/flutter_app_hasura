import 'dart:convert';
import 'dart:ffi';

import 'package:app_hasura/app/modules/add_produto/repositories/add_produto_repository.dart';
import 'package:app_hasura/app/modules/home/home_controller.dart';
import 'package:app_hasura/app/modules/home/models/produto_model.dart';
import 'package:app_hasura/app/modules/home/repositories/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'models/tipo_categoria_produto_dto.dart';

part 'add_produto_controller.g.dart';

class AddProdutoController = _AddProdutoControllerBase
    with _$AddProdutoController;

abstract class _AddProdutoControllerBase with Store {

  final AddProdutoRepository addProdutoRepository;

  HomeController homeController = Modular.get();

  _AddProdutoControllerBase(this.addProdutoRepository){
    addProdutoRepository.getTipoCategoriaProduto().then((data){
      tipoProduto = data;
    });
  }

  @observable
  String descricao = "";
  @action
  setDescricao(String _value){
    descricao = _value;
  }
  
  @observable
  String valor = "";
  @action
  setValor(String _value){
    valor = _value;
  }

  @observable
  TipoECategoriaDto selectedTipo; 
  @action
  setSelectedTipo(TipoECategoriaDto _value){
    selectedTipo = _value;
  }

  @observable
  TipoECategoriaDto selectedCategoria;
  @action
  setSelectedCategoria(TipoECategoriaDto _value){
    selectedCategoria = _value;
  }

  @observable
  TipoCategoriaProdutoDto tipoProduto; 

  @action
  Future<bool> salvar() async{

    if (descricao != null && 
        valor != null && 
        selectedTipo?.id != null && 
        selectedCategoria?.id != null){ 
          var result = await addProdutoRepository.addProduto(descricao,valor,selectedTipo.id,selectedCategoria.id);
          /*
          if (result) {
            homeController.listaProdutos.add(ProdutoModel(id: "teste"
              , categoriaProduto: TipoOuCategoriaDto.fromMap({"descricao":selectedCategoria.descricao})
              ,tipoProduto: TipoOuCategoriaDto.fromMap({"descricao":selectedCategoria.descricao})  
              ,valor: double.parse(valor) )
            );
          }*/
          return result;
        }
    return false;
  }

 
}
