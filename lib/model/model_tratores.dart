class Tratores{
  String nome;
  String id;

  Tratores({required this.nome, required this.id});

  factory Tratores.fromJson(Map<String, dynamic> json){
    return Tratores(
      nome: json['nome'],
      id: json['freq'].toString(),
    );
  }
  
}


