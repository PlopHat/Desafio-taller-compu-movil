import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PaginaDesafio extends StatefulWidget {
  @override
  _PaginaDesafioState createState() => _PaginaDesafioState();
}

class _PaginaDesafioState extends State<PaginaDesafio> {
  late TextEditingController _controladorTexto; // Declaramos sin inicializar

  static final Logger _logger = Logger(); // Instancia de Logger
  String _resultado = ''; // Variable que almacena el resultado

  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador en initState
    _controladorTexto = TextEditingController();
    _logger.i("Página Desafío inicializada");
  }

  // Método que procesa el texto ingresado
  void _procesarTexto() {
    _logger.i('Usuario presionó el botón Procesar');
    String entrada = _controladorTexto.text.toLowerCase(); // evita discriminar entre mayúsculas y minúsculas (todas minúsculas)
    List<String> listaResultados = []; // Lista que almacenará cada letra y su conteo en formato "[letra][cantidad]"
    
    // Creamos una lista de 26 elementos, inicializados en 0, que corresponden a las letras a-z sin contar la ñ
    List<int> contadorLetras = List<int>.filled(26, 0);

    // Incrementa el contador de la letra en su índice correspondiente
    for (var caracter in entrada.runes) { // Lo buscamos en google xd, pero al parecer itera los datos de las letras en unicode
      String letra = String.fromCharCode(caracter);
      if (letra.contains(RegExp(r'[a-z]'))) { 
        int index = letra.codeUnitAt(0) - 'a'.codeUnitAt(0); // Calcula el índice de la letra en la lista
        contadorLetras[index]++;
      }
    }

    // Convertimos el conteo al formato [letra][cantidad]
    for (int i = 0; i < 26; i++) {
      if (contadorLetras[i] > 0) {
        _logger.i(contadorLetras[i]); // está contando las letras correctamente?
        String letra = String.fromCharCode(i + 'a'.codeUnitAt(0));
        listaResultados.add('$letra${contadorLetras[i]}');
      }
    }

    setState(() {
      _resultado = listaResultados.join(''); // Une los elementos de la lista en una cadena
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0), //para que no se pegue en los bordes de la pantalla
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos
          children: [
            TextField(
              controller: _controladorTexto, // asignamos el controlador de texto para poder procesarlo
              decoration: const InputDecoration(
                labelText: 'Ingrese texto para contar los caracteres de a-z',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))), // pa que se vea bonito y redondito
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton( // botón para procesar el texto
              onPressed: _procesarTexto,
              child: const Text('Procesar'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Resultado: $_resultado',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Evita memory leaks dentro de los widgets dinámicos
  @override
  void dispose() {
    _logger.i("Página Desafío liberada");
    _controladorTexto.dispose(); // Liberamos el controlador de texto
    super.dispose();
  }
}
