import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      // ignore: avoid_print
      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)}kg)";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)}kg)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)}kg)";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)}kg)";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)}kg)";
      } else if (imc >= 40) {
        _infoText = "Obesiade Grau III (${imc.toStringAsPrecision(3)}kg)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculadora de IMC'),
        actions: <Widget>[
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/img/teste.png',
                  height: 120,
                  color: Colors.lime,
                ),
                const SizedBox(
                  height: 10,
                ),

                //Peso
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    maxLength: 4,

                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Insira seu Peso";
                      }
                    },
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.lime),
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.lime),
                      counterStyle: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),

                //Altura
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    maxLength: 3,
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Insira sua Altura";
                      }
                    },
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.lime),
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.lime),
                      counterStyle: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _calculate();
                            }
                          },
                          child: const Text('Calcular'),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _infoText,
                  style: const TextStyle(color: Colors.lime),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
