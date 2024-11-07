import 'package:flutter/material.dart';
import 'package:treino/model/model_usuarios.dart';
import 'package:treino/service/service_usuarios.dart';



class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  List<Usuarios> _usuarios = [];
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    fetchUsuarios().then((usuarios) {
      setState(() {
        _usuarios = usuarios; // Atualiza a lista de usuários
      });
    }).catchError((error) {
      // Trate erros ao buscar usuários
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar usuários')),
      );
    });
  }

  void verificarLogin(BuildContext context) {

    String usuarioDigitado = usuarioController.text;
    String senhaDigitada = senhaController.text;


    if (usuarioDigitado.isEmpty || senhaDigitada.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Inicia o loading
    });

    Future.delayed(Duration(seconds: 1), () { // Simulação de delay para feedback
      bool usuarioValido = _usuarios.any((u) => u.usuario == usuarioDigitado && u.senha == senhaDigitada);

      setState(() {
        _isLoading = false; // Para o loading
      });


    if (usuarioValido) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/principal');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha incorretos!'),
          backgroundColor: Colors.red,
          ),
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: TextField(
                controller: usuarioController,
                decoration: InputDecoration(
                  labelText: 'USUÁRIO',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: TextField(
                controller: senhaController,
                decoration: InputDecoration(
                  labelText: 'SENHA',
                  
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : () => verificarLogin(context),
              child: _isLoading ? CircularProgressIndicator() : Text('ENTRAR'),
            ),
          ],
        ),
      ),
    );
  }
}
