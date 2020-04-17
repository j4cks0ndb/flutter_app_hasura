import 'package:app_hasura/app/modules/add_produto/models/tipo_categoria_produto_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AddProdutoRepository extends Disposable {
  final HasuraConnect _hasuraConnect;

  AddProdutoRepository(this._hasuraConnect);

  Future<TipoCategoriaProdutoDto> getTipoCategoriaProduto() async {
    var query = """
      query getTipoCategoriaProduto {
        tipo_produto {
            id
            descricao
          }
          categoria_produto {
            id
            descricao
          }  
      }
    """;

    var snapshot = await _hasuraConnect.query(query);

    return TipoCategoriaProdutoDto.fromMap(snapshot["data"]);

  }  

  Future<bool> addProduto(String descricao, String valor, String tipo, String categoria) async {
    var mutation = """
      mutation addProduto(\$nome: String, \$valor: float8, \$tipo: uuid, \$categoria: uuid) {
        insert_produto(objects: {nome: \$nome, valor: \$valor, tipo_produto_id: \$tipo, categoria_produto_id: \$categoria}) {
          affected_rows
        }
      }
    """;
    var snapshot;
    try {
      snapshot = await _hasuraConnect.mutation(mutation, variables: {
      "nome":descricao,
      "categoria":categoria,
      "tipo":tipo,
      "valor":valor
    });
    return snapshot["data"]["insert_produto"]["affected_rows"] == 1;
    } catch (e) {
      print(e.toString());
      return false;
    } 
    

    

  }  

  //dispose will be called automatically
  @override
  void dispose() {}
}
