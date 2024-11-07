import 'package:flutter/material.dart';
import 'package:treino/model/model_tratores.dart';
import 'package:treino/service/service_tratores.dart';

class Telaprincipal extends StatefulWidget {
  const Telaprincipal({super.key});

  @override
  State<Telaprincipal> createState() => _TelaprincipalState();
}

class _TelaprincipalState extends State<Telaprincipal> {
  bool botaoPressionado = false;
  String? valorSelecionado;
  late Future<List<Tratores>> listaTratores;
  String? quantidade;
  final TextEditingController quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listaTratores = fetchTratoress(); // Chama a função para buscar os tratores
  }

  void habilitarBotao() {
    setState(() {
      botaoPressionado = true;
      valorSelecionado = null;
      quantidade = null;
      quantidadeController.clear();
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        botaoPressionado = false;
      });
    });
  }

  bool botaoHabilitado() {
    return valorSelecionado != null && quantidade != null && quantidade!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela principal'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<Tratores>>(
                  future: listaTratores,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erro ao carregar tratores');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Nenhum trator disponível');
                    }

                    final tratores = snapshot.data!;

                    return Column(
                      children: [
                        Container(
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Selecione uma opção',
                            ),
                            value: valorSelecionado,
                            onChanged: (newValue) {
                              setState(() {
                                valorSelecionado = newValue;
                              });
                            },
                            items: tratores.map((Tratores trator) {
                              return DropdownMenuItem<String>(
                                value: trator.id,
                                child: Text(trator.id),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: quantidadeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Insira a quantidade',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      quantidade = value.toString();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: botaoPressionado || !botaoHabilitado() ? null : habilitarBotao,
                  child: Text('ABASTECER'),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              icon: Icon(Icons.exit_to_app_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
