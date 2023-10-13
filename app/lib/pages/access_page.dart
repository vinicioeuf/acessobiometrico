import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/about_page.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
            children: [
              SizedBox(height: 35),
              Center(
                child: Image.asset("assets/imagens/labmaker-navbar2.jpg"),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Acessos ao LabMaker',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 61, 96, 47),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButton<String>(
                      value: '12/10/2023',
                      onChanged: (String? newValue) {},
                      items: <String>[
                        '12/10/2023',
                        '11/10/2023',
                        '10/10/2023',
                        '09/10/2023'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 1,
                        color: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 8,
                      dropdownColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/imagens/vicCarlos.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Álvaro Victor',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),                                
                                Text(
                                  'Bolsista',
                                  style: TextStyle(
                                      fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Entrou',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[700]),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          'ás 09:14',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              onPressed: () {
                                // Adicione a ação desejada para o botão
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ), // Defina a cor de fundo do botão
                              ),
                              child: Text(
                                'Ver mais',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/imagens/viniEufrazio.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vinicio Eufrazio',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),                                
                                Text(
                                  'Bolsista',
                                  style: TextStyle(
                                      fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Entrou',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[700]),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          'ás 08:22',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              onPressed: () {
                                // Adicione a ação desejada para o botão
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ), // Defina a cor de fundo do botão
                              ),
                              child: Text(
                                'Ver mais',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/imagens/PLemos.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pedro Lemos',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),                                
                                Text(
                                  'Coordenador do Lab',
                                  style: TextStyle(
                                      fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Entrou',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[700]),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          'ás 10:04',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              onPressed: () {
                                // Adicione a ação desejada para o botão
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ), // Defina a cor de fundo do botão
                              ),
                              child: Text(
                                'Ver mais',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/imagens/viniEufrazio.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vinicio Eufrazio',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),                                
                                Text(
                                  'Bolsista',
                                  style: TextStyle(
                                      fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Saíu',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[700]),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          'ás 12:08',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              onPressed: () {
                                // Adicione a ação desejada para o botão
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ), // Defina a cor de fundo do botão
                              ),
                              child: Text(
                                'Ver mais',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        
                      ),
                    ],
                  ),

                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/imagens/vicCarlos.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Álvaro Victor',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),                                
                                Text(
                                  'Bolsista',
                                  style: TextStyle(
                                      fontSize: 15.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Saíu',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[700]),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(
                                          'ás 13:23',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              onPressed: () {
                                // Adicione a ação desejada para o botão
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ), // Defina a cor de fundo do botão
                              ),
                              child: Text(
                                'Ver mais',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                        
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            if (index == 0) {
              index = 0;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (index == 1) {
              // Defina a rota para a página de perfil
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline),
              label: 'Sobre',
            ),
          ],
          selectedItemColor: Color.fromARGB(255, 87, 85, 85), // Define a cor dos ícones selecionados
        ),
      ),
    );
  }
}
