import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'file:///C:/Users/juapg/_Programming_Projects/AndroidStudioProjects/GordosPeroFelizes/gordos_pero_felizes/lib/screens/admin/admin_panel_screen.dart';
import 'package:gordos_pero_felizes/screens/categories_screen.dart';
import 'package:gordos_pero_felizes/screens/initial_screen.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: k_appPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleTextButton(
                verticalPadding: 0,
                onTapCallBack: () => Navigator.pop(context),
                text: 'Cerrar',
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 90,
                      child: Image.asset(
                        'images/gordos_logo.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SimpleTextButton(
                      text: 'GORDOS PERO FELICES',
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SimpleTextButton(
                    onTapCallBack: () => Navigator.popAndPushNamed(
                        context, CategoriesScreen.screenId),
                    text: 'Restaurantes por Categoría',
                  ),
                  /*SimpleTextButton(
                    text: 'Juega con la Ruleta Gordos',
                  ),
                  SimpleTextButton(
                    text: 'Toma nuestro Gordo Quiz',
                  ),
                  SimpleTextButton(
                    text: 'Antojate con el Gordo Date',
                  ),*/
                  SimpleTextButton(
                    text: 'Preguntas Frequentes',
                  ),
                  SimpleTextButton(
                    text: 'Contacto para Negocios',
                  ),
                  Provider.of<AppUser>(context, listen: false).isAdmin
                      ? SimpleTextButton(
                          text: 'Panel de Admin',
                          onTapCallBack: () => Navigator.popAndPushNamed(
                              context, AdminPanelScreen.screenId),
                        )
                      : SizedBox(),
                  SimpleTextButton(
                    onTapCallBack: () {
                      _auth.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, InitialScreen.screenId, (route) => false);
                    },
                    text: 'Cerrar Sesión',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
