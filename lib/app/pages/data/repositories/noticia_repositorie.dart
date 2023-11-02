import 'dart:convert';

import 'package:noticias/app/pages/data/http/exceptions.dart';
import 'package:noticias/app/pages/data/http/http_client.dart';
import 'package:noticias/app/pages/data/models/noticia_model.dart';

abstract class INoticiaReposity{
  Future<List<NoticiaModel>> getNoticias();
}

class NoticiaReposity implements INoticiaReposity{

  final IHttpClient client;

  NoticiaReposity({required this.client});

  @override
  Future<List<NoticiaModel>> getNoticias() async {

    final response =  await client.get(url: 'http://servicodados.ibge.gov.br/api/v3/noticias');

  if (response.statusCode == 200) {
    final List<NoticiaModel> noticia_list = [];

    final body = jsonDecode(response.body);

    body['items'].map((item){
      final NoticiaModel noticias = NoticiaModel.fromMap(item);
      noticia_list.add(noticias);
    }).toList();
    return noticia_list;
  } else if(response.statusCode == 404){
    throw NotFoundExcepition('A url informada não é valida!!!');
  } else {
    throw Exception('Erro não identificado!!!');
  }
    
  }

}