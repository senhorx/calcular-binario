import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String resultado;

  TextEditingController ope = TextEditingController();
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();

  _calculaBinario(int num){
    int decimal_value=num; //decimal value
    int binary_value = 0;
    int i = 1;
    while(decimal_value > 0)
    {
      binary_value = binary_value + (decimal_value % 2)*i;
      decimal_value = (decimal_value/2).floor();
      i = i * 10;
    }
    return binary_value;
  }

  _calculaResultado(String o,String v1,String v2){

    if(o=="" || v1 =="" || v2==""){
      setState(() {
        resultado = "Os valores não podem estar em branco";
      });
      return;
    }

    int valor1 = int.tryParse(v1,radix: 2);
    int valor2 = int.tryParse(v2,radix: 2);
    int r;

    if(valor1>255 || valor1<0 || valor2>255 || valor2<0){
      setState(() {
        resultado = "Insira os valores corretamente";
      });
    }else{
      if(o=="+"){
        r = valor1+valor2;
      }else if(o=="-"){
        r = valor1-valor2;
      }else if(o=="/"){
        double v = valor1/valor2;
        r = int.parse(v.toString());
      }else if(o=="*"){
        r = valor1*valor2;
      }else if(o=="%"){
        r = valor1%valor2;
      }else{
        r = null;
      }

      if(r==null){
        setState(() {
          resultado = "Digite um operador válido";
        });
      }else{
        int v = _calculaBinario(r);
        resultado = v.toString();
        int cont  = 8-resultado.length;
        String concatena = "";
        while(cont>0){
          concatena+="0";
          cont--;
        }
        concatena += resultado;
        setState(() {
          resultado = concatena;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          "Desafio - Questão 2",
          style: TextStyle(color: Colors.blue, fontSize: 28,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: ope,
                      decoration: InputDecoration(
                          hintText: "Operador",
                          hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: num1,
                      decoration: InputDecoration(
                          hintText: "Numero binário 1",
                          hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: num2,
                      decoration: InputDecoration(
                          hintText: "Numero binário 2",
                          hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _calculaResultado(ope.text, num1.text, num2.text);
                    },
                    color: Colors.blue,
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  resultado == null
                      ? Container()
                      : Padding(
                    padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Text(
                      "Resultado: "+resultado,
                      style: TextStyle(color: Colors.black, fontSize: 28),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
