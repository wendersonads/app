import 'package:auth_migration/base/model/abstract_entity.dart';
import 'fornecedor_model.dart';
import 'dart:convert';

class Produto extends AbstractEntity {
  int? idProduto;
  String? descricao;
  Fornecedor? fornecedor;

  Produto({
     this.idProduto,
     this.descricao,
     this.fornecedor,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      idProduto: map['idProduto'],
      descricao: map['descricao'],
      fornecedor: map['fornecedor'] != null
          ? Fornecedor.fromMap(map['fornecedor'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'idProduto': idProduto,
      'descricao': descricao,
      'fornecedor': fornecedor != null ? fornecedor!.toMap() : null,
    };
  }

  String toJson() => json.encode(toMap());

  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Produto(idProduto: $idProduto, descricao: $descricao, fornecedor: $fornecedor)';
  }
}
