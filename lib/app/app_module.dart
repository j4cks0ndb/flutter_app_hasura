import 'package:app_hasura/app/shared/custom_combobox/custom_combobox_controller.dart';
import 'package:app_hasura/app/app_controller.dart';
import 'package:app_hasura/app/modules/add_produto/add_produto_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:app_hasura/app/app_widget.dart';
import 'package:app_hasura/app/modules/home/home_module.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        //controllers
        Bind((i) => CustomComboboxController()),
        Bind((i) => AppController()),
        //Outros
        Bind((i) => HasuraConnect("https://coalatodohasura.herokuapp.com/v1/graphql")),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: HomeModule()),
        Router('/AddProduto', module: AddProdutoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
