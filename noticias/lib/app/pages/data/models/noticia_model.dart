class NoticiaModel{

  final String titulo;
  final String introducao;
  final String link;
  final String dataPublicacao;

  NoticiaModel({
    required this.dataPublicacao,
    required this.titulo, 
    required this.introducao, 
    required this.link,
    });

  factory NoticiaModel.fromMap(Map<String, dynamic> map){
    return NoticiaModel(
      dataPublicacao: map['data_publicacao'],
      titulo: map['titulo'], 
      introducao: map['introducao'], 
      link: map['link'],
      );
  }

}