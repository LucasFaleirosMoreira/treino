class Usuarios{
  String usuario;
  String senha;


  Usuarios({required this.usuario, required this.senha});

  factory Usuarios.fromJson(Map<String, dynamic> json){
    return Usuarios(
      usuario: json['nome'],
      senha: json['freq'].toString(),
      
      );
  }

}