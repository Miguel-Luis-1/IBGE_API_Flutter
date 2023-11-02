import 'package:flutter/material.dart';
import 'package:noticias/app/pages/data/http/exceptions.dart';
import 'package:noticias/app/pages/data/models/noticia_model.dart';
import 'package:noticias/app/pages/data/repositories/noticia_repositorie.dart';

class NoticiaStore{

  final INoticiaReposity repository;
  NoticiaStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<NoticiaModel>> state = ValueNotifier<List<NoticiaModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  

  Future getNoticias() async{

    isLoading.value = true;

    try {

      final result = await repository.getNoticias();
      state.value = result;
      
    } on NotFoundExcepition catch (e){

      erro.value = e.message;

    }
    catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;

  }

}