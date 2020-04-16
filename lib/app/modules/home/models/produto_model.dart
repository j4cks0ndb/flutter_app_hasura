import 'dart:convert';

class ProdutoModel {
    final String id;
    final String nome;
    final double valor;
    final AtributoGenerico tipoProduto;
    final AtributoGenerico categoriaProduto;

    ProdutoModel({
        this.id,
        this.nome,
        this.valor,
        this.tipoProduto,
        this.categoriaProduto,
    });

    ProdutoModel copyWith({
        String id,
        String nome,
        double valor,
        AtributoGenerico tipoProduto,
        AtributoGenerico categoriaProduto,
    }) => 
        ProdutoModel(
            id: id ?? this.id,
            nome: nome ?? this.nome,
            valor: valor ?? this.valor,
            tipoProduto: tipoProduto ?? this.tipoProduto,
            categoriaProduto: categoriaProduto ?? this.categoriaProduto,
        );

    factory ProdutoModel.fromJson(String str) => ProdutoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProdutoModel.fromMap(Map<String, dynamic> json) => ProdutoModel(
        id: json["id"],
        nome: json["nome"],
        valor: json["valor"].toDouble(),
        tipoProduto: AtributoGenerico.fromMap(json["tipo_produto"]),
        categoriaProduto: AtributoGenerico.fromMap(json["categoria_produto"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "valor": valor,
        "tipo_produto": tipoProduto.toMap(),
        "categoria_produto": categoriaProduto.toMap(),
    };

    static List<ProdutoModel> fromJsonList(List list){
      if (list == null){
        return null;        
      }
      return list.map<ProdutoModel>((item) => ProdutoModel.fromMap(item)).toList();

    }
}

class AtributoGenerico {
    final String descricao;

    AtributoGenerico({
        this.descricao,
    });

    AtributoGenerico copyWith({
        String descricao,
    }) => 
        AtributoGenerico(
            descricao: descricao ?? this.descricao,
        );

    factory AtributoGenerico.fromJson(String str) => AtributoGenerico.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AtributoGenerico.fromMap(Map<String, dynamic> json) => AtributoGenerico(
        descricao: json["descricao"],
    );

    Map<String, dynamic> toMap() => {
        "descricao": descricao,
    };
}
