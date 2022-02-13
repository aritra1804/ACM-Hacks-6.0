
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controllers/buy_animals.dart';
import '../../../models/cow_model.dart';

class AnimalDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Animaldetails>>(
          future: BuyAnimal.getAnimalData(),
          builder: (context, snapshot) {
            final animal = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return Animal(animal);
                }
            }
          }),
    );
  }

  Widget Animal(List<Animaldetails>? animal) => ListView.builder(
      shrinkWrap: true,
      itemCount: animal?.length,
      itemBuilder: (context, index) {
        final animals = animal![index];
        return SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              color: Colors.white10,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Image.network(
                      animals.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      animals.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price ₹" + animals.price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.chat),),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
