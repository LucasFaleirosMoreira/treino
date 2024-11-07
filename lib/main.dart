import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:treino/views/telaLogin.dart';
import 'package:treino/views/telaPrincipal.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste',
      initialRoute: '/login',
      routes: {
        '/login': (context) => TelaLogin(),
        '/principal': (context) => Telaprincipal(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => TelaLogin()); // ou uma tela de erro
      },
      
        );
  }
}
