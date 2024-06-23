// import 'dart:typed_data';

// import 'package:artes/components/timer_widget.dart';
// import 'package:artes/models/words_model.dart';
// import 'package:flutter/material.dart';
// import 'package:neubrutalism_ui/neubrutalism_ui.dart';

// class OfflineDiscoverPage extends StatefulWidget {
//   const OfflineDiscoverPage({super.key});

//   @override
//   State<OfflineDiscoverPage> createState() => _OfflineDiscoverPageState();
// }

// class _OfflineDiscoverPageState extends State<OfflineDiscoverPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   late List<TextEditingController> _controllers;
//   bool isKeyboardOpen = false;
//   var future;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _controllers = List.generate(3, (index) => TextEditingController());
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging == false) {
//         setState(() {});
//       }
//     });
//     future = getData();
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             const Text(
//               'Tempo Restante: ',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             TimerWidget(
//               duration: 30,
//               size: 30,
//               onTimerEnd: () {
//                 for (var controller in _controllers) {
//                   WordsModel.instance.addResponse(controller.text);
//                 }
//                 Navigator.of(context).pushNamed('/timesOver');
//               },
//             ),
//           ],
//         ),
//         bottom: TabBar(
//           indicatorColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           labelColor: Colors.black,
//           dividerColor: Colors.transparent,
//           controller: _tabController,
//           tabs: const [
//             Tab(icon: Icon(Icons.looks_one)),
//             Tab(icon: Icon(Icons.looks_two)),
//             Tab(icon: Icon(Icons.looks_3)),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: List<Widget>.generate(3, (index) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 FutureBuilder<Uint8List>(
//                   future:
//                       future, // Assumindo que getData() retorna Future<Uint8List>
//                   builder: (BuildContext context,
//                       AsyncSnapshot<Uint8List> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(
//                           child:
//                               CircularProgressIndicator()); // Mostra um loader enquanto espera
//                     } else if (snapshot.hasError) {
//                       return Text('Erro: ${snapshot.error}'); // Trata erros
//                     } else {
//                       // Quando temos os dados, exibe a imagem
//                       return NeuCard(
//                         cardWidth: double.infinity,
//                         cardHeight: 500,
//                         cardColor: Colors.white,
//                         child: Image.memory(snapshot.data!),
//                       );
//                     }
//                   },
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 30),
//                   child: Text(
//                     'Descubra o que é...',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//       bottomSheet: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.only(
//             right: 16,
//             left: 16,
//             bottom: isKeyboardOpen == false ? 30 : 0,
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: NeuSearchBar(
//                   searchController: _controllers[_tabController.index],
//                   leadingIcon: const Icon(Icons.chat),
//                   searchBarColor: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   hintText: 'Insira o nome do objeto',
//                 ),
//               ),
//               const SizedBox(width: 16),
//               NeuIconButton(
//                 borderRadius: BorderRadius.circular(50),
//                 enableAnimation: true,
//                 icon: const Icon(Icons.send),
//                 buttonColor: Colors.white,
//                 buttonWidth: 50,
//                 buttonHeight: 50,
//                 onPressed: () {
//                   if (_tabController.index < _tabController.length - 1) {
//                     _tabController.animateTo(_tabController.index + 1);
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> getData() async {
//     Uint8List data;
//     data = await WordsModel.instance.getData();
//     return data;
//   }
// }
