import 'dart:convert';
import 'package:app/pages/ver_acess_adm.dart';
import 'package:app/pages/ver_acesso.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  List<DogBreed> breeds = [];
  String sortBy = 'Recentes';
  String filterBy = 'Seus acessos';
  int? userCredential;
  DateTime? startDate;
  DateTime? endDate;
  bool isLoading = false; // Adicionado
  // bool showAllUsers = false;
  bool showFilterDropdown = true;
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();

  late bool _showCaseDisplayed;

  @override
  void initState() {
    super.initState();

    // Verifique se o ShowCase já foi exibido nas preferências compartilhadas
    _checkShowCaseStatus(context);
    fetchData();
    inicia();
  }

  Future<void> fetchDataByDateRange(DateTime startDate, DateTime endDate) async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await http.get(
      Uri.parse('https://api-labmaker.onrender.com/acessos'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> breedsList = data['acessos'];

      setState(() {
        breeds = breedsList.map((json) => DogBreed.fromJson(json)).toList();

        // Filtrar os acessos pelo intervalo de datas selecionado
        breeds = breeds.where((breed) {
          DateTime dateTime = DateTime.parse(breed.createdAt);
          dateTime = dateTime.subtract(Duration(hours: 3));
          return dateTime.isAfter(startDate.subtract(Duration(days: 1))) &&
              dateTime.isBefore(endDate.add(Duration(days: 1)));
        }).toList();

        // Se a opção "Seus acessos" estiver selecionada, filtrar para exibir apenas os acessos do usuário atual
        if (filterBy == 'Seus acessos') {
          breeds = breeds.where((breed) => breed.email == FirebaseAuth.instance.currentUser?.email).toList();
        }

        // Adicione esta verificação para inverter a ordem quando "Antigas" for selecionado
        if (sortBy == 'Antigos') {
          breeds.sort((a, b) {
            DateTime dateTimeA = DateTime.parse(a.createdAt);
            DateTime dateTimeB = DateTime.parse(b.createdAt);
            return dateTimeA.compareTo(dateTimeB);
          });
        }

        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    setState(() {
      isLoading = false;
    });
  }
}

Future<void> fetchDataByDateRangeForCurrentUser(DateTime startDate, DateTime endDate) async {
  setState(() {
    isLoading = true;
  });

  try {
    User? user = FirebaseAuth.instance.currentUser;
    final response = await http.get(
      Uri.parse('https://api-labmaker.onrender.com/acessos'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> breedsList = data['acessos'];

      setState(() {
        breeds = breedsList
            .map((json) => DogBreed.fromJson(json))
            .where((breed) => breed.email == user?.email)
            .toList();

        // Filtrar os acessos pelo intervalo de datas selecionado
        breeds = breeds.where((breed) {
          DateTime dateTime = DateTime.parse(breed.createdAt);
          dateTime = dateTime.subtract(Duration(hours: 3));
          return dateTime.isAfter(startDate.subtract(Duration(days: 1))) &&
              dateTime.isBefore(endDate.add(Duration(days: 1)));
        }).toList();

        // Adicione esta verificação para inverter a ordem quando "Antigas" for selecionado
        if (sortBy == 'Antigos') {
          breeds.sort((a, b) {
            DateTime dateTimeA = DateTime.parse(a.createdAt);
            DateTime dateTimeB = DateTime.parse(b.createdAt);
            return dateTimeA.compareTo(dateTimeB);
          });
        }

        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    setState(() {
      isLoading = false;
    });
  }
}



  Future<void> _checkShowCaseStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showcaseDisplayed = prefs.getBool('show_case_displayed_access') ?? false;

    if (!showcaseDisplayed) {
        // Exibe o ShowCase
        Future.delayed(Duration.zero, () {
            ShowCaseWidget.of(context).startShowCase([_one, _two]);
        });

        // Marca o ShowCase como exibido nas preferências compartilhadas
        prefs.setBool('show_case_displayed_access', true);
    }
}

  Future<void> fetchDataByDate(DateTime selectedDate) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker.onrender.com/acessos'),
      );

      if (mounted) {
        print(response.body);
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> breedsList = data['acessos'];

          setState(() {
            breeds = breedsList.map((json) => DogBreed.fromJson(json)).toList();

            // Filtrar os acessos pela data selecionada
            breeds = breeds.where((breed) {
              DateTime dateTime = DateTime.parse(breed.createdAt);
              dateTime = dateTime.subtract(Duration(hours: 3));
              return dateTime.day == selectedDate.day &&
                  dateTime.month == selectedDate.month &&
                  dateTime.year == selectedDate.year;
            }).toList();

            // Adicione esta verificação para inverter a ordem quando "Antigas" for selecionado
            if (sortBy == 'Antigos') {
              breeds.sort((a, b) {
                DateTime dateTimeA = DateTime.parse(a.createdAt);
                DateTime dateTimeB = DateTime.parse(b.createdAt);
                return dateTimeA.compareTo(dateTimeB);
              });
            }

            isLoading = false;
          });
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataByDate2(DateTime selectedDate2) async {
    setState(() {
      isLoading = true;
    });

    User? user = await FirebaseAuth.instance.authStateChanges().first;
    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker.onrender.com/acessos'),
      );

      if (mounted) {
        print(response.body);
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> breedsList = data['acessos'];

          setState(() {
            breeds = breedsList
                .map((json) => DogBreed.fromJson(json))
                .where((breed) => breed.email == user?.email)
                .toList();

            // Filtrar os acessos pela data selecionada
            breeds = breeds.where((breed) {
              DateTime dateTime = DateTime.parse(breed.createdAt);
              dateTime = dateTime.subtract(Duration(hours: 3));
              return dateTime.day == selectedDate2.day &&
                  dateTime.month == selectedDate2.month &&
                  dateTime.year == selectedDate2.year;
            }).toList();

            // Adicione esta verificação para inverter a ordem quando "Antigas" for selecionado
            if (sortBy == 'Antigos') {
              breeds.sort((a, b) {
                DateTime dateTimeA = DateTime.parse(a.createdAt);
                DateTime dateTimeB = DateTime.parse(b.createdAt);
                return dateTimeA.compareTo(dateTimeB);
              });
            }

            isLoading = false;
          });
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> inicia() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      String uid = user.uid;

      DatabaseReference starCountRef3 =
          FirebaseDatabase.instance.ref('users/$uid/credencial');
      starCountRef3.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        if (mounted) {
          setState(() {
            userCredential = data as int?;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // Certifique-se de cancelar qualquer operação assíncrona ou animação aqui
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    User? user = await FirebaseAuth.instance.authStateChanges().first;
    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker.onrender.com/acessos'),
      );

      if (mounted) {
        print(response.body);
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> breedsList = data['acessos'];

          setState(() {
            breeds = breedsList
                .map((json) => DogBreed.fromJson(json))
                .where((breed) => breed.email == user?.email)
                .toList();

// Adicione esta verificação para inverter a ordem quando "Antigas" for selecionado
            if (sortBy == 'Antigos') {
              breeds.sort((a, b) {
                DateTime dateTimeA = DateTime.parse(a.createdAt);
                DateTime dateTimeB = DateTime.parse(b.createdAt);
                return dateTimeA.compareTo(dateTimeB);
              });
            }

            isLoading = false;
          });
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchDataForAllUsers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://api-labmaker.onrender.com/acessos'),
      );

      if (mounted) {
        print(response.body);
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> breedsList = data['acessos'];

          setState(() {
            breeds = breedsList.map((json) => DogBreed.fromJson(json)).toList();
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    Widget getContent() {
      
      if (isLoading) {
        return Center(
          
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[800]!),
          ), // Indicador de progresso circular
        );
      } else if (breeds.isEmpty) {
        return Container(
          child: Showcase(
                      key: _two,
                      description:
                          'Seus acessos serão exibidos aqui!',
                      overlayOpacity: 0.5,
                      targetShapeBorder: const CircleBorder(),
                      targetPadding: const EdgeInsets.all(3),
                      child: Center(
            child: Text(
              'Você não acessou o LabMaker ainda',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
                    ),
        );
      } else {
        return ListView.builder(
          
          itemCount: breeds.length,
          itemBuilder: (context, index) {
            
            // Adapte a lógica para verificar se a data está dentro do intervalo selecionado
            DateTime dateTime = DateTime.parse(breeds[index].createdAt);
            dateTime = dateTime.subtract(Duration(hours: 3));

            if ((selectedDay == null || dateTime.day == selectedDay) &&
                (selectedMonth == null || dateTime.month == selectedMonth) &&
                (selectedYear == null || dateTime.year == selectedYear)) {
              String formattedDateTime = DateFormat('HH:mm').format(dateTime) +
                  ' do dia ' +
                  DateFormat('dd/MM/yyyy').format(dateTime);
              
              return Acessos(
                context,
                breeds[index].foto,
                breeds[index].nome,
                breeds[index].email,
                breeds[index].tipo,
                formattedDateTime,
                filterBy
              );
            } else {
              return Container(); // Não exibe se a data não estiver no intervalo selecionado
            }
            
          },
          
        );
        
      }
      
    }

    return MaterialApp(
      localizationsDelegates: [

      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: Scaffold(
        body: Column(
          children: [
            Enfeites(),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown para ordenar

                if (userCredential == 1)
                  Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    height: 65,
                    child: DropdownButton<String>(
                      value: filterBy,
                      onChanged: (value) {
                        setState(() {
                          filterBy = value!;
                          if (filterBy == 'Todo mundo') {
                            // Se a opção for "Todo mundo", defina sortBy como 'Recentes'
                            sortBy = 'Recentes';
                            fetchDataForAllUsers();
                          } else {
                            fetchData(); // Chama fetchData se outra opção for selecionada
                          }
                        });
                      },
                      items: ['Seus acessos', 'Todo mundo'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      isExpanded: true,
                    ),
                  ),

                if (filterBy != 'Todo mundo')
                Showcase(
    key: _one,
    description: 'Você pode filtrar seus acessos por um período!',
    overlayOpacity: 0.5,
    targetShapeBorder: const CircleBorder(),
    targetPadding: const EdgeInsets.all(3),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: OutlinedButton(
        onPressed: () {
          showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          ).then((pickedDateRange) {
            if (pickedDateRange != null) {
              setState(() {
                // Atualize o intervalo de datas selecionado no seu estado
                startDate = pickedDateRange.start;
                endDate = pickedDateRange.end;
                // Verifique se o usuário selecionou uma data com registros de outras pessoas
                if (filterBy != 'Todo mundo' && userCredential != 1) {
                  // Se não for o usuário administrador (credencial = 1),
                  // filtre os registros apenas da pessoa logada
                  fetchDataByDateRangeForCurrentUser(startDate!, endDate!);
                } else {
                  // Caso contrário, chame a função fetchDataByDateRange com o intervalo de datas selecionado
                  fetchDataByDateRange(startDate!, endDate!);
                }
              });
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today,
                color: Color.fromARGB(255, 36, 64, 25)),
            SizedBox(width: 8), // Espaço entre o ícone e o texto
            // Atualize o texto do botão com base nas datas selecionadas
            Text(
              startDate != null && endDate != null
                  ? 'Início ${DateFormat('dd/MM/yyyy').format(startDate!)} Fim ${DateFormat('dd/MM/yyyy').format(endDate!)}'
                  : 'Selecionar Intervalo de Datas',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  )
                else
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: OutlinedButton(
                      onPressed: () {
                        showDateRangePicker(
                          // barrierColor: Colors.green[800],
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          
                        ).then((pickedDateRange) {
                          if (pickedDateRange != null) {
                            setState(() {
                              // Atualize o intervalo de datas selecionado no seu estado
                              startDate = pickedDateRange.start;
                              endDate = pickedDateRange.end;
                              // Chame a função fetchDataByDateRange com o intervalo de datas selecionado
                              fetchDataByDateRange(startDate!, endDate!);
                            });
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today,
                              color: Color.fromARGB(255, 36, 64, 25)),
                          SizedBox(width: 8), // Espaço entre o ícone e o texto
                          // Atualize o texto do botão com base nas datas selecionadas
                          Text(
                            startDate != null && endDate != null
                                ? 'Início ${DateFormat('dd/MM/yyyy').format(startDate!)} Fim ${DateFormat('dd/MM/yyyy').format(endDate!)}'
                                : 'Selecionar Intervalo de Datas',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
              ],
            ),
            Expanded(
              child: getContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class DogBreed {
  final int? id; // Altere para int?
  final String nome;
  final String email;
  final String foto;
  final String createdAt;
  final String tipo;

  DogBreed({
    required this.id,
    required this.nome,
    required this.email,
    required this.foto,
    required this.createdAt,
    required this.tipo,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
        id: json['id'] as int?,
        nome: json['nome'] as String,
        email: json['email'] as String,
        foto: json['foto'] as String,
        createdAt: json['createdAt'] as String? ?? '',
        tipo: json['tipo'] as String);
  }
}

@override
Widget Enfeites() {
  return SingleChildScrollView(
    
      child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center // Centraliza verticalmente
          ,
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
              text: 'Seus acessos ao LabMaker',
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 36, 64, 25),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 11),
      ]));
}

Widget Acessos(BuildContext context, String imagem, String nome, String vinculo,
    String estado, String hora, String filterBy) {
      
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    child: Wrap(
      alignment: WrapAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            imagem,
            width: 40.0, // ajuste o tamanho conforme necessário
            height: 40.0, // ajuste o tamanho conforme necessário
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 0.55 * MediaQuery.of(context).size.width,
          child: // Espaçamento entre a imagem e o texto
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: GoogleFonts.oswald(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                vinculo,
                style: GoogleFonts.oswald(
                  color: const Color.fromARGB(255, 118, 118, 118),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [
                Text(
                  estado,
                  style: GoogleFonts.oswald(
                    color: estado == 'Entrou' ? Colors.green[800] : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' às $hora',
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
            ],
          ),
        ),

        if (filterBy == 'Todo mundo')
          Container(
            width: 0.2 * MediaQuery.of(context).size.width,
            height: 60,
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navegar para a HomePage quando o ícone de perfil for clicado
                    
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerAcessoAdm(vinculo: vinculo), //Depois eu volto para ValidacoesScreen()
                                  ),
                                );

                  },
                  child: Icon(
                    Icons.double_arrow_sharp,
                    size: 35.0,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 5),
        Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: 1,
        )
      ],
    ),
  );
}

