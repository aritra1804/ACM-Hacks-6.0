import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/animal_model.dart';
import '../../screens/BuyAnimal/buy_animal_details.dart';


class BuyAnimals extends StatefulWidget {
  const BuyAnimals({Key? key}) : super(key: key);

  @override
  _BuyAnimalsState createState() => _BuyAnimalsState();
}

class _BuyAnimalsState extends State<BuyAnimals> {
  @override
  void initState() {
    super.initState();
    loadData();
  }
  loadData() async{
    await Future.delayed(Duration(seconds: 2));
    final animals= await rootBundle.loadString("assets/files/animals.json");
    final decodeData=jsonDecode(animals);
    var animaldata=decodeData["animals"];
    AnimalModel.animals=List.from(animaldata).map<Animal>((e) => Animal.fromJson(e)).toList();
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('पशु खरिदिये'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(26),
        child: (AnimalModel.animals != null&& AnimalModel.animals.isNotEmpty)?
            GridView.builder(
              
                 itemCount: AnimalModel.animals.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder:(context,index){
                   final animals=AnimalModel.animals[index];
                   return Card(
                     clipBehavior: Clip.antiAlias,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                     child: GridTile(
                       header: Container(
                           alignment: Alignment.center,
                           color: Colors.white12,
                           child: Text(animals.name)),

                         child: GestureDetector (
                           onTap: (){
                           //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimalDetails()));
                           Get.to(AnimalDetails()); 
                           },
                           child: Image.network(animals.image,))
                     ),
                   );
                }
            )
            : Center(
          child: CircularProgressIndicator(),
    ),

      ),

    );
  }
}
