import 'package:app_hasura/app/modules/home/models/produto_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HomeRepository extends Disposable {
  final HasuraConnect _hasuraConnect;

  HomeRepository(this._hasuraConnect);
  
  //Future<List<ProdutoModel>> getProduto() async {
  Stream<List<ProdutoModel>> getProduto()  {
    var query = """
      query getProdutos {
        produto {
          id
          nome
          valor
          tipo_produto {
            descricao
          }
          categoria_produto {
            descricao
          }    
        }
      }
     """;

     var query2 = """
      subscription getProdutos {
        produto {
          id
          nome
          valor
          tipo_produto {
            descricao
          }
          categoria_produto {
            descricao
          }    
        }
      }
     """;

    //var snapshot = await _hasuraConnect.query(query);
    var snapshot = _hasuraConnect.subscription(query2);

    //return ProdutoModel.fromJsonList(snapshot["data"]["produto"] as List);
    return snapshot.map((data)=>ProdutoModel.fromJsonList(data["data"]["produto"]))  ;

     
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
