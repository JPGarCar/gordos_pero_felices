import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';

import '../constants.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Cerrar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  height: 90,
                  child: Image.asset(
                    'images/gordos_logo.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SimpleTextButton(
                  text: 'GORDOS PERO FELICES',
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SimpleTextButton(
                text: 'Gordos Pero Felices Favoritos',
              ),
              SimpleTextButton(
                text: 'Restaurantes por Categoría',
              ),
              SimpleTextButton(
                text: 'Restaurantes por Ubicación',
              ),
              SimpleTextButton(
                text: 'Cerrar Sesión',
              ),
            ],
          ),
        ],
      ),
    );
  }
}