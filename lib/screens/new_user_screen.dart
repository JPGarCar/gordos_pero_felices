import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';

import '../constants.dart';

class NewUserScreen extends StatefulWidget {
  static final String screenId = 'newUserScreen';

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SimpleTextButton(
                text: 'Regresar',
                textStyle: TextStyle(
                  color: k_redColor,
                  fontWeight: FontWeight.w700,
                ),
                verticalPadding: 0,
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Container(
                  height: 90,
                  child: Image.asset(
                    'images/gordos_logo.png',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RedRoundedTextField(
                        hint: 'Nombre',
                        textEditingController: TextEditingController()),
                  ),
                  Expanded(
                    child: RedRoundedTextField(
                        hint: 'Apellido',
                        textEditingController: TextEditingController()),
                  ),
                ],
              ),
              RedRoundedTextField(
                hint: 'Correo Electrónico',
                textEditingController: TextEditingController(),
                isEmail: true,
              ),
              RedRoundedTextField(
                hint: 'Confirmar Correo',
                textEditingController: TextEditingController(),
                isEmail: true,
              ),
              RedRoundedTextField(
                hint: 'Contraseña',
                textEditingController: TextEditingController(),
                isPassword: true,
              ),
              RedRoundedTextField(
                hint: 'Confirmar Contraseña',
                textEditingController: TextEditingController(),
                isPassword: true,
              ),
              RedRoundedTextField(
                hint: 'Ciudad',
                textEditingController: TextEditingController(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text(
                      'Fecha de Nacimiento',
                      style: TextStyle(
                        color: k_redColor,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: RedRoundedTextField(
                              hint: 'DD',
                              textEditingController: TextEditingController(),
                              isCenterText: true,
                            ),
                          ),
                          Text(
                            '/',
                            style: TextStyle(
                              color: k_redColor,
                              fontSize: 40,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: RedRoundedTextField(
                              hint: 'MM',
                              textEditingController: TextEditingController(),
                              isCenterText: true,
                            ),
                          ),
                          Text(
                            '/',
                            style: TextStyle(
                              color: k_redColor,
                              fontSize: 40,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: RedRoundedTextField(
                              hint: 'YYYY',
                              textEditingController: TextEditingController(),
                              isCenterText: true,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RedRoundedButton(
                  onTapFunction: () {},
                  buttonText: 'Crear Usuario',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
