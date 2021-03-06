import 'package:app_hasura/app/modules/home/models/produto_model.dart';
import 'package:app_hasura/app/modules/home/repositories/home_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {

  final HomeRepository _repository;
  _HomeControllerBase(this._repository){

    //_repository.getProduto().then((data) => listaProdutos = data);
    listaProdutos = ObservableStream(_repository.getProduto());
  }

  
  //List<ProdutoModel> listaProdutos = [];
  @observable
  ObservableStream<List<ProdutoModel>> listaProdutos;


}