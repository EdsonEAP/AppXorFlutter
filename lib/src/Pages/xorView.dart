import 'package:appxor/src/Pages/blocXor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextEditingController x1Controller = TextEditingController();
TextEditingController x2Controller = TextEditingController();
int animated = 1;
XorBloc xorBloc = XorBloc();

bool isChecked = false;

class XorView extends StatefulWidget {
  static const String name = "XorView";

  const XorView({Key? key}) : super(key: key);

  @override
  _XorViewState createState() => _XorViewState();
}

class _XorViewState extends State<XorView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(5, 163, 157, 1),
          title: Center(
            child: Container(
                child: Text(
              "OPERACIÓN XOR",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
          // Agregar un ícono de menú al AppBar
        ),
        body: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.09,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "-Jairo Daniel Mendoza Torres",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(5, 163, 157, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "-Edson Emanuel Alvarado Prieto",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(5, 163, 157, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.22,
                      child: Image.asset('assets/images/untels.png'),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "Ingrese los datos para realizar la operación XOR (0,1)",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  inputLogin(
                      seleccione: "X1:",
                      oculto: false,
                      controlador: x1Controller),
                  inputLogin(
                      seleccione: "X2:",
                      oculto: false,
                      controlador: x2Controller),
                  Center(
                    child: streamBotonReactive(context),
                  ),
                  StreamBuilder<int>(
                    stream: xorBloc.botonXorS,
                    builder:
                        (BuildContext context, AsyncSnapshot<int?> snapshot) {
                      return snapshot.data == 1 || snapshot.data == 0
                          ? Center(
                              child: Column(
                              children: [
                                Text(
                                  "El resultado de la operación XOR es: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${snapshot.data}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ))
                          : Text(
                              "",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                    },
                  ),
                ],
              ),
            )));
  }
}

inputLogin(
    {required String seleccione,
    required bool oculto,
    required TextEditingController controlador}) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(5, 163, 157, 1),
              width: 0.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          fillColor: Color.fromRGBO(230, 246, 245, 1),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(242, 242, 242, 1),
              width: 0.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          hintText: seleccione,
        ),
        obscureText: false,
        controller: controlador,
        style: TextStyle(fontSize: 18),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'[0-1]')), // Expresión regular para permitir solo 0, 1
        ],
      ));
}

streamBotonReactive(context) {
  final size = MediaQuery.of(context).size;
  return InkWell(
    onTap: () {
      xorBloc.requestLogin(context,
          x1: x1Controller.text, x2: x2Controller.text);
    },
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: size.width * 0.5,
        decoration: BoxDecoration(
          color: Color(0xFF05A39D),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                "EJECUTAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )),
  );
}
