import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:noticias/app/pages/data/http/http_client.dart';
import 'package:noticias/app/pages/data/repositories/noticia_repositorie.dart';
import 'package:noticias/app/pages/home/stores/noticia_store.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final NoticiaStore store = NoticiaStore(repository: NoticiaReposity(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    store.getNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Notícias IBGE',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge( [
          store.isLoading,
          store.erro,
          store.state,
        ]),
        builder: (context, child){
          if (store.isLoading.value == true) {
            
            return const Center(child: CircularProgressIndicator());
            
          }
          if (store.erro.value.isNotEmpty) {

            return Center(
              child: Text(
                store.erro.value,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            );
          }
          if (store.state.value.isEmpty) {
            
            return const Center(
              child: Text(
                'Nenhuma notícia na lista',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            );

          } else {

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding:  const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {

                final item = store.state.value[index];
                return Column(
                  children: [
                   ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.titulo,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,                        
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          item.dataPublicacao.split(' ')[0],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,                            
                          ),                          
                        ),
                        Text(
                          item.introducao,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,                            
                          ),
                        ),
                        Text(
                          'Link: ${item.link}',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,                            
                          ),
                        ),
                      ]),
                   ),
                  ],
                );
                
              },
            );

          }
        },
      ),
    );
  }
}