import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/about_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({Key? key}) : super(key: key);

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35),
              Image.asset("assets/imagens/labmaker-navbar2.jpg"),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Área de agendamento',
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 61, 96, 47),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildImageItem('assets/imagens/arduinokit.jpg', 'Kit de Arduino'),
                  buildImageItem('assets/imagens/cortadora-laser.jpg', 'Cortadora a laser'),
                  buildImageItem('assets/imagens/CR5proh.jpg', 'Impressora 3D CR5 Pro H'),
                  buildImageItem('assets/imagens/grmax5.jpg', 'Impressora 3D GR MAX5'),
                  buildImageItem('assets/imagens/furadeira.jpg', 'Furadeira'),
                  buildImageItem('assets/imagens/ferro-de-solda.png', 'Ferro de Solda'),
                ].map((Widget item) {
                  return Padding(
                    padding: EdgeInsets.all(20.0), // Espaçamento desejado
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0), // Raio do arredondamento
                      child: item,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              color: Colors.black,
            ),
            BottomAppBar(
              child: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildIconContainer(Icons.explore, 0),
                    buildIconContainer(Icons.person, 1),
                    buildIconContainer(Icons.help_outline, 2),
                  ],
                ),
              ),
              elevation: 1,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconContainer(IconData icon, int index) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AboutPage()),
            );
          }
          else if(index == 0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.green[700] : Colors.white,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.green[700],
            size: 35,
          ),
        ),
      ),
    );
  }

  Widget buildBox(IconData icon, String text, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.70,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(String text) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.grey,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildImageItem(String imagePath, String text) {
  return SingleChildScrollView(
    child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                
              ),
              
            ),
            
          ),
          
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}



}
